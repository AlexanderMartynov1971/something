unit fm_TestForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fm_MDIChild, RzPanel, ExtCtrls, RzButton, cxGraphics, cxCustomData,
  cxStyles, cxTL, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, DB, dxmdaset,
  cxControls, cxInplaceContainer, dxSkinscxPCPainter, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit,
  ADODB, StdCtrls, cxCurrencyEdit, Menus, cxLookAndFeelPainters, cxButtons,
  cxContainer, cxMemo, cxMaskEdit, cxDropDownEdit, cxCalendar, cxImage, OleCtnrs,
  cxSplitter;

type
  TfmTestForm = class(TfmMDIChild)
    RzToolbar: TRzToolbar;
    RzPanel1: TRzPanel;
    BtnExecute: TRzToolButton;
    tResult: TdxMemData;
    DSResult: TDataSource;
    Label1: TLabel;
    btRecalc: TcxButton;
    edDate: TcxDateEdit;
    edUSA: TcxCurrencyEdit;
    Label2: TLabel;
    Label3: TLabel;
    edEURO: TcxCurrencyEdit;
    Panel1: TPanel;
    cxTreeList: TcxTreeList;
    cxTreeListcxTreeListName: TcxTreeListColumn;
    cxTreeListcxTreeListRub: TcxTreeListColumn;
    cxTreeListcxTreeListDolars: TcxTreeListColumn;
    cxTreeListcxTreeListEuro: TcxTreeListColumn;
    cxSplitter: TcxSplitter;
    Panel2: TPanel;
    btExcel: TRzToolButton;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    grResult: TcxGrid;
    grResultDBTV: TcxGridDBTableView;
    grResultLVL: TcxGridLevel;
    Panel3: TPanel;
    Label4: TLabel;
    OleContainer: TOleContainer;
    cxSplitter1: TcxSplitter;
    procedure cxTreeListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure tResultAfterScroll(DataSet: TDataSet);
    procedure btExcelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btRecalcClick(Sender: TObject);
    procedure cxTreeListEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure cxTreeListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure cxTreeListCustomDrawCell(Sender: TObject; ACanvas: TcxCanvas;
      AViewInfo: TcxTreeListEditCellViewInfo; var ADone: Boolean);
    procedure cxTreeListExpanding(Sender: TObject; ANode: TcxTreeListNode;
      var Allow: Boolean);
    procedure cxTreeListExpanded(Sender: TObject; ANode: TcxTreeListNode);
    procedure cxTreeListCollapsed(Sender: TObject; ANode: TcxTreeListNode);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnExecuteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure CreateTL1(tl: TcxTreeList; q: TDataSet);
    function GetNodeFromData(tl: TcxTreeList; ParentId: Integer): TcxTreeListNode;
    procedure CreateClumns(tv: TcxGridDBTableView);
    procedure SetImageIndex(tl: TcxTreeList);
    function GetKurs(AID, AXML: string): Variant;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure CreateXMLData(q: TDataSet);
    procedure ReCalckNodes(tl: TcxTreeList);
    procedure LoadXMLData;
    procedure LoadServerData;
  public
    { Public declarations }
  end;

  function OpenTestForm(AId: Variant): TfmTestForm;

implementation

uses NativeXML, ShellAPI, dm_Data, fm_maintest;

{$R *.dfm}

function OpenTestForm(AId: Variant): TfmTestForm;
begin
  Result:=nil;
  if not Assigned(Result) then
  with dmData.CreateQuery do
   try
    { }
    Result:= TfmTestForm.Create(Application);
   finally
    Free;
   end;
end;

procedure TfmTestForm.btExcelClick(Sender: TObject);
begin
  inherited;
  dmData.ExportTreeListToExcel(cxTreeList, '����');
end;

procedure TfmTestForm.BtnExecuteClick(Sender: TObject);
begin
  if dmData.FConnFlag then
   LoadServerData
  else
   LoadXMLData;
  if tResult.Active and not tResult.IsEmpty then
  begin
   CreateXMLData(tResult);
   CreateTL1(cxTreeList, tResult);
   CreateClumns(grResultDBTV);
  end;
