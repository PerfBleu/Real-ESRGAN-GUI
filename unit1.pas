unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  Buttons, ExtDlgs, ExtCtrls, Spin, fileutil, TermVT, UnTerminal, LCLType,
  IniPropStorage, Unit2, inifiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtnTargetPath: TBitBtn;
    BitBtnSelectPicSource: TBitBtn;
    BitBtnAddPic: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtnStart: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    ComboBoxEditModel: TComboBox;
    ComboBoxPicModelSelector: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    EditPrefix: TEdit;
    EditTargetPath: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LabelPicScale: TLabel;
    LabelSelectPicModel: TLabel;
    ListBoxPicSelect: TListBox;
    ListView1: TListView;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ProgressBar1: TProgressBar;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SpinEditPicScale: TSpinEdit;
    StaticText1: TStaticText;
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtnAddPicClick(Sender: TObject);
    procedure BitBtnSelectPicSourceClick(Sender: TObject);
    procedure BitBtnStartClick(Sender: TObject);
    procedure BitBtnTargetPathClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure procAddLine(HeightScr: integer);
    procedure procChangeState(State: string; pFinal: TPoint);
    procedure procInitScreen(const grilla: TtsGrid; fIni, fFin: integer);
    procedure procRefreshLine(const grilla: TtsGrid; fIni, HeightScr: integer);
    procedure procRefreshLines(const grilla: TtsGrid; fIni, fFin,
      HeightScr: integer);
  private

  public

  end;

var
  Form1: TForm1;
  proc: TConsoleProc;
  commandhead: string;
  syssep: string;
  steps: integer=0;
  totalsteps: integer=0;
  stopflag: bool=False;
  displaylog: string='Show log';
  hidelog: string='Hide log';
implementation

{$R *.lfm}

{ TForm1 }

procedure disable_all();
begin
  form1.bitbtnstart.Enabled:=False;
  form1.bitbtnaddpic.Enabled:=False;
  form1.bitbtn2.Enabled:=False;
  form1.bitbtn3.Enabled:=False;
  form1.bitbtn5.Enabled:=False;
  form1.bitbtn6.Enabled:=False;
  form1.bitbtn7.Enabled:=False;
  form1.button1.Enabled:=False;
  form1.bitbtn8.Enabled:=False;
  form1.listview1.Enabled:=False;
  form1.BitBtn11.Enabled:=False;
  form1.listview1.Enabled:=False;
end;
procedure enable_all();
begin
  form1.bitbtnstart.Enabled:=True;
  form1.bitbtnaddpic.Enabled:=True;
  form1.bitbtn2.Enabled:=True;
  //form1.bitbtn3.Enabled:=True;
  form1.bitbtn5.Enabled:=True;
  form1.bitbtn6.Enabled:=True;
  form1.bitbtn7.Enabled:=True;
  form1.button1.Enabled:=True;
  form1.bitbtn8.Enabled:=True;
  form1.listview1.Enabled:=True;
  form1.BitBtn11.Enabled:=True;
  form1.listview1.Enabled:=True;
end;

procedure disable_start();
begin
  form1.bitbtnstart.Enabled:=False;
  form1.bitbtnaddpic.Enabled:=False;
  form1.bitbtn2.Enabled:=False;
  form1.bitbtn3.Enabled:=False;
  form1.bitbtn5.Enabled:=False;
  form1.bitbtn6.Enabled:=False;
  form1.bitbtn7.Enabled:=False;
  form1.button1.Enabled:=False;
  //form1.bitbtn8.Enabled:=False;
  //form1.listview1.Enabled:=False;
  form1.BitBtn10.Visible:=True;
  form1.BitBtnStart.Visible:=False;
  form1.BitBtn11.Enabled:=False;
end;

