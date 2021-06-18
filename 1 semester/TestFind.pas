unit TestFind;
interface
  uses AditionalUnit,Windows,SysUtils;

var
  i: integer =1;
  test_sequence_file:  TDataBase;
  no_found_count,no_found_div,no_found_shift: integer;
  elapsed_div,elapsed_shift: Cardinal;
 procedure GoFind();
implementation

procedure ChoiceBestFind (const arr_test_find: TArr_info; var test_fil_file:T_file);
  var i,min_div, min_shift: integer;
      str: string;
    begin
      min_div:= 1;
      min_shift:= 1;
      for i := 2 to DIFF_PACKETS do
        begin
          if arr_test_find[i,2]<arr_test_find[min_div,2] then min_div:= i;
          if arr_test_find[i,4]<arr_test_find[min_shift,4] then min_shift:= i;
        end;
      writeln(test_fil_file);
      writeln(test_fil_file);
      writeln(test_fil_file, 'The best choice for find:');
      str:= '  for Hesh-divide -  '+ Inttostr(arr_test_find[min_div,1])+' -packets';
      writeln(test_fil_file,str);
      str:= '  for Hesh-shift -  '+ Inttostr(arr_test_find[min_shift,1])+' -packets';
      writeln(test_fil_file,str);
    end;

procedure FillFindFile(const arr_test_find:  TArr_info);
  var test_fill_file: T_file;
  temp: string;
  i: integer;
  begin
    AssignFile(test_fill_file,'C:\Users\Asus\Desktop\MyCourseWork\1 semester\Documents\Блокнот\ResultsOfFind.txt');
    Rewrite(test_fill_file);
    temp:=' Number of packets'+'   '+'Find time Hesh-divide(ms)'+'   '+
    'No founded records Hesh-divide'+'   '+'Find time Hesh-shift(ms)'+'   '+'No founded records Hesh_shift';
    writeln(test_fill_file,temp);
    for i := 1 to DIFF_PACKETS do
      begin
        temp:= '        '+inttostr(arr_test_find[i,1])
        +'                  '+inttostr(arr_test_find[i,2])
        +'                             '+inttostr(arr_test_find[i,3])
        +'                          '+inttostr(arr_test_find[i,4])
        +'                       '+inttostr(arr_test_find[i,5]);
        writeln(test_fill_file,temp);
      end;
    ChoiceBestFind(arr_test_find,test_fill_file);
    close(test_fill_file);
  end;

procedure Find_Test (var  my_arr : Files; const packets, records: integer; index: integer; const KEY_STR: T_Key_str);
      var i,k : integer;
          found : boolean;
      begin
        found := false;
        i:= 0;
        while (not found) and (i< records) do
          begin
           if my_arr[index,i].key= KEY_STR then
             begin
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
                            if my_arr[index,i].key= KEY_STR then
                              begin
                                found := true;
                              end
                            else inc(i);
                          end;
                       dec(index)
                     end;
                    if not found  then
                      begin
                        inc(no_found_count);
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
                            if my_arr[index,i].key= KEY_STR then
                              begin
                                found := true;
                              end
                            else inc(i);
                          end;
                       inc(index);
                     end;
                     if not found  then
                      begin
                        inc(no_found_count);
                        found:= true;    // here it's meens not found but finding will terminated
                      end;
                  end;
              end;
           i:=0;
            while (not found) and (i< records) do
              begin
                if my_arr[index,i].key= KEY_STR then
                  begin
                    found := true;
                  end;
                inc(i);
              end;
          end;
      end;

procedure Check_All_Records(Get_params : T_get_params; Hesh_func : T_Hesh_func;
  var my_file: TDataBase; var  my_arr : Files; const packets, records: integer);
var temp: Type_struct;
    key_str: T_Key_str;
    param: Pointer;
    dividor,index: integer;
    str: string;
begin
  no_found_count:= 0;
  reset(my_file);
  Get_params(dividor,param,packets);
  while not Eof(my_file) do
    begin
      Read(my_file,temp);
      Key_str:= temp.key;
      str:= get_ascii_string(Key_str);
      index := Hesh_func(str,dividor,param);
      Find_Test(my_arr,packets,records,index,Key_str);
    end;
end;

procedure MakeTestSequence();
 var
 temp_struct: Type_struct;
 i: word;
  begin
    CopyFile('C:\Users\Asus\Desktop\MyCourseWork\1 semester\Documents\Блокнот\initial_file.txt',
    'C:\Users\Asus\Desktop\MyCourseWork\1 semester\Documents\Блокнот\test_sequence.txt',false);
    AssignFile(test_sequence_file,'C:\Users\Asus\Desktop\MyCourseWork\1 semester\Documents\Блокнот\test_sequence.txt');
    reset(test_sequence_file);
    seek(test_sequence_file,FileSize(test_sequence_file));     // to end of the file
    temp_struct.count_days:= 43;
    temp_struct.country:= 'Belarus';
    for I := 1001 to 1200 do
      begin
        temp_struct.key:='vf'+inttostr(i);
        write(test_sequence_file,temp_struct);
      end;
    close(test_sequence_file);
  end;

procedure UpdateTestFindArr(var arr_test_find: TArr_info;const packets, i : integer);
  begin
    arr_test_find[i,1]:= packets;
    arr_test_find[i,2]:= elapsed_div;
    arr_test_find[i,3]:= no_found_div;
    arr_test_find[i,4]:= elapsed_shift;
    arr_test_find[i,5]:= no_found_shift;
  end;

procedure GoFind();
var start,stop: cardinal;
begin
    if i =1  then
    begin
     if not FileExists ('C:\Users\Asus\Desktop\MyCourseWork\1 semester\Documents\Блокнот\test_sequence.txt') then
       MakeTestSequence
       else AssignFile(test_sequence_file,'C:\Users\Asus\Desktop\MyCourseWork\1 semester\Documents\Блокнот\test_sequence.txt')
    end;
  start:= GetTickCount;
  Check_All_Records(Get_params_div,get_div,test_sequence_file,my_arr_divide,packets,records);
  Stop:=GetTickCount;
  elapsed_div:= Stop-start;
  no_found_div:= no_found_count;
  no_found_count:=0;
  start:= GetTickCount;
  Check_All_Records(Get_params_shift,get_shift,test_sequence_file,my_arr_shift,packets,records);
  Stop:=GetTickCount;
  elapsed_shift:= Stop-start;
  no_found_shift:= no_found_count;
  UpdateTestFindArr(arr_test_find,packets,i);
  if i = DIFF_PACKETS then
    begin
      close(test_sequence_file);
      FillFindFile(arr_test_find);
    end;
  inc(i);
end;

end.

