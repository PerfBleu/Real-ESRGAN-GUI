unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TForm2 }

  TForm2 = class(TForm)
    form2close: TBitBtn;
    Labelabout: TLabel;
    Memoabout: TMemo;
    procedure form2closeClick(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.form2closeClick(Sender: TObject);
begin
  Close;
end;

end.

