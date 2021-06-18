unit Unit4;

interface

uses
  System.Classes,Unit3;

type
  TMyThread1 = class(TThread)
  private
    { Private declarations }
     FGet_params : T_get_params;
     FHesh_func : T_Hesh_func;
     Finitial_file : TDataBase;
     Fmy_arr: Files;
     FDirectory: Tdirectory;
     Fpackets, Frecords: integer;
     Fover: int64;

 // protected

  public
   procedure Execute; override;
   constructor Create (Get_params : T_get_params; Hesh_func : T_Hesh_func;var initial_file : TDataBase; var my_arr: Files; var  Directory: Tdirectory; const  packets, records: integer; var over: int64);  overload;
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

   procedure TMyThread1.Execute;
      var  first, last, i, j, k,param, index,counter: integer;
     str, str3, initial_str : string;
     alpha : real;
     temp: type_struct;

  begin
      begin
     //  reset(finitial_file);
       fGet_params(param,alpha,packets);
       counter:= 0;
       while (counter<N_REC) do
         begin
           read(finitial_file, temp);
           str:= get_ascii_string(temp.key);
           index:= fHesh_func(str,param,alpha);

       Fill_one_record(fmy_arr,fdirectory,index,temp,fpackets,frecords,fover);
           inc(counter);

      //    if counter mod 10000 = 0 then  Application.ProcessMessages;
         end;
     end;


end;

  constructor TmyThread1.Create (Get_params : T_get_params; Hesh_func : T_Hesh_func;var initial_file : TDataBase; var my_arr: Files; var  Directory: Tdirectory; const  packets, records: integer; var over: int64);
    begin
       inherited Create(False);
       FreeOnTerminate:= true;
       FGet_params:= Get_params;
       FHesh_func := Hesh_func;
       AssignFile(finitial_file,'C:\Users\Asus\Desktop\курсач\блокнот\initial_file.txt');
       reset(finitial_file);
       Fmy_arr:= my_arr;
       FDirectory:= Directory;
       Fpackets:=packets;
       Frecords:= records;
       Fover:= over;
       Execute;
       over:= Fover;
       Close(initial_file);
    end;

end.
