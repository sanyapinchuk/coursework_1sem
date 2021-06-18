program Coursework;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {Form1},
  UserFind in 'UserFind.pas' {Form2},
  AddFile in 'AddFile.pas' {Form6},
  AditionalUnit in 'AditionalUnit.pas',
  TestFind in 'TestFind.pas',
  Graphics in 'Graphics.pas' {Form8};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm8, Form8);
  Application.Run;
end.
