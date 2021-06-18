unit AditionalUnit;

interface
uses SysUtils,StrUtils, Winapi.Windows;
     Const N_PACK = 1200000;
        N_REC = 1000000;
        DIFF_PACKETS= 37;

 Tcountries : array [0..22] of string =  ('Abkhazia','Japan','Albania','Algeria','Argentina','Armenia','Australia','Belarus','Belgium','Brazil','Canada','China','Denmark','Egypt','Germany','Iran','Italy','Panama','Papua','Russia','Spain','Turkey','Ukraine');

  type

   Tinteger = ^integer;

   Treal = ^real;

   T_Key_str = string[6];

   Type_struct = record
                 key:  T_Key_str;
                 count_days : integer;
                 country: string[9];
   end;

   TDataBase = File of type_struct;

   Files = array of array of Type_struct;

   tDirectory = Array of Integer;

   T_file= textFile;

   TArr_info = array [1..DIFF_PACKETS] of array [1..5] of integer;

   T_Hesh_func = function(initial_str: string; const dividor: integer;var param: Pointer) : integer;

   T_get_params = procedure (var dividor: integer; var param: Pointer; const packets: integer);


   function get_ascii_string (Initial_str: string): string;

   function Get_div (str: string; const dividor: integer;var  alpha: Pointer) : integer; far;

   function Get_shift (str : string; const dividor: integer; var size: Pointer): integer; far;

   procedure Get_params_shift (var divider : integer; var param: Pointer; const packets : integer); far;

   procedure Get_params_div (var divider : integer; var param: Pointer; const packets : integer); far;

   var  packets : integer= 0;
        my_arr_divide,my_arr_shift: Files;
        records: integer;
        initial_file: TDataBase;
        IsAddFile: boolean = false;
        my_arr_overflow,arr_test_find : TArr_info;
        var  param: Pointer;


implementation

   function Get_simple_number (const N : integer): integer;
      var i,j: integer;
        found, complex : boolean;
      begin
        i:= N+1;
        found:= false;
        while not found do
          begin
            j:=2;
            complex:= false;
            while (not complex) and (j<sqrt(i)) do
              begin
                if i mod j = 0 then  complex:= true;
                inc(j);
              end;
            inc(i);
            if not complex  then found:= true;
          end;
          result:= i-1;
      end;

   function get_ascii_string (Initial_str: string): string;
      var
        finish_str: string;
        i: Integer;
      begin
        finish_str:= '';
        for i := 1 to length(Initial_str) do
          finish_str := finish_str + IntToStr(ord(initial_str[i]));
        Result:= finish_str;
      end;

   function Get_div (str: string; const dividor: integer;var alpha: Pointer) : integer; far;
     var
      int: int64;
      begin
         int:= StrToInt64(str)  mod dividor;
         result:= round(int*Treal(alpha)^);
      end;

   function Get_shift (str : string; const dividor: integer;var size : Pointer): integer; far;
     var
      hesh: int64;
      num: string;
     begin
       while length(str)>Tinteger(size)^  do
        begin
          num:= Copy(str,1,2);
          delete(str,1,1);
          hesh:= StrToInt64(str)+ strtoint(num);
          str:= inttostr(hesh);
        end;
      hesh:= abs(packets-1- (hesh mod dividor));
      result:= hesh;
     end;

   procedure Get_params_shift (var divider : integer;var param: Pointer; const packets : integer); far;
     var
       size: Tinteger;
      begin
        new(size);
        size^:= length(inttostr(packets));
        divider:=  Get_simple_number(packets);
        param:= size;
        dispose(size);
      end;

   procedure Get_params_div (var divider : integer;var  param: Pointer; const packets : integer); far;
     var
       alpha : Treal;
      begin
        new(alpha);
        divider := Get_simple_number(packets);
        alpha^ := (packets-1)/(divider-1);
        param:= alpha;
        dispose(alpha);
      end;

end.
