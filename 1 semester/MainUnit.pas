unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Math, UserFind, Graphics,AditionalUnit, AddFile, TestFind;
type

   TMyThread = class(TThread)
  private
    i : integer;
    elapsed_div,elapsed_shift: integer;
  protected
    procedure Execute; override;
    Procedure UpdateInfo;
    Procedure FinalInfo;
  public
  over_divide, over_shift: integer;
  iscomplete: boolean;
  istestfind: boolean;
  end;

   TForm1 = class(TForm)
    ProgressBar1: TProgressBar;
    WaitResultLabel: TLabel;
    CountPacketsLabel: TLabel;
    DivOverLabel: TLabel;
    FillFileButton : TButton;
    CloseButton: TButton;
    PauseButton: TButton;
    Button3: TButton;
    div_time: TLabel;
    shift_time: TLabel;
    ButtonThread: TButton;
    ShiftOverLabel: TLabel;
    TestFindBox: TCheckBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;



    procedure CloseButtonClick(Sender: TObject);
    procedure PauseButtonClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonThreadClick(Sender: TObject);
    procedure FillFileButtonClick(Sender: TObject);
    procedure EnterPressed(Sender: TObject; var Key: Char);
    procedure ChangePanelLocation(Sender: TObject);

  private
    { Private declarations }
  public

    procedure Fill_labels (const packets: integer; const over_div, over_sh: integer );
  end;

var
  Form1: TForm1;
  MyThread: TMyThread;

implementation