procedure enable_start();
begin
  form1.bitbtnstart.Enabled:=True;
  form1.bitbtnaddpic.Enabled:=True;
  form1.bitbtn2.Enabled:=True;
  //form1.bitbtn3.Enabled:=True;
  form1.bitbtn5.Enabled:=True;
  form1.bitbtn6.Enabled:=True;
  form1.bitbtn7.Enabled:=True;
  form1.button1.Enabled:=True;
  //form1.bitbtn8.Enabled:=True;
  //form1.listview1.Enabled:=True;
  form1.BitBtn10.Visible:=False;
  form1.BitBtnStart.Visible:=True;
  form1.BitBtn11.Enabled:=True;
end;

procedure TForm1.BitBtnAddPicClick(Sender: TObject);
begin
  disable_all;
  Panel1.Visible:=True;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  i: integer;
  tsatmp: TStringArray;
  tsatmp2: TStringArray;
  filename:string;
  suffix:string;
begin
  for i:=0 to ListBoxPicSelect.Items.Count - 1 do
  begin
    with ListView1.Items.Add do
      begin
        tsatmp:= ListBoxPicSelect.Items[i].Split(['/','\']);
        Caption:='Picture'; //添加第一项
        SubItems.add(ListBoxPicSelect.Items[i]);
        if radiobutton1.Checked then
        SubItems.add(StringReplace(EditTargetPath.Text+syssep+
        EditPrefix.Text+tsatmp[Length(tsatmp)-1],chr(13) + chr(10), '', [rfReplaceAll]))
        else
        begin
          tsatmp2:= tsatmp[Length(tsatmp)-1].Split(['.']);
          suffix:=tsatmp2[Length(tsatmp2)-1];
          filename:= tsatmp2[0];
          SubItems.add(StringReplace(EditTargetPath.Text+syssep
          +filename+EditPrefix.Text+'.'+suffix,chr(13) + chr(10), '', [rfReplaceAll]));
        end;
        SubItems.add(ComboBoxPicModelSelector.Text);
        SubItems.add(inttostr(SpinEditPicScale.Value));
        SubItems.add('WAIT');
      end;
  end;
  ListBoxPicSelect.Items.Clear;
  enable_all;
  Panel1.Visible:=False;
end;

procedure TForm1.BitBtn10Click(Sender: TObject);
begin
  stopflag:=True;
  proc.Close;
  steps:=totalsteps;
end;

procedure TForm1.BitBtn11Click(Sender: TObject);
begin
  disable_all;
  Panel3.Visible:=True;
end;

procedure TForm1.BitBtn12Click(Sender: TObject);
var
  IniFile: TIniFile;
  FilePath: string;
begin
  FilePath := 'config.ini';
  IniFile := TIniFile.Create(FilePath);
  try
    IniFile.WriteString('base', 'lang', ComboBox1.Caption);
  finally
    IniFile.Free;
  end;
  Panel3.Visible:=False;
  enable_all;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  ListView1.Items.Clear;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  disable_all;
  Edit1.Text:=ListView1.Selected.SubItems[1];
  Edit2.Text:=ListView1.Selected.SubItems[3];
  //Edit3.Text:=ListView1.Selected.SubItems[2];
  Panel2.Visible:=True;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  Panel1.Visible:=False;
  enable_all;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
var
  i: integer;
  del: integer=0;
begin
  for i := 0 to ListView1.Items.Count-1 do
  begin
    if Listview1.Items[i-del].SubItems.Strings[4]='DONE'
    then
    begin
      Listview1.Items.Delete(i-del);
      del+=1;
    end;
  end;
  del :=0;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
var
  i: integer;
  del: integer=0;
begin
  for i := 0 to ListView1.Items.Count-1 do
  begin
    if ListView1.Items[i-del].Selected
    then
    begin
      Listview1.Items.Delete(i-del);
      del+=1;
    end;
  end;
  del := 0;
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
begin
  if Bitbtn8.Caption = displaylog then
    begin
      Form1.Height:=Form1.Height+255;
      BitBtn8.Caption:=hidelog;
      abort;
    end
  else
    begin
      Form1.Height:=Form1.Height-255;
      BitBtn8.Caption:=displaylog;
    end;
end;

procedure TForm1.BitBtn9Click(Sender: TObject);
var
  OpenDialog: TSelectDirectoryDialog;
  tsltmp: TStringArray;
  filename: string;
begin
  tsltmp:=ListView1.Selected.SubItems.Strings[1].Split([syssep]);
  filename:=tsltmp[length(tsltmp)-1];
  OpenDialog := TSelectDirectoryDialog.Create(Self);
  try
    OpenDialog.Options:=[ofPathMustExist];
    if OpenDialog.Execute then // 显示文件保存对话框
    begin
      Edit1.Text:=OpenDialog.Files.Text+syssep+filename;
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TForm1.BitBtnSelectPicSourceClick(Sender: TObject);
var
  OpenDialog: TOpenPictureDialog;
  i:Integer;
begin
  OpenDialog := TOpenPictureDialog.Create(Self);
  OpenDialog.Filter:='Graphic (*.png;*.xpm;*.bmp;*.cur;*.ico;*.icns;*.jpeg;*.jpg;*.jpe;*.jfif;*.tif;*.tiff;*.gif;*.pbm;*.pgm;*.ppm;*.webp)|*.png;*.xpm;*.bmp;*.cur;*.ico;*.icns;*.jpeg;*.jpg;*.jpe;*.jfif;*.tif;*.tiff;*.gif;*.pbm;*.pgm;*.ppm;*.webp|PNG Files (*.png)|*.png|Pixmap Files (*.xpm)|*.xpm|Bitmap Files (*.bmp)|*.bmp|Cursor Files (*.cur)|*.cur|Icon Files (*.ico)|*.ico|macOS Icon Files (*.icns)|*.icns|JPEG Files (*.jpeg;*.jpg;*.jpe;*.jfif)|*.jpeg;*.jpg;*.jpe;*.jfif|Tagged Image File Format Files (*.tif;*.tiff)|*.tif;*.tiff|Graphics Interchange Format Files (*.gif)|*.gif|Portable Pixmap Files (*.pbm;*.pgm;*.ppm)|*.pbm;*.pgm;*.ppm|All files (*.*)|*.*';
  try
    OpenDialog.Options:=[ofAllowMultiSelect, ofAutoPreview];
    if OpenDialog.Execute then // 显示文件保存对话框
    begin
      //Showmessage(OpenDialog.Files.Text);
      for i:=0 to OpenDialog.Files.Count - 1 do
      begin
        ListBoxPicSelect.Items.Add(OpenDialog.Files[i]);
      end;
    end;
  finally
    OpenDialog.Free;
  end;
end;

function getAttr(index:integer; _index:integer):string;
begin
  Result:=Form1.ListView1.Items[index].SubItems.Strings[_index];
end;

procedure stepTasks();
begin
  if stopflag then
  begin
    enable_start;
    stopflag:=False;
    abort;
  end;
  if steps<totalsteps then
  begin
    Form1.ListView1.Items[steps].SubItems[4]:='PENDING';
    Form1.Memo1.Append(commandhead+' -i "'+getattr(steps,0)+'" -o "'+
    getattr(steps,1)+'" -n '+getattr(steps,2)+' -s '+getattr(steps,3));
    proc.Open(commandhead,' -i "'+getattr(steps,0)+'" -o "'+
    getattr(steps,1)+'" -n '+getattr(steps,2)+' -s '+getattr(steps,3));
    steps+=1;
  end
  else
  begin
    Application.MessageBox(PChar('Total tasks '+inttostr(steps)+' Finished!'),
                           'Finish!', MB_ICONINFORMATION+MB_OK);
    enable_start;
  end;
end;

procedure TForm1.BitBtnStartClick(Sender: TObject);
var
  i: integer;
begin
  disable_start;
  ProgressBar1.Max:=ListView1.Items.Count;
  totalsteps:= ListView1.Items.Count;
  steps:=0;
  stepTasks;
end;

procedure TForm1.BitBtnTargetPathClick(Sender: TObject);
var
  OpenDialog: TSelectDirectoryDialog;
begin
  OpenDialog := TSelectDirectoryDialog.Create(Self);
  try
    OpenDialog.Options:=[ofPathMustExist];
    if OpenDialog.Execute then // 显示文件保存对话框
    begin
      EditTargetPath.Text:=OpenDialog.Files.Text;
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  frm2:TForm;
begin
  frm2 :=  TForm2.Create(nil);
  frm2.ShowModal;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ListView1.Selected.SubItems[1]:=Edit1.Text;
  ListView1.Selected.SubItems[3]:=Edit2.Text;
  ListView1.Selected.SubItems[2]:=ComboBoxEditModel.Text;
  Panel2.Visible:=False;
  enable_all;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  BinFiles: TStringList;
  langfiles: TStringList;
  i: integer;
  tsatmp: TStringArray;
  tsatmp2: TStringArray;
  IniFile: TIniFile;
  LangFile: TIniFile;
  FilePath: string;
  lang: string;
  langPath: string;
  icontmp: TCustomIcon;
begin
  //Form1.Height:=670;
  EditTargetPath.Text:=ExtractFileDir(ParamStr(0));
  BinFiles := TStringList.Create;
  try
    FindAllFiles(BinFiles, 'bin/realesrgan/models', '*.bin', true);
    for i:=0 to BinFiles.Count-1 do
    begin
      tsatmp := BinFiles.Strings[i].Split(['/','\']);
      tsatmp2 := tsatmp[Length(tsatmp)-1].Split(['.bin']);
      ComboBoxPicModelSelector.Items.Add(tsatmp2[0]);
      ComboBoxEditModel.Items.Add(tsatmp2[0]);
    end;
    ComboBoxPicModelSelector.ItemIndex:=0;
    ComboBoxEditModel.ItemIndex:=0;
  finally
    BinFiles.Free;
  end;

  langFiles := TStringList.Create;
    try
      FindAllFiles(langFiles, 'lang', '*.ini', true);
      for i:=0 to langFiles.Count-1 do
      begin
        tsatmp := langFiles.Strings[i].Split(['/','\']);
        tsatmp2 := tsatmp[Length(tsatmp)-1].Split(['.ini']);
        ComboBox1.Items.Add(tsatmp2[0]);
        ComboBox1.ItemIndex:=0;
      end;
    finally
      BinFiles.Free;
    end;

  proc:= TConsoleProc.Create(nil);
  proc.OnInitScreen :=@procInitScreen;
  proc.OnRefreshLine:=@procRefreshLine;
  proc.OnRefreshLines:=@procRefreshLines;
  proc.OnAddLine:=@procAddLine;
  proc.OnChangeState:=@procChangeState;
  commandhead:='bin\realesrgan\realesrgan-ncnn-vulkan.exe';
  syssep:='\';
  {$ifdef linux}
  //txtProcess.Text:= 'bash';
  //txtCommand.Text := 'ls';
  commandhead:='bin/realesrgan/realesrgan-ncnn-vulkan';
  proc.LineDelimSend := LDS_LF;
  syssep:='/';
  {$endif}
  FilePath := 'config.ini';
  IniFile := TIniFile.Create(FilePath);
  try
    lang := IniFile.ReadString('base', 'lang', 'en');
  finally
    IniFile.Free;
  end;
  if lang <> 'en'
  then
  begin
    langpath := 'lang'+syssep+lang+'.ini';
    LangFile := TIniFile.Create(langpath);
    try
      // 语言
      BitBtnAddPic.Caption := IniFile.ReadString('langstring', 'addtask', 'addtask');
      BitBtn3.Caption:=IniFile.ReadString('langstring', 'edittask', 'edittask');
      BitBtn2.Caption:=IniFile.ReadString('langstring', 'clearall', 'clearall');
      BitBtn5.Caption:=IniFile.ReadString('langstring', 'clearfinished', 'clearfinished');
      BitBtn6.Caption:=IniFile.ReadString('langstring', 'clearselected', 'clearselected');
      Button1.Caption:=IniFile.ReadString('langstring', 'about', 'about');
      BitBtn8.Caption:=IniFile.ReadString('langstring', 'displaylog', 'displaylog');
      displaylog := IniFile.ReadString('langstring', 'displaylog', 'displaylog');
      hidelog := IniFile.ReadString('langstring', 'hidelog', 'hidelog');
      BitBtn11.Caption:=IniFile.ReadString('langstring', 'config', 'config');
      BitBtn10.Caption:=IniFile.ReadString('langstring', 'stop', 'stop');
      BitBtnstart.Caption:=IniFile.ReadString('langstring', 'start', 'start');
      BitBtn7.Caption:=IniFile.ReadString('langstring', 'quit', 'quit');
      GroupBox1.Caption:=IniFile.ReadString('langstring', 'ssfatp', 'ssfatp');
      BitBtnSelectPicSource.Caption:=IniFile.ReadString('langstring', 'ssf', 'ssf');
      BitBtnTargetPath.Caption:=IniFile.ReadString('langstring', 'stf', 'stf');
      GroupBox2.Caption:=IniFile.ReadString('langstring', 'setparameters', 'setparameters');
      LabelSelectPicModel.Caption:=IniFile.ReadString('langstring', 'model', 'model');
      LabelPicScale.Caption:=IniFile.ReadString('langstring', 'scale', 'scale');
      Label3.Caption:=IniFile.ReadString('langstring', 'filename', 'filename');
      RadioButton1.Caption:=IniFile.ReadString('langstring', 'prefix', 'prefix');
      RadioButton2.Caption:=IniFile.ReadString('langstring', 'suffix', 'suffix');
    finally
      LangFile.Free;
    end;
  end
end;

//procedure TForm1.ListView1CustomDrawItem(Sender: TCustomListView;
//  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
//begin
//  Case Item.SubItems.Strings[4] of
//  'DONE': Sender.Canvas.Brush.Color:=clGreen;
//  'PENDING': Sender.Canvas.Brush.Color:=clYellow;
//  else ;
//  end;
//end;

procedure TForm1.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  i: integer;
  _selected: integer=0;
begin
  for i:=0 to ListView1.Items.Count-1 do
  begin
    if ListView1.Items[i].Selected then
    _selected += 1;
  end;
  if _selected = 1 then BitBtn3.Enabled:=True else BitBtn3.Enabled:=False;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  proc.Destroy;
end;

procedure TForm1.procChangeState(State: string; pFinal: TPoint);
begin
  //showmessage(State);
  if State = 'Stopped' then
  //Form1.ListView1.Items[steps-1].SubItems[4]:='DONE';
  begin
    if stopflag then
    begin
      stepTasks;
      stopflag:=False;
    end;
    Form1.ListView1.Items[steps-1].SubItems[4]:='DONE';
    //Form1.ListView1.Selected.;
    Form1.ProgressBar1.Position:=steps;
    stepTasks;
  end;
end;

procedure TForm1.procAddLine(HeightScr: integer);
begin
  Memo1.Lines.Add('');
end;

procedure TForm1.procInitScreen(const grilla: TtsGrid; fIni, fFin: integer);
var
  i: Integer;
begin
  for i:=fIni to fFin do Memo1.Lines.Add(grilla[i]);
end;

procedure TForm1.procRefreshLine(const grilla: TtsGrid; fIni, HeightScr: integer
  );
var
  yvt: Integer;
begin
  yvt := Memo1.Lines.Count-HeightScr-1;
  Memo1.Lines[yvt+fIni] := grilla[fIni];
end;

procedure TForm1.procRefreshLines(const grilla: TtsGrid; fIni, fFin,
  HeightScr: integer);
var
  yvt: Integer;
  f: Integer;
begin
  yvt := Memo1.Lines.Count-HeightScr-1;  //Calculate equivalent row to start of VT100 screen
  for f:=fIni to fFin do Memo1.Lines[yvt+ f] := grilla[f];
end;


end.

