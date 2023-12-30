unit dm_Data;

interface

uses
  SysUtils, Classes, Windows, Messages, Dialogs,
  DB, ImgList, Controls, Forms, Variants, ADODB,
  cxTL, cxCalc, ExtCtrls, cxContainer, cxEdit, cxHint, cxStyles,
  ExIniFile, StrUtils, IdCoder, IdCoder3to4, IdCoderMIME, IdBaseComponent;

type
  PVariantDynArray = ^ TVariantDynArray;
  TVariantDynArray = array of Variant;

  TLoginUser = record
    DbPassword, DbUser: string;
    DbName: string;
    DbServer: string;
  end;

type
  TdmData = class(TDataModule)
    ADOConn: TADOConnection;
    imMenu24Disabled: TImageList;
    imMenu24: TImageList;
    im16: TImageList;
    tmHint: TTimer;
    cxStyleRepository: TcxStyleRepository;
    stCategory: TcxStyle;
    stGroupRow: TcxStyle;
    stSelected: TcxStyle;
    stCaption: TcxStyle;
    stImportant: TcxStyle;
    stReadOnly: TcxStyle;
    stGroupByBox: TcxStyle;
    stSelectedBlack: TcxStyle;
    stSilver: TcxStyle;
    stFillTabel: TcxStyle;
    stOrgFooter: TcxStyle;
    stBold: TcxStyle;
    stBoldNavy: TcxStyle;
    stBold14: TcxStyle;
    stYeadHoliday: TcxStyle;
    stRouse: TcxStyle;
    stclSkyBlue: TcxStyle;
    stMedSister: TcxStyle;
    stBlackText: TcxStyle;
    cxStyle9: TcxStyle;
    IdDecoderMIME: TIdDecoderMIME;
    IdEncoderMIME: TIdEncoderMIME;
    procedure tmHintTimer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    FHintTimerStartTick: Cardinal;
    function GetADOConnection: Boolean;
  public
    FConnFlag: Boolean;
    LastQuery: TAdoQuery;
    Tl: TcxTreeList;
    function CreateQuery(): TAdoQuery;
    function VarIsAssigned(Value: Variant): Boolean;
    function CheckConnectionInternet(AURL: PAnsiChar): Boolean;
    function RequestPost(AUrl, AData, sMethod: AnsiString): AnsiString;
    procedure ExportTreeListToExcel(tl: TcxTreeList; ACaption: string);
    procedure SetHintTimer(CloseTime: Integer = 2000);
  end;

procedure ShowForm(AFormClass: TFormClass; var AForm; AModal: Boolean = False);

const
  FLAG_ICC_FORCE_CONNECTION = 1;

var
  dmData: TdmData;
  LoginUser: TLoginUser;

implementation

uses ComObj, fm_maintest,
     WinInet, ADOConEd, Excel2000;

{$R *.dfm}

procedure ShowForm(AFormClass: TFormClass; var AForm; AModal: Boolean = False);
begin
  if TForm(AForm) <> nil then
  begin
    if TForm(AForm).WindowState = wsMinimized
      then TForm(AForm).WindowState:=wsNormal;
    TForm(AForm).BringToFront
  end

 else
   try
     Screen.Cursor:=crHourGlass;
     TForm(AForm):=AFormClass.Create(Application);
     with TForm(AForm) do
       if AModal then ShowModal else Show;
   finally
     Screen.Cursor:=crDefault
   end
end;


function TdmData.VarIsAssigned(Value: Variant): Boolean;
begin
  Result:=not(VarIsNull(Value) or VarIsEmpty(Value))
end;

function TdmData.CreateQuery(): TADOQuery;
begin
  Result:=TADOQuery.Create(Self);
  Result.Connection:=ADOConn;
  LastQuery:=Result
end;

procedure TdmData.DataModuleCreate(Sender: TObject);
begin
  FConnFlag:= GetADOConnection;
end;

function TdmData.GetADOConnection: Boolean;
var
  Ini: TExIniFile;
  CSItems: TStringList;
  i: Integer;
  ConnStr, ConnStr1: string;
  v: TVariantDynArray;
  is_exist_file: Boolean;