end;

procedure TfmTestForm.LoadServerData;
var
  IsTable: Boolean;
begin
  with dmData.CreateQuery do
   try
    SQL.Add('Set NoCount On');
    Sql.Add('If (Object_Id('+QuotedStr('tempdb..#tree')+') Is NULL) Begin ' +
              'Truncate Table #tree End');
    try
      ExecSql;
      IsTable:=True;
    except
      IsTable:=False;
    end;
    if not IsTable then
    begin
     Sql.Clear;
     SQL.Add('Create Table #tree (id int, parent_id int, name varchar(40), price money)');
     SQL.Add('Insert #tree Values');
     SQL.Add('(1, 0, '+QuotedStr('������ 1')+', 100.),');
     SQL.Add('(2, 1, '+QuotedStr('������ 2')+', 200.),');
     SQL.Add('(3, 1, '+QuotedStr('������ 3')+', 300.),');
     SQL.Add('(4, 2, '+QuotedStr('��������� 4')+', 400.),');
     SQL.Add('(5, 3, '+QuotedStr('��������� 5')+', 350.),');
     SQL.Add('(6, 4, '+QuotedStr('��������� 6')+', 250.),');
     SQL.Add('(7, 6, '+QuotedStr('��������� 7')+', 150.)');
     ExecSql;
    end;
    Sql.Clear;
    SQL.Add('Select t1.* From #tree t1 Order By t1.id');
    Open;
    tResult.DisableControls;
    tResult.Open;
    tResult.CopyFromDataSet(dmData.LastQuery);
    tResult.First;
    tResult.EnableControls;
   finally
    Free;
   end;
end;

procedure TfmTestForm.CreateXMLData(q: TDataSet);
var
  Node: TXmlNode;
  FileName: string;
begin
  q.First;
  FileName:= ExtractFilePath(ParamStr(0))+'data.xml';
  with TNativeXml.CreateName('goods') do
   try
    Charset:= 'UTF-8';
    while not q.Eof do
     begin
      Node:= Root.NodeNew('item'+q.FieldByName('id').AsString);
      Node.AttributeAdd('id', q.FieldByName('id').Value);
      Node.AttributeAdd('parent_id', q.FieldByName('parent_id').Value);
      Node.AttributeAdd('name', AnsiToUtf8(q.FieldByName('name').Value));
      Node.AttributeAdd('price', q.FieldByName('price').Value);
      q.Next;
     end;
   finally
    SaveToFile(FileName);
    Free;
   end;
end;

procedure CreateField(AMemData: TDataSet; AFieldName: string; AFieldType: TFieldType);
begin  
  with AMemData.FieldDefs.AddFieldDef do
  begin
   Name:= AFieldName;
   DataType:= AFieldType;
   CreateField(AMemData);
  end;
end;

procedure TfmTestForm.LoadXMLData;
var
  XMLDoc: TNativeXml;
  FileName: string;
  i: Integer;
begin
  tResult.Close;
  if (tResult.FieldDefs.Count = 0) then
  begin
   CreateField(tResult, 'id',ftInteger);
   CreateField(tResult, 'parent_id',ftInteger);
   CreateField(tResult, 'name',ftString);
   CreateField(tResult, 'price',ftCurrency);
  end;
  tResult.Open;
  tResult.SortedField:= 'id';
  FileName:= ExtractFilePath(ParamStr(0))+'data.xml';
  XMLDoc:= TNativeXml.Create(nil);
  with tResult do
  try
   XMLDoc.LoadFromFile(FileName);
    DisableControls;
    for i:= 0 to Pred(XMLDoc.Root.NodeCount) do
    begin
     Insert;
     FieldByName('id').AsInteger:= XMLDoc.Root.Nodes[i].ReadAttributeInteger('id');
     FieldByName('parent_id').AsInteger:= XMLDoc.Root.Nodes[i].ReadAttributeInteger('parent_id');
     FieldByName('name').AsString:= XMLDoc.Root.Nodes[i].ReadAttributeAnsiString('name');
     FieldByName('price').AsCurrency:= XMLDoc.Root.Nodes[i].ReadAttributeFloat('price');
   end;
  finally
   First;
   EnableControls;
   XMLDoc.Free;
  end;
