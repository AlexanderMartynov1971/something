program test_app;

uses
  Forms,
  fm_maintest in 'fm_maintest.pas' {fmMainTest},
  dm_Data in 'dm_Data.pas' {dmData: TDataModule},
  fm_MDIChild in 'fm_MDIChild.pas' {fmMDIChild},
  fm_TestForm in 'fm_TestForm.pas' {fmTestForm},
  fm_Camera in 'fm_Camera.pas' {fmCamera},
  uThread in 'uThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMainTest, fmMainTest);
  Application.CreateForm(TdmData, dmData);
  Application.Run;
end.
