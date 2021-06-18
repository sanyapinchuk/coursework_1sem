unit Unit5;

interface

uses
  System.Classes,windows,unit3,unit1;

type
  TMyThread = class(TThread)
  private
    i : integer = 0;
    k: integer = 1;
    initial_file: TDataBase;
  protected
    procedure Execute; override;
    Procedure UpdateInfo ; override;
  end;

implementation

   procedure fill_sell (var rec: type_struct; var index: integer; const struct: Type_struct; var bool : boolean);
      begin
        bool:= true;
        rec:= struct;
        inc(index);
      end;

   procedure Fill_one_record (var my_arr : Files; var directory: Tdirectory; index: integer; const struct: Type_struct; const packets,records : integer; var over: int64);
     var  j,k : integer;
          found  : boolean;
          str: string;

      begin
        found:= false;
        k:=1;
        while not found  do
        begin
          j:= directory[index];
          if j< records then
             fill_sell(my_arr[index,j],directory[index],struct,found)
          else
            begin
              inc(over);
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
                            fill_sell(my_arr[index,j],directory[index],struct,found)
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
                            fill_sell(my_arr[index,j],directory[index],struct,found)
                           else inc(index);
                        end;
                    end;
                end;
            end;
        end;
      end;

   procedure Fill_File (Get_params : T_get_params; Hesh_func : T_Hesh_func;var initial_file : TDataBase; var my_arr: Files; var  Directory: Tdirectory; const  packets, records: integer; var over: int64);

     var  first, last, i, j, k,param, index,counter: integer;
     str, str3, initial_str : string;
     alpha : real;
     temp: type_struct;
     begin
       reset(initial_file);
       Get_params(param,alpha,packets);
       counter:= 0;
       while (counter<N_REC) do
         begin
           read(initial_file, temp);
           str:= get_ascii_string(temp.key);
           index:= Hesh_func(str,param,alpha);
           Fill_one_record(my_arr,directory,index,temp,packets,records,over);
           inc(counter);

      //    if counter mod 10000 = 0 then  Application.ProcessMessages;
         end;
     end;

   Procedure Update_info ();

procedure TMyThread.Execute;
   var stri,ew: string;
    res : int64;
    struct : array of  type_struct;
    file_divide,file_shift: T_file;
    base1,base2 : files;
    Start, Stop,elapsed: Cardinal;

    count: integer;
  //  k: integer;
   // i : integer;
    Directory_divide,Directory_shift : Tdirectory;

    over_divide, over_shift: int64;


begin
   AssignFile(initial_file,'C:\Users\Asus\Desktop\курсач\блокнот\initial_file.txt');
   packets:= packets+20*k;
   if packets <= 200000 then

      begin
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
        form1.label2.Caption:=inttostr(packets)+'-пакетов';
        records:= N_PACK div packets;
        directory_divide:= nil;
        directory_shift:= nil;
        SetLength(Directory_divide, packets);
        SetLength(Directory_shift, packets);
        SetLength(my_arr_divide,packets,records);
        SetLength(my_arr_shift,packets,records);
        over_divide := 0;
        over_shift:= 0;
        start:=GetTickCount;
      //  MyThread:= TMyThread.create(true);

    //    MyThread.AfterConstruction;
    //    MyThread.resume;
       // MyThread.Resume;
      //  MyThread.execute;
     //   Mythread.Start_thread(Get_params_div,get_div,initial_file,my_arr_divide, directory_divide,packets, records,over_divide);
       Fill_File(Get_params_div,get_div,initial_file,my_arr_divide, directory_divide,packets, records,over_divide);
      //  Application.ProcessMessages;
        stop:= GetTickCount;

        Elapsed:= stop-start;
        form1.div_time.caption:= inttostr(Elapsed);

        start:= GetTickCount;

       // MyThread.Resume;
       // Mythread.Start_thread(Get_params_shift,get_shift,initial_file,my_arr_shift,directory_shift, packets, records,over_shift);

     //   Fill_File(Get_params_shift,get_shift,initial_file,my_arr_shift,directory_shift, packets, records,over_shift);
      //  Application.ProcessMessages;
        stop:= GetTickCount;
        Elapsed:= stop-start;
        form1.shift_time.caption:= inttostr(elapsed);

        Fill_labels(packets,over_divide,over_shift);
      //  Application.ProcessMessages;
        inc(i);

        ProgressBar1.Position := i;
        ProgressBar1.Update;
       //  sleep(5);

      end
   else
   begin
     Label1.caption := 'Программа выполнена для продолжения нажмите кнопку ';
     Label2.Visible:= false;
     Label3.Visible:= false;
     Label4.Visible:= false;
     Timer1.Enabled:= false;
     Button1.Visible:= true;
     Button3.Visible:= true;
   end;
end;


end.
