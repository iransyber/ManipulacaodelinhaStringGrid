unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Buttons;

type
  TForm2 = class(TForm)
    StringGrid1: TStringGrid;
    SpeedButton1: TSpeedButton;
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
 s : String;
 drawRect : TRect;
begin

if ACol = 1 then
  begin
   StringGrid1.Canvas.FillRect(Rect);
   s := StringGrid1.Cells[ACol, ARow]; //the text in the cell
   if Length(s) > 0 then //is there any text needing to be formatted?
    begin
     drawRect := Rect;
     DrawText(StringGrid1.canvas.handle,  //See http://msdn.microsoft.com/en-us/libr...(v=vs.85).aspx
              Pchar(s), Length(s), drawRect,
              DT_CALCRECT OR DT_WORDBREAK OR DT_LEFT ); //format the text as required, then use drawRect later as per DT_CALCRECT
     if (drawRect.bottom - drawRect.top) > StringGrid1.RowHeights[ARow] then //Does the row need to be adjusted?
      StringGrid1.RowHeights[ARow] := (drawRect.bottom - drawRect.top) //adjust row height
     else
      begin //fits in one line
       drawRect.Right := Rect.Right;
       StringGrid1.canvas.fillrect(drawRect);
       DrawText(StringGrid1.canvas.handle,
                Pchar(s), Length(s), drawRect,
                 DT_WORDBREAK); //how to format the text
      end;
    end;
  end;

    //DrawText(StringGrid1.Canvas.Handle, PChar(StringGrid1.Cells[aCol, aRow]), Length(StringGrid1.Cells[aCol, aRow]), Rect, DT_WORDBREAK);
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
var
 i : Integer;
begin
 for i := 1 to 10 do begin
   StringGrid1.Cells[1,i] := 'CPF:99999999999999 Nome:asdadasdadsasdasdsadas';
   StringGrid1.RowCount := i+1;
 end;
end;

end.