begin
  is_exist_file:= FileExists(ChangeFileExt(ParamStr(0),'.ini'));
  ConnStr:= '';
  if not is_exist_file then
  begin
   if (MessageBox(0, PAnsiChar('Не найден файл настроек соединения с БД.'+#13#10+'Хотите создать?'),
       PAnsiChar('Внимание'), MB_YESNO+MB_ICONQUESTION) = IDYES) then
   begin
    if EditConnectionString(ADOConn) then
     if (ADOConn.ConnectionString <> '') then
     begin
      CSItems:= TStringList.Create;
      CSItems.StrictDelimiter:= True;
      CSItems.Delimiter:= ';';
      CSItems.DelimitedText:= ADOConn.ConnectionString;
      SetLength(v, CSItems.Count);
      for i:= 0 to Pred(CSItems.Count) do         // это меня - занесло
       v[i]:=CSItems[i];
     end;
   end;
  end;

  ini:= TExIniFile.Create(ChangeFileExt(ParamStr(0),'.ini'));
  try
   if not is_exist_file then
   begin
    for i:=Low(v) to High(v) do
     ConnStr:= ConnStr + IfThen(ConnStr <> '',';', '') + v[i];
    if (ConnStr <> '') then
    begin
     ConnStr1:= IdEncoderMIME.Encode(ConnStr);
     Ini.WriteString('CONNECTION', 'str', ConnStr1, '');
    end;
   end else
   begin
    ConnStr1:= Ini.ReadString('CONNECTION', 'str', '');
    ConnStr:= IdDecoderMIME.DecodeString(ConnStr1);
   end;
  finally
   Ini.Free;
  end;

  Result:= True;
  try
   ADOConn.ConnectionString:= ConnStr;
   ADOConn.Connected:= True;
  except
   on E: EOleException do
   begin
     ShowMessage(E.ClassName + #13#10 + E.Message + #13#10 + SysErrorMessage(GetLastError) + #13#10 +
     'Загрузка данных будет с локального источника.');
     Result:= False;
   end;
  end;
  if (not Result) and FileExists(ChangeFileExt(ParamStr(0),'.ini')) then
   DeleteFile(PAnsiChar(ChangeFileExt(ParamStr(0),'.ini')));
  Finalize(v);

  if (not Result) and (not FileExists(ExtractFilePath(ParamStr(0))+'data.xml')) then
  begin
   MessageBox(0, PAnsiChar('Не найден файл локальных данных '+#13#10+
   ExtractFilePath(ParamStr(0))+'data.xml'+#13#10+'Программа будет закрыта'),
       PAnsiChar('Внимание'), MB_APPLMODAL or MB_ICONWARNING or MB_OK);
   fmMainTest.Close;
  end;
end;

function TdmData.CheckConnectionInternet(AURL: PAnsiChar): Boolean;
begin
  Result:= False;
  Screen.Cursor:= crHourGlass;
  Result:= InternetCheckConnection(AURL, FLAG_ICC_FORCE_CONNECTION, 0);
  Screen.Cursor:= crDefault;
  if not Result then
   MessageBox(0, PAnsiChar('Сеть'),
       PAnsiChar('Нет подключения к '+AURL+#13#10'+Попробуйте позже.'), MB_APPLMODAL or MB_ICONWARNING or MB_OK)
end;

procedure SetHeader(pReq: HINTERNET; Mode: integer);
var
  Header: TStringStream;
begin
  Header:= TStringStream.Create('');
  try
   with Header do
    begin
     case Mode of
     0: begin
         WriteString('Accept: text/xml,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'+SLineBreak);
         WriteString('Accept-Language: ru,en;q=0.9,en-GB;q=0.8,en-US;q=0.7'+ SLineBreak);
         WriteString('Sec-Fetch-Dest: document'+ SLineBreak);
         WriteString('sec-ch-ua-platform: "Windows"'+ SLineBreak);
         WriteString('Upgrade-Insecure-Requests: 1'+ SLineBreak);
         WriteString('Accept-Encoding: gzip, deflate'+ SLineBreak);
         WriteString('Content-Type: application/xml;charset=utf-8'+ SLineBreak);
         WriteString('User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/119.0.0.0'+ SLineBreak+SLineBreak);
        end;
     1: begin
         WriteString('Content-Type: application/x-www-form-urlencoded'+ SLineBreak);
        end;
     end;
    end;
   HttpAddRequestHeaders(pReq, PChar(Header.DataString), Length(Header.DataString), HTTP_ADDREQ_FLAG_ADD);
  finally
   Header.Free;
  end;
end;

function TdmData.RequestPost(AUrl, AData, sMethod: AnsiString): AnsiString;
var
  flags       : DWord;
  S           : PANSICHAR;
  pSess       : HINTERNET;
  pConn       : HINTERNET;
  pReq        : HINTERNET;
  BufStream: TMemoryStream;
  aBuffer: Array[0..8096] of Char;
  BytesRead: Cardinal;
begin
  Result := '';
  pSess:= InternetOpen(nil, INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if not Assigned(pSess) then
    raise Exception.Create('Ошибка создания сессии InternetOpen' + sLineBreak + SysErrorMessage(GetLastError));
  try
    pConn:= InternetConnect(pSess, PAnsiChar('cbr.ru'),
      INTERNET_DEFAULT_HTTPS_PORT, nil, nil, INTERNET_SERVICE_HTTP, 0, 0);
    if not Assigned(pConn) then
      raise Exception.Create('Ошибка соединения InternetConnect' + sLineBreak + SysErrorMessage(GetLastError));
    try
      flags:= INTERNET_FLAG_SECURE or INTERNET_FLAG_KEEP_CONNECTION;
      S := '*/*'; 
      pReq:= nil;
      try
        pReq:= HTTPOpenRequest(pConn, PAnsiChar(sMethod), PAnsiChar(AUrl), HTTP_VERSION, nil, @S, flags, 0);
        if not Assigned(pReq) then
         raise Exception.Create('Ошибка HttpOpenRequest' + sLineBreak + SysErrorMessage(GetLastError));
        SetHeader(pReq, 1);
        if HTTPSendRequest(pReq, nil, 0, nil, 0) then
        begin
         BufStream:= TMemoryStream.Create;
         try
          while InternetReadFile(pReq, @aBuffer, SizeOf(aBuffer), BytesRead) do
          begin
           if (BytesRead = 0) then Break;
           BufStream.Write(aBuffer, BytesRead);
          end;
          aBuffer[0]:= #0;
          BufStream.Write(aBuffer, 1);
          Result:= PAnsiChar(BufStream.Memory);
         finally
          BufStream.Free;
         end;
        end;
      finally
        InternetCloseHandle(pReq);
      end;
    finally
      InternetCloseHandle(pConn);
    end;
  finally
    InternetCloseHandle(pSess);
  end;
end;

procedure TdmData.SetHintTimer(CloseTime: Integer = 2000);
begin
  with dmData do
  begin
    FHintTimerStartTick:= GetTickCount;
    tmHint.Tag:= CloseTime;
    tmHint.Enabled:= True
  end;
end;

procedure TdmData.tmHintTimer(Sender: TObject);
begin
  with Sender as TTimer do
    if GetTickCount - FHintTimerStartTick >= Tag then
    begin
      Enabled:= False;
      Tl.Repaint;
    end;
end;

procedure TdmData.ExportTreeListToExcel(tl: TcxTreeList; ACaption: string);
var
  Node: TcxTreeListNode;
  ExlApp: OLEVariant;
  i, j, k: Integer;
  S: string;
begin
  if (tl.Nodes.Count = 0) then begin
   Exit;
  end;
  try
   ExlApp:= CreateOleObject('Excel.Application');
   Screen.Cursor:= crHourGlass;
   ExlApp.Visible:= False;
   ExlApp.Workbooks.Add;
   ExlApp.WorkBooks[1].Sheets.Item[1].Activate;
   k:= 1;
   for i:= 1 to tl.ColumnCount do
   begin
    if tl.Columns[i-1].Visible then
    begin
     ExlApp.ActiveWorkBook.ActiveSheet.Cells[1,k].Value:= tl.Columns[i-1].Caption.Text;    //[строка, столбец]
     ExlApp.ActiveWorkBook.ActiveSheet.Cells[1,k].FONT.BOLD:= True;
     ExlApp.ActiveWorkBook.ActiveSheet.Cells[1,k].INTERIOR.COLOR:= RGB(200, 200, 200);   //RGB(200, 200, 200)
     ExlApp.ActiveWorkBook.ActiveSheet.Cells[1,k].ColumnWidth:= 60;
     ExlApp.ActiveWorkBook.ActiveSheet.Cells[1,k].HorizontalAlignment:= xlCenter;
     Inc(k);
    end;
   end;
   ExlApp.ActiveWorkBook.ActiveSheet.Range['A1','A1'].ColumnWidth:= 60;
   //------------------------------------------------------------
   Node:= tl.TopNode;
   j:= 2;
   while Assigned(Node) do
    begin
     k:= 1;
     for i:= 1 to tl.ColumnCount do
     begin
      if tl.Columns[i-1].Visible then
      begin
       if (i = 1) then
        S:= StringOfChar('-', Node.Level*2)
       else
       begin
        S:= '';
       end;
       if not (Node.StateIndex = 10) then
        ExlApp.ActiveWorkBook.ActiveSheet.Cells[j,k].INTERIOR.COLOR:= RGB(255, 255, 255);
        if (i = 1) then
         ExlApp.ActiveWorkBook.ActiveSheet.Cells[j,k].Value:= S + Node.Texts[tl.Columns[i-1].ItemIndex]
        else
         ExlApp.ActiveWorkBook.ActiveSheet.Cells[j,k].Value:= Node.Values[tl.Columns[i-1].ItemIndex];
      end;
      Inc(k);
     end;
     Inc(j);
     Node:= Node.GetNext;
    end;
   //-------------------------------------------------------------
   ExlApp.ActiveSheet.UsedRange.Columns.Borders.LineStyle:=1;
   ExlApp.ActiveSheet.UsedRange.Rows.Borders.LineStyle:=1;
   ExlApp.Range['A1','A1'].Select;
  finally
   ExlApp.DisplayAlerts := False;
   ExlApp.Visible:= True;
   ExlApp:= Unassigned;
   Screen.Cursor:= crDefault;
  end;
end;


end.
