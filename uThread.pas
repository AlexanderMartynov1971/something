unit uThread;

interface

uses
  Classes, SysUtils;

type
  TCamThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Grab;
    procedure Execute; override;
  end;

implementation

uses fm_Camera;

procedure TCamThread.Grab;
begin
  fmCamera.GrabFrame;
end;

procedure TCamThread.Execute;
begin
  while True do
  begin
   Synchronize(Grab);
   Sleep(200);
  end;
end;

end.