end;

function TfmTestForm.GetNodeFromData(tl: TcxTreeList; ParentId: Integer): TcxTreeListNode;
var
  Node: TcxTreeListNode;
begin
  Result := nil;
  with tl do
  begin
    if Count = 0 then
      Exit;
    Node:= Items[0];
    while Assigned(Node) do
    begin
     if Integer(Node.Data) = ParentId then
     begin
      Result:= Node;
      Break;
     end;
     Node:= Node.GetNext;
    end;
  end;
end;

procedure TfmTestForm.CreateTL1(tl: TcxTreeList; q: TDataSet);
var
  Node: TcxTreeListNode;
begin
  with tl do
  begin
   BeginUpdate;
   Nodes.Clear;
   Node:= Add;
   Node.ImageIndex:= 8;
   Node.Texts[0]:= '�����';
   q.First;
   with q do
    try
     while not Eof do
     begin
      Node:= AddChild(GetNodeFromData(tl, FieldByName('parent_id').AsInteger), Pointer(FieldByName('id').AsInteger));
      Node.Values[0]:= FieldByName('name').AsString;
      Node.Values[1]:= FieldByName('price').AsCurrency;
      Node.Values[2]:= FieldByName('price').AsCurrency*edEURO.Value;
      Node.Values[3]:= FieldByName('price').AsCurrency*edUSA.Value;
      Node.ImageIndex:= 8;
      Next;
     end;
    finally
     SetImageIndex(tl);
     FullExpand;
     EndUpdate;
     First;
    end;
  end;
end;

procedure TfmTestForm.ReCalckNodes(tl: TcxTreeList);
var
  Node: TcxTreeListNode;
begin
  with tl do
   try
    BeginUpdate;
    Node:= TopNode;
    while Assigned(Node) do
     begin
      Node.Values[2]:= Node.Values[1]*edEURO.Value;
      Node.Values[3]:= Node.Values[1]*edUSA.Value;
      Node:= Node.GetNext;
     end;
   finally
    EndUpdate;
   end;
end;

procedure TfmTestForm.SetImageIndex(tl: TcxTreeList);
var
  Node: TcxTreeListNode;
begin
  with tl do
  begin
   BeginUpdate;
   Node:= TopNode;
   while Assigned(Node) do
   begin
    if not Node.HasChildren then
    begin
     Node.ImageIndex:= 10;
     Node.SelectedIndex:= 10;
    end else
    begin
     Node.ImageIndex:= 8;
     Node.SelectedIndex:= 8;
    end;
    Node:= Node.GetNext;
   end;
   EndUpdate;
  end;
end;

procedure TfmTestForm.tResultAfterScroll(DataSet: TDataSet);
begin
  cxTreeList.BeginUpdate;
  try
   cxTreeList.Repaint;
  finally
   cxTreeList.EndUpdate;
   dmData.Tl:= cxTreeList;
   dmData.SetHintTimer;
  end;
end;

procedure TfmTestForm.btRecalcClick(Sender: TObject);
var
  q, sxml: string;
begin
  inherited;
  if not dmData.CheckConnectionInternet('https://www.cbr.ru/') then
  begin
   Exit;
  end;
  q:= 'date_req='+FormatDateTime('dd/mm/yyyy',edDate.Date);
  sxml:= dmData.RequestPost('scripts/XML_daily.asp?'+AnsiToUtf8(q), '', 'GET');
  edUSA.Value:= GetKurs('R01235', sxml);
  edEURO.Value:= GetKurs('R01239', sxml);
  ReCalckNodes(cxTreeList);
end;

function TfmTestForm.GetKurs(AID, AXML: string): Variant;
var
  XMLDoc: TNativeXml;
  i: Integer;
begin
  Result:= 0.0000;
  XMLDoc:= TNativeXml.Create(nil);
  try
   if (AXML <> '') then
   begin
    XMLDoc.ReadFromString(AXML);
    for i:= 0 to Pred(XMLDoc.Root.NodeCount) do
    begin
     if (XMLDoc.Root.Nodes[i].ReadString('ID') = AID) then
      Result:= XMLDoc.Root.Nodes[i].FindNode('Value').value
    end;
   end;
  finally
   XMLDoc.Free;
  end;
