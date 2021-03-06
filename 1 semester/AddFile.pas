unit AddFile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AditionalUnit, Vcl.ExtCtrls;

type
  TForm6 = class(TForm)
    AssignDefoltButton: TButton;
    FillFileButton: TButton;
    NewNameEdit: TEdit;
    NewNameLabel: TLabel;
    AssignNameButton: TButton;
    ResultPanel: TPanel;
    OpenButton: TButton;
    OpenDialog1: TOpenDialog;
    InstrumentsPanel: TPanel;
    SettingsPanel: TPanel;
    procedure AssignNameButtonClick(Sender: TObject);
    procedure AssignDefoltButtonClick(Sender: TObject);
    procedure FillFileButtonClick(Sender: TObject);
    procedure OpenButtonClick(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

   function CheckValidFile (): boolean;
    var temp_file: TDataBase;
    t1,t2: integer;
     begin
       if FileExists('C:\Users\Asus\Desktop\MyCourseWork\1 semester\Documents\???????\check_valid.txt') then
         begin
           AssignFile(temp_file,'C:\Users\Asus\Desktop\MyCourseWork\1 semester\Documents\???????\check_valid.txt');
           reset(temp_file);
           reset(initial_file);
           t1:=filesize(temp_file);
           t2:=filesize(initial_file);
           if t1=t2 then result:= true
            else result:= false;
           close(temp_file);
         end;
     end;

   procedure Fill_Initial_File (var initial_database : TDataBase);
    var
      initial_str,str : string;
      first,last,i,j,k,counter: integer;
      temp: Type_struct;
      begin
        randomize;
        rewrite(initial_database);
        first:= ord('a');
        last:= ord('z');
        i:= first;
        counter:= 0;
       while (counter<N_REC) do
         begin
            j:= first;
            while(j<=last) and(counter<N_REC)  do
              begin
                str:=chr(i)+chr(j);
                for k := 0 to 9999 do
                   begin                            //(a..d)+(a..z)+(0000..9999)   (l?st dv)
                     initial_str:=IntToStr(k);
                     while (length(initial_str)<4) do
                       insert('0',initial_str,1);
                     initial_str:= str+initial_str;
                     temp.key:= initial_str;
                     temp.count_days:= random(1000);
                     temp.Country:=TCountries[random(23)];
                     write(initial_database,temp);
                     inc(counter);
                   end;
               inc(j);
              end;
           inc(i);
         end;
        Close(initial_database);
      end;

   function CheckValidName(const name : string): boolean;
    var i : integer;
        badsimbol: boolean;
    begin
      i:=1;
      badsimbol:= false;
      if name = '' then  badsimbol:= true;
      while ((i<= length(name)) and (not BadSimbol)) do
        begin
          if not( (name[i] in ['A'..'Z']) or (name[i] in ['a'..'z']) or
             (name[i] = '_') or (name[i] in ['?'..'?']) or (name[i] in ['0'..'9'])
             or (name[i] in ['?'..'?']) ) then
          BadSimbol:= true;
          inc(i);
        end;
      result:=  not badsimbol;
    end;

  procedure TForm6.AssignDefoltButtonClick(Sender: TObject);
    begin
      AssignNameButton.Visible:= false;
      NewNameLabel.Visible:= false;
      NewNameEdit.Visible:= false;
      if FileExists('C:\Users\Asus\Desktop\MyCourseWork\1 semester\Documents\???????\initial_file.txt') then
        begin
          AssignFile(initial_file,'C:\Users\Asus\Desktop\MyCourseWork\1 semester\Documents\???????\initial_file.txt');
          ResultPanel.Font.Color:= clGreen;
          IsAddFile:= true;
          ResultPanel.Caption:='File loaded';
        end
      else
        begin
          ResultPanel.Caption:='Defolt database was damaged';
        end;
    end;

  procedure TForm6.AssignNameButtonClick(Sender: TObject);
   var
    name : string;
    begin
      if CheckValidName(NewNameEdit.Text)  then
        begin
          name:= NewNameEdit.Text + '.txt';
          AssignFile(initial_file,name);
          Fill_Initial_File(initial_file);
          ResultPanel.Font.Color:= clGreen;
          ResultPanel.Caption:='File loaded';
          IsAddFile:= true;
        end
      else
        showmessage('Enter currectly name');
    end;

  procedure TForm6.FillFileButtonClick(Sender: TObject);
    begin
      NewNameEdit.Visible:= true;
      NewNameLabel.Visible:= true;
      AssignNameButton.Visible:= true;
    end;

  procedure TForm6.OpenButtonClick(Sender: TObject);
    var addr: string;
    begin
      AssignNameButton.Visible:= false;
      NewNameLabel.Visible:= false;
      NewNameEdit.Visible:= false;
      if OpenDialog1.Execute then
        begin
          addr:= OpenDialog1.FileName;
          AssignFile(initial_file,addr);
          if CheckValidFile then
            begin
              ResultPanel.Font.Color:= clGreen;
              ResultPanel.Caption:='File loaded';
              IsAddFile:= true;
            end
          else
            begin
              ResultPanel.Font.Color:= clRed;
              ResultPanel.Caption:='Not Currectly File';
            end;
        end;
    end;

end.
