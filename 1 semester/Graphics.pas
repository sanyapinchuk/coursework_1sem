unit Graphics;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AditionalUnit, Vcl.StdCtrls, Vcl.ExtCtrls,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs,
  VCLTee.Chart, VCLTee.TeeSpline;

type
  TForm8 = class(TForm)
    Panel1: TPanel;
    MakeFindGraphicButton: TButton;

    FIndChart: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Panel2: TPanel;
    DivFindLabel: TLabel;
    ShiftFindLabel: TLabel;
    PlaceChart: TChart;
    Label1: TLabel;
    Label2: TLabel;
    LineSeries1: TLineSeries;
    LineSeries2: TLineSeries;
    procedure MakeHeshGraphicButtonClick(Sender: TObject);
    procedure MakeFindGraphicButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    IsFindTest : boolean;
    MakeHeshGraphicButton: TButton;
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

  procedure TForm8.MakeFindGraphicButtonClick(Sender: TObject);
   var i,x,Ydiv,Ysh: integer;
    begin
      with FindChart do
        begin
          form8.ClientWidth:= 1423;
           for i := 1 to DIFF_PACKETS do
             begin
               x:=my_arr_overflow[i,1];
               Ydiv:=arr_test_find[i,2] div 1000;
               Ysh:= arr_test_find[i,4] div 1000;
               Series1.AddXY(x,Ydiv);
               Series2.AddXY(x,Ysh);
             end;
        end;
        FIndChart.Visible:= true;
    end;

  procedure TForm8.MakeHeshGraphicButtonClick(Sender: TObject);
var i,x,Ydiv,Ysh: integer;
begin
  with placechart do
    begin
       for i := 1 to DIFF_PACKETS do
         begin
           x:=my_arr_overflow[i,1];
           Ydiv:=my_arr_overflow[i,2];
           Ysh:= my_arr_overflow[i,3];
           LineSeries1.AddXY(x,Ydiv);
           LineSeries2.AddXY(x,Ysh);
         end;
    end;
  PlaceChart.Visible:= true;
end;

end.
