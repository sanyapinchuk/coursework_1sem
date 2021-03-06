unit UserFind;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AditionalUnit, Vcl.Grids,
  Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    SG: TStringGrid;
    Not_found_lab: TLabel;
    End_find: TButton;
    Box_shift: TCheckBox;
    Box_div: TCheckBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    CountTimeFindLabel: TLabel;
    Panel4: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure End_findClick(Sender: TObject);
    procedure Box_shiftClick(Sender: TObject);
    procedure Box_divClick(Sender: TObject);
    procedure EnterPressed(Sender: TObject; var Key: Char);
    procedure ChangeLocationPanel(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;
 //procedure Check_record (const Found_record: type_struct; const elapsed: Cardinal);
var
  Form2: TForm2;

implementation

{$R *.dfm}

  procedure Check_record (const Found_record: type_struct; const elapsed: Cardinal);
 var  s:TGridRect;
      begin
        s.Left:=-1;
        s.Top:=-1;
        s.Right:=-1;
        s.Bottom:=-1;
        Form2.SG.Selection:=s;
        Form2.SG.Visible:= true;
        form2.SG.Cells[0,0]:= 'Unique key';
        form2.SG.Cells[1,0]:= 'Count days';
        form2.SG.Cells[2,0]:= 'Country';
        form2.SG.Cells[0,1]:= Found_record.key;
        form2.SG.Cells[1,1]:= Inttostr(Found_record.count_days);
        form2.SG.Cells[2,1]:= Found_record.country;
        form2.CountTimeFindLabel.Caption:= 'elapsed time '+ inttostr(elapsed)+ ' ms';
        form2.CountTimeFindLabel.Visible:= true;
      end;

  procedure Find_Record (Get_params : T_get_params; Hesh_func : T_Hesh_func; var  my_arr : Files;
                            const packets, records: integer; const KEY_STR: string);
      var i, index,dividor,k : integer;
          str : string;
          temp : Type_struct;
          found : boolean;
          Start,Stop, elapsed: Cardinal;
          param: Pointer;
      begin
        start:= GetTickCount;
        str:= get_ascii_string(KEY_STR);
        Get_params(dividor,param,packets);
        index := Hesh_func(str,dividor,param);
        found := false;
        i:= 0;
        while (not found) and (i< records) do
          begin
           temp:= my_arr[index,i];
           if temp.key= KEY_STR then
             begin
               stop:= GetTickCount;
               elapsed:= stop-start;
               Check_record(temp,elapsed);
               found := true;
             end;
           inc(i);
          end;
          k:=1;
        while not found do
          begin
            if k>0 then
              begin
                if index+k< packets   then
                begin
                  index:= index+k;
                  k:= k*(-1);
                  dec(k);
                end
                else
                 begin
                   dec(index);
                   while (not found) and (index>=0) do
                     begin
                        i:=0;
                        while (not found) and (i< records) do
                          begin

                            temp:= my_arr[index,i];
                            if temp.key= KEY_STR then
                              begin
                                stop:= GetTickCount;
                                elapsed:= stop-start;
                                Check_record(temp,elapsed);
                                found := true;
                              end
                            else inc(i);
                          end;
                       dec(index)
                     end;
                    if not found  then
                      begin
                        Form2.Not_found_lab.Caption:= 'Record not found';
                        form2.Not_found_lab.Visible:= true;
                        form2.CountTimeFindLabel.Visible:= false;
                        found:= true;    // here it's meens not found but finding will terminated
                      end;
                 end;
              end
             else
              begin
                if index+k>=0   then
                begin
                  index:= index+k;
                  k:= k*(-1);
                  inc(k);
                end
                else
                  begin
                    inc(index);
                     while (not found) and (index< packets) do
                     begin
                        i:=0;
                        while (not found) and (i< records) do
                          begin
                            temp:=my_arr[index,i];
                            if temp.key= KEY_STR then
                              begin
                                stop:= GetTickCount;
                                elapsed:= stop-start;
                                Check_record(temp,elapsed);
                                found := true;
                              end
                            else inc(i);
                          end;
                       inc(index);
                     end;
                     if not found  then
                      begin
                        Form2.Not_found_lab.Caption:= 'Record not found';
                        form2.Not_found_lab.Visible:= true;
                        form2.CountTimeFindLabel.Visible:= false;
                        found:= true;    // here it's meens not found but finding will terminated
                      end;
                  end;
              end;
           i:=0;
            while (not found) and (i< records) do
              begin
                temp:= my_arr[index,i];
                if temp.key= KEY_STR then
                  begin
                    stop:= GetTickCount;
                    elapsed:= stop-start;
                    Check_record(temp,elapsed);
                    found := true;
                  end;
                inc(i);
              end;
          end;
      end;

  procedure TForm2.Box_divClick(Sender: TObject);
    begin
      Box_shift.OnClick:= nil;
      Box_shift.Checked:= false;
      Box_shift.OnClick:= Box_shiftClick;
      Box_div.Checked:=true;
    end;

  procedure TForm2.Box_shiftClick(Sender: TObject);
    begin
      Box_div.OnClick:= nil;
      box_div.Checked:= false;
      Box_div.OnClick:= Box_divClick;
      Box_shift.Checked:=true;
    end;

  procedure TForm2.Button1Click(Sender: TObject);
   var key_str: string;
    begin
      key_str:= Edit1.Text;
      form2.Not_found_lab.Visible:= false;
      form2.SG.Visible:=false;
      if key_str <> '' then
        if Box_shift.Checked then
          Find_Record(Get_params_shift,get_shift,my_arr_shift,packets,records,key_str)
        else
          if Box_div.Checked then
            Find_Record(Get_params_div,get_div,my_arr_divide,packets,records,key_str)
          else
          begin
            Not_found_lab.Caption:= 'Choose some Hesh-function';
            Not_found_lab.Visible:= true;
          end
      else
        begin
          Not_found_lab.Caption:= 'Enter key';
          CountTimeFindLabel.Visible:=false;
          Not_found_lab.Visible:= true;
        end;
    end;

  procedure TForm2.ChangeLocationPanel(Sender: TObject);
    begin
      Panel4.Left:= ((ClientWidth-panel1.Width) div 2)- (Panel4.Width div 2);
      Panel4.Top:= (ClientHeight div 2)- (Panel4.Height div 2)
    end;

  procedure TForm2.End_findClick(Sender: TObject);
    begin
      close();
    end;

  procedure TForm2.EnterPressed(Sender: TObject; var Key: Char);
    begin
      if key=#13 then    Tcheckbox(sender).OnClick(Sender);
    end;

end.