end;

procedure TfmTestForm.cxTreeListCollapsed(Sender: TObject;
  ANode: TcxTreeListNode);
begin
  inherited;
  if ANode.ImageIndex = 8
    then ANode.ImageIndex:=9;
  ANode.SelectedIndex:= ANode.ImageIndex;
end;

procedure TfmTestForm.cxTreeListCustomDrawCell(Sender: TObject;
  ACanvas: TcxCanvas; AViewInfo: TcxTreeListEditCellViewInfo;
  var ADone: Boolean);
begin
  if (AViewInfo.Column = cxTreeListcxTreeListName) and
     (AViewInfo.Node.ImageIndex in [8, 9])
    then begin
     ACanvas.Font.Style:= [fsBold];
    end;

  if ((Integer(AViewInfo.Node.Data) = tResult.FieldByName('id').Value)) and
     dmData.tmHint.Enabled
    then begin
     ACanvas.Brush.Color:= $00FFFF9D;
     //ACanvas.Font.Color:= clBlack;
    end;
end;

procedure TfmTestForm.cxTreeListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  TargetNode, DragNode: TcxTreeListNode;
begin
  TargetNode:= (Sender as TcxTreeList).GetNodeAt(X, Y);
  DragNode:= (Sender as TcxTreeList).Selections[0];
  if tResult.Locate('id', Integer(DragNode.Data), []) then
  begin
   tResult.Edit;
   tResult.FieldByName('parent_id').Value:= Integer(TargetNode.Data);
   tResult.Post;
  end;
  grResultDBTV.BeginUpdate;
  grResultDBTV.DataController.Refresh;
  grResultDBTV.EndUpdate;
end;

procedure TfmTestForm.cxTreeListDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  inherited;
  {...}
end;

procedure TfmTestForm.cxTreeListEndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  inherited;
  SetImageIndex(TcxTreeList(Sender));
end;

procedure TfmTestForm.cxTreeListExpanded(Sender: TObject;
  ANode: TcxTreeListNode);
begin
  inherited;
  if ANode.ImageIndex = 9
    then ANode.ImageIndex:=8;
  ANode.SelectedIndex:= ANode.ImageIndex;
end;

procedure TfmTestForm.cxTreeListExpanding(Sender: TObject;
  ANode: TcxTreeListNode; var Allow: Boolean);
begin
  inherited;
    if ANode.HasChildren and (ANode.GetFirstChild.Data = nil) then
     ANode.ImageIndex:= 10;
end;

procedure TfmTestForm.CreateClumns(tv: TcxGridDBTableView);
begin
  with tv do
   begin
    BeginUpdate;
    ClearItems;
    DataController.CreateAllItems;
    EndUpdate;
   end;
end;

procedure TfmTestForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  {...}
end;

procedure TfmTestForm.FormCreate(Sender: TObject);
begin
  Self.Caption:= '�������� �����'+'-'+FormatDateTime('dd.mm.yyyy hh:mm:ss', Now());
  inherited;
  edDate.Date:= Date();
  DragAcceptFiles(Handle, true);
end;

procedure TfmTestForm.FormDestroy(Sender: TObject);
begin
  inherited;
  DragAcceptFiles(Handle, False);
end;

procedure TfmTestForm.WMDropFiles(var Msg: TWMDropFiles);
var
  hw: HDROP;
  ac: array[0..100] of Char;
  fn: string;
begin
  Screen.Cursor:= crHourGlass;
  try
   hw:= Msg.Drop;
   DragQueryFile(hw, 0, ac, 100);
   fn:= string(ac);
   if not (OleContainer.State = osEmpty)  then
    OleContainer.DestroyObject;
   OleContainer.CreateObjectFromFile(fn, false);
   DragFinish(hw);
  finally
   Msg.Result:= 0;
   Screen.Cursor:= crDefault;
  end;
end;

end.