{$R *.dfm}

   procedure TForm1.ChangePanelLocation(Sender: TObject);
    begin
      Panel3.Left:= ((ClientWidth-panel1.Width) div 2)- (Panel3.Width div 2);
      Panel3.Top:= (ClientHeight div 2)- (Panel3.Height div 2)
    end;

   procedure TForm1.CloseButtonClick(Sender: TObject);
   begin
     MyThread.iscomplete:= true;
     close();
   end;

   procedure TForm1.EnterPressed(Sender: TObject; var Key: Char);
    begin
      if key=#13 then TestFindBox.Checked:=not TestFindBox.Checked;
    end;

   procedure TForm1.PauseButtonClick(Sender: TObject);
     begin
       MyThread.iscomplete:= true;
       Button3.Visible:= true;
       PauseButton.Visible:= false;
     end;

   procedure TForm1.Button3Click(Sender: TObject);
     begin
       form2.show;
     end;

   procedure TForm1.FillFileButtonClick(Sender: TObject);
  begin
    Form6.ShowModal;
    ButtonThread.Visible:= true;
    TestFindBox.Visible:= true;
  end;

   procedure Tform1.Fill_labels (const packets: integer; const over_div, over_sh: integer );
      begin
       DivOverLabel.caption :=  'for '+ inttostr(packets)+ ' packets number of overflow by Divide-Hesh: '+ inttostr(over_div);
       ShiftOverLabel.Caption:= 'for '+ inttostr(packets)+ ' packets number of overflow by Shift-Hesh: '+ inttostr(over_sh);
     end;

   procedure ChoiceBestPlace (const My_arr_overflow: TArr_info; var my_file: T_file);
    var i,min_div, min_shift: integer;
        str: string;
    begin
      min_div:= 1;
      min_shift:= 1;
      for i := 2 to DIFF_PACKETS do
        begin
          if My_arr_overflow[i,2]<My_arr_overflow[min_div,2] then min_div:= i;
          if My_arr_overflow[i,3]<My_arr_overflow[min_shift,3] then min_shift:= i;
        end;
      writeln(my_file);
      writeln(my_file);
      writeln(my_file, 'The best choice for place:');
      str:= '  for Hesh-divide -  '+ Inttostr(My_arr_overflow[min_div,1])+' -packets';
      writeln(my_file,str);
      str:= '  for Hesh-shift -  '+ Inttostr(My_arr_overflow[min_shift,1])+' -packets';
      writeln(my_file,str);
    end;

   procedure Fill_file_overflow (const My_arr_overflow : TArr_info);
     var My_file : T_file;
       i: integer;
       Str_density_div,Str_density_shift: string;
       density_shift, density_div: real;
       temp: string;
      begin
        Assign(My_file,'C:\Users\Asus\Desktop\MyCourseWork\1 semester\Documents\???????\overflow.txt');
        Rewrite(my_file);
        writeln(My_file,  '                                 OVERFLOW');
        writeln(My_file,'              Hesh divide    Hesh shift   Divide time    Shift time   '+
        ' Main area density Divide     Main area density Shift    Overflow density Divide    Overflow density Shift');
        for i := 1 to DIFF_PACKETS do
          begin
            density_div:=  SimpleRoundTo(1- my_arr_overflow[i,2]/N_REC,-5);
            density_shift:=  SimpleRoundTo(1- my_arr_overflow[i,3]/N_REC,-5);
            Str_density_div:= FloatToStr(density_div)+'%';
            Str_density_shift:= FloatToStr(density_shift)+'%';
            temp:= IntToStr(my_arr_overflow[i,1])+' ???????      '+IntToStr(my_arr_overflow[i,2])+
            '          '+ IntToStr(my_arr_overflow[i,3])+'         '+IntToStr(my_arr_overflow[i,4])+
            '          '+ IntToStr(my_arr_overflow[i,5])+'               '+Str_density_div+
            '                     '+Str_density_shift;
            density_div:= SimpleRoundTo(my_arr_overflow[i,2]/N_Pack,-5);
            density_shift:=SimpleRoundTo(my_arr_overflow[i,3]/N_Pack,-5);
            Str_density_div:= FloatToStr(density_div)+'%';
            Str_density_shift:= FloatToStr(density_shift)+'%';
            temp:= temp +'                    '+ Str_density_div+'                  '+Str_density_shift;
            writeln(My_file,temp);
          end;
        ChoiceBestPlace(my_arr_overflow,my_file);
        close(My_file);
      end;

   procedure Fill_Arr_Overflow (var Arr_overflow: TArr_info; const i: byte; const Packets,over_div,over_shift: integer);
    begin
      Arr_overflow[i,1]:= packets;
      Arr_overflow[i,2]:= over_div;
      Arr_overflow[i,3]:= over_shift;
      Arr_overflow[i,4]:= MyThread.elapsed_div;
      Arr_overflow[i,5]:= MyThread.Elapsed_shift;
    end;

   procedure TForm1.ButtonThreadClick(Sender: TObject);
    begin
      if not IsAddFile then  ShowMessage('Not loaded file')
      else
        begin
          WaitResultLabel.Visible:= true;
          ProgressBar1.Min := 0;
          ProgressBar1.Max := DIFF_PACKETS;
          ProgressBar1.Position := 0;
          ProgressBar1.Visible:= true;
          ProgressBar1.Step:=1;
          WaitResultLabel.Enabled:= true;
          CountPacketsLabel.Enabled:= true;
          DivOverLabel.Enabled:= true;
          TestFindBox.Visible:= false;
          TestFindBox.Visible:=false;
          CloseButton.Visible:= true;
          FillFileButton.Visible:= false;
          ButtonThread.Visible:= false;
          PauseButton.Visible:=true;
          div_time.Visible:= true;
          shift_time.visible:= true;
          if MyThread = nil then
            begin
              MyThread:= TMyThread.Create(true);
              if TestFindBox.checked then
                Mythread.istestfind:= true
              else
              Mythread.istestfind:= false;
              MyThread.Priority:=tpHigher;
              MyThread.FreeOnTerminate:= true;
              MyThread.resume;
            end;
        end;
    end;

   procedure fill_sell (var rec: type_struct; var index: integer; const struct: Type_struct; var bool : boolean);
      begin
        bool:= true;
        rec:= struct;
        inc(index);
      end;

   procedure Fill_one_record (var my_arr : Files; var directory: Tdirectory; index: integer; const struct: Type_struct; const packets,records : integer; var over: integer);
     var  j,k,save_index : integer;
          found  : boolean;
      begin
        try
          found:= false;
          k:=1;
          save_index:=index;
          while not found  do
          begin
            j:= directory[index];
            if j< records then
              begin
                if my_arr<>nil then
                  fill_sell(my_arr[index,j],directory[index],struct,found)
              end
            else
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
                       while not found do
                         begin
                           j:= directory[index];
                           if j< records then
                            begin
                              if my_arr<>nil then
                                fill_sell(my_arr[index,j],directory[index],struct,found)
                            end
                             else dec(index);
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
                        while not found do
                          begin
                            j:= directory[index];
                            if j< records then
                              begin
                               if my_arr<>nil then
                                fill_sell(my_arr[index,j],directory[index],struct,found)
                              end
                             else inc(index);
                          end;
                      end;
                  end;
              end;
          end;
          if index<>save_index then   inc(over);
          except
          ShowMessage('Not enough space to place records');
        end;
      end;

   procedure Fill_File (Get_params : T_get_params; Hesh_func : T_Hesh_func; var initial_file : TDataBase;
   var my_arr: Files;const  packets, records: integer; var over: integer);

     var  dividor, index,counter: integer;
     str: string;
     param: Pointer;
     temp: type_struct;
     Directory: Tdirectory;
     begin
       SetLength(Directory, packets);
       reset(initial_file);
       Get_params(dividor,param,packets);
       counter:= 0;
       while (counter<N_REC) do
         begin
           read(initial_file, temp);
           str:= get_ascii_string(temp.key);
           index:= Hesh_func(str,dividor,param);
           Fill_one_record(my_arr,directory,index,temp,packets,records,over);
           inc(counter);
         end;
     end;

   Procedure TMyThread.Updateinfo ();
      begin
        form1.CountPacketsLabel.Caption:=inttostr(packets)+' packets';
        form1.div_time.caption:= 'Divide time: '+inttostr(Elapsed_div)+ '-ms';
        form1.shift_time.caption:= 'Shift time: '+inttostr(Elapsed_shift)+'-ms';
        form1.Fill_labels(packets,over_divide,over_shift);
        form1.ProgressBar1.Position := i;
        form1.ProgressBar1.Update;
      end;

   Procedure TMyThread.Finalinfo ();
     begin
      with Form1 do
        begin
          WaitResultLabel.caption := 'Program complited  ';
          CountPacketsLabel.Visible:= false;
          DivOverLabel.Visible:= false;
          ShiftOverLabel.Visible:= false;
          CloseButton.Visible:= true;
          shift_time.Visible:= false;
          div_time.Visible:= false;
          Button3.Visible:= true;
          if not TestFindBox.Checked then
            Form8.MakeFindGraphicButton.Visible:= false;
          PauseButton.Visible:= false;
          Form8.Show;
        end;
     end;

   procedure TMyThread.Execute;
     var
    Start, Stop: Cardinal;
    k : integer;

  begin
   i:=0;
   k:=1;
   iscomplete:= false;
   while (packets <= 180000) and (not iscomplete) do
      begin
        packets:= packets+20*k;
        if packets>=200 then
          begin
            if packets>=2000 then
              begin
                if packets>=20000 then
                   k:=1000
                else k:=100;
              end
            else k:=10;
          end;
        records:= N_PACK div packets;
        my_arr_divide:= nil;
        my_arr_shift:= nil;
        SetLength(my_arr_divide,packets,records);
        SetLength(my_arr_shift,packets,records);
        over_divide := 0;
        over_shift:= 0;
        start:=GetTickCount;
        Fill_File(Get_params_div,get_div,initial_file,my_arr_divide,packets, records,over_divide);
        stop:= GetTickCount;
        Elapsed_div:= stop-start;
        start:= GetTickCount;
        Fill_File(Get_params_shift,get_shift,initial_file,my_arr_shift,packets, records,over_shift);
        stop:= GetTickCount;
        Elapsed_shift:= stop-start;
        inc(i);
        Fill_Arr_Overflow(my_arr_overflow,i,packets,over_divide,over_shift);
        Synchronize(UpdateInfo);
        if istestfind then
           GoFind;
      end;
   if packets = 200000 then
      begin
        Synchronize(FinalInfo);
       Fill_file_overflow(my_arr_overflow);
      end;
  end;

end.
