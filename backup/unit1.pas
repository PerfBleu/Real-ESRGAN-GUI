unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  Buttons, ExtDlgs, ExtCtrls, Spin, fileutil, TermVT, UnTerminal, LCLType,
  Unit2, klabels, inifiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    BevelStatus: TBevel;
    BitBtnAddOK: TBitBtn;
    BitBtnModSelectTarget1: TBitBtn;
    BitBtnSelectPicSource: TBitBtn;
    BitBtnSelectFolderSource: TBitBtn;
    BitBtnSelectVideo: TBitBtn;
    BitBtnStop: TBitBtn;
    BitBtnConfig: TBitBtn;
    BitBtnSettingsOK: TBitBtn;
    BitBtnAbout: TBitBtn;
    BitBtnSettingsCancel: TBitBtn;
    BitBtnAddCancel: TBitBtn;
    BitBtnClearFinished: TBitBtn;
    BitBtnClearSelected: TBitBtn;
    BitBtnQuit: TBitBtn;
    BitBtnLog: TBitBtn;
    BitBtnModSelectTarget: TBitBtn;
    BitBtnTargetPath: TBitBtn;
    BitBtnAddPic: TBitBtn;
    BitBtnClearAll: TBitBtn;
    BitBtnEditTask: TBitBtn;
    BitBtnStart: TBitBtn;
    ButtonModApply: TButton;
    ButtonAdvApply: TButton;
    ButtonModCancel: TButton;
    ButtonAdvCancel: TButton;
    CheckBoxForceMultihread: TCheckBox;
    CheckBoxGpuid: TCheckBox;
    CheckBoxThread: TCheckBox;
    CheckBoxTTA: TCheckBox;
    CheckBoxVerbose: TCheckBox;
    CheckBoxTilesize: TCheckBox;
    CheckBoxAdv: TCheckBox;
    ComboBoxOutputFormat: TComboBox;
    ComboBoxModModel: TComboBox;
    ComboBoxPicModelSelector: TComboBox;
    ComboBoxSelectLang: TComboBox;
    EditFFmpegArgs: TEdit;
    EditWorkingFolder: TEdit;
    EditPrefix: TEdit;
    EditSourcePath: TEdit;
    EditTileSize: TEdit;
    EditGpuid: TEdit;
    EditThread: TEdit;
    EditModTarget: TEdit;
    EditModScale: TEdit;
    EditTargetPath: TEdit;
    ffmpeglabel: TLabel;
    GroupBoxAdv: TGroupBox;
    GroupBoxOutput: TGroupBox;
    GroupBoxSettings: TGroupBox;
    GroupBoxSource: TGroupBox;
    GroupBoxPara: TGroupBox;
    GroupBoxLog: TGroupBox;
    KGradientLabel2: TKGradientLabel;
    KGradientLabel3: TKGradientLabel;
    Labelworkfolder: TLabel;
    LabelFolderPrompt: TLabel;
    LabelFilenameFormat: TLabel;
    LabelFormatPrompt: TLabel;
    Labellangprompt: TLabel;
    Labelworkfolderprompt: TLabel;
    Labeltile: TLabel;
    Labelgpu: TLabel;
    Labelthread: TLabel;
    LabelLang: TLabel;
    LabelOutputFormat: TLabel;
    LabelModTarget: TLabel;
    LabelModScale: TLabel;
    LabelModModel: TLabel;
    LabelStatus: TLabel;
    LabelPicScale: TLabel;
    LabelSelectPicModel: TLabel;
    ListBoxPicSelect: TListBox;
    ListBoxVideo: TListBox;
    ListViewMain: TListView;
    MemoLog: TMemo;
    PageCtrlFileorFolder: TPageControl;
    PanelCpFile: TPanel;
    PanelSingleFileCtrl: TPanel;
    PanelAddTask: TPanel;
    PanelModifyPic: TPanel;
    PanelAdvanced: TPanel;
    PanelSettings: TPanel;
    PanelLog: TPanel;
    ProgressBar1: TProgressBar;
    ProgressBarCpFile: TProgressBar;
    RadioButtonPrefix: TRadioButton;
    RadioButtonSuffix: TRadioButton;
    SpinEditPicScale: TSpinEdit;
    StaticTextSettingsPrompt: TStaticText;
    TabSheet1: TTabSheet;
    TabSheetSingleFile: TTabSheet;
    TabSheetFolder: TTabSheet;
    procedure BitBtnModSelectTarget1Click(Sender: TObject);
    procedure BitBtnSelectFolderSourceClick(Sender: TObject);
    procedure BitBtnSelectVideoClick(Sender: TObject);
    procedure BitBtnStopClick(Sender: TObject);
    procedure BitBtnConfigClick(Sender: TObject);
    procedure BitBtnSettingsOKClick(Sender: TObject);
    procedure BitBtnAboutClick(Sender: TObject);
    procedure BitBtnAddOKClick(Sender: TObject);
    procedure BitBtnClearAllClick(Sender: TObject);
    procedure BitBtnEditTaskClick(Sender: TObject);
    procedure BitBtnAddCancelClick(Sender: TObject);
    procedure BitBtnClearFinishedClick(Sender: TObject);
    procedure BitBtnClearSelectedClick(Sender: TObject);
    procedure BitBtnQuitClick(Sender: TObject);
    procedure BitBtnLogClick(Sender: TObject);
    procedure BitBtnModSelectTargetClick(Sender: TObject);
    procedure BitBtnAddPicClick(Sender: TObject);
    procedure BitBtnSelectPicSourceClick(Sender: TObject);
    procedure BitBtnSettingsCancelClick(Sender: TObject);
    procedure BitBtnStartClick(Sender: TObject);
    procedure BitBtnTargetPathClick(Sender: TObject);
    procedure ButtonAdvApplyClick(Sender: TObject);
    procedure ButtonAdvCancelClick(Sender: TObject);
    procedure ButtonModApplyClick(Sender: TObject);
    procedure ButtonModCancelClick(Sender: TObject);
    procedure CheckBoxAdvChange(Sender: TObject);
    procedure CheckBoxForceMultihreadClick(Sender: TObject);
    procedure ComboBoxPicModelSelectorChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LabelAdvancedSettingsClick(Sender: TObject);
    procedure ListViewMainSelectItem(Sender: TObject; Item: TListItem;
      Selected: boolean);
    procedure FormDestroy(Sender: TObject);
    procedure PageCtrlFileorFolderChange(Sender: TObject);
    procedure procAddLine(HeightScr: integer);
    procedure procChangeState(State: string; pFinal: TPoint);
    procedure procInitScreen(const grilla: TtsGrid; fIni, fFin: integer);
    procedure procRefreshLine(const grilla: TtsGrid; fIni, HeightScr: integer);
    procedure procRefreshLines(const grilla: TtsGrid;
      fIni, fFin, HeightScr: integer);
  private

  public

  end;

var
  Form1: TForm1;
  proc: TConsoleProc;
  commandhead: string;
  extra_cmd_paras: string;
  syssep: string;
  syscrlf: string = chr(13) + chr(10);
  steps: integer = 1;
  totalsteps: integer = 0;
  stopflag: bool = False;
  displaylog: string = 'Show log';
  hidelog: string = 'Hide log';
  forceMultiThreadPrompt: string = 'This will copy files to one folder and then process.'+
    chr(13) + chr(10)+'You can set the temp folder in Config';
  noFilePrompt: string = 'Please select at least one file';
  noFolderPrompt: string = 'Please select a source folder';
  noTargetPrompt: string = 'Please select a target folder!';
  videoPrompt:string = 'Process video may take extra disk space, you can select the locate that the temp files locate. SSD recommanded.';
  sysprompt: string = 'cmd';
  ffmpeg: string = '';
  videostepcounter:integer = 0;
implementation

{$R *.lfm}

{ TForm1 }

procedure disable_all();
begin
  form1.bitbtnstart.Enabled := False;
  form1.bitbtnaddpic.Enabled := False;
  form1.BitBtnClearAll.Enabled := False;
  form1.BitBtnEditTask.Enabled := False;
  form1.BitBtnClearFinished.Enabled := False;
  form1.BitBtnClearSelected.Enabled := False;
  form1.BitBtnQuit.Enabled := False;
  form1.BitBtnAbout.Enabled := False;
  form1.BitBtnLog.Enabled := False;
  form1.ListViewMain.Enabled := False;
  form1.BitBtnStop.Enabled := False;
  form1.ListViewMain.Enabled := False;
  form1.BitBtnConfig.Enabled := False;
end;

procedure enable_all();
begin
  form1.bitbtnstart.Enabled := True;
  form1.bitbtnaddpic.Enabled := True;
  form1.BitBtnClearAll.Enabled := True;
  form1.BitBtnClearFinished.Enabled := True;
  form1.BitBtnClearSelected.Enabled := True;
  form1.BitBtnQuit.Enabled := True;
  form1.BitBtnAbout.Enabled := True;
  form1.BitBtnLog.Enabled := True;
  form1.ListViewMain.Enabled := True;
  form1.BitBtnStop.Enabled := True;
  form1.ListViewMain.Enabled := True;
  form1.BitBtnConfig.Enabled := True;
end;

procedure disable_start();
begin
  form1.bitbtnstart.Enabled := False;
  form1.bitbtnaddpic.Enabled := False;
  form1.BitBtnClearAll.Enabled := False;
  form1.BitBtnEditTask.Enabled := False;
  form1.BitBtnClearFinished.Enabled := False;
  form1.BitBtnClearSelected.Enabled := False;
  form1.BitBtnQuit.Enabled := False;
  form1.BitBtnAbout.Enabled := False;
  form1.BitBtnStop.Visible := True;
  form1.BitBtnStart.Visible := False;
  form1.BitBtnStop.Enabled := True;
  form1.BitBtnConfig.Enabled := False;
end;

procedure enable_start();
begin
  form1.bitbtnstart.Enabled := True;
  form1.bitbtnaddpic.Enabled := True;
  form1.BitBtnClearAll.Enabled := True;
  form1.BitBtnClearFinished.Enabled := True;
  form1.BitBtnClearSelected.Enabled := True;
  form1.BitBtnQuit.Enabled := True;
  form1.BitBtnAbout.Enabled := True;
  form1.BitBtnStop.Visible := False;
  form1.BitBtnStart.Visible := True;
  form1.BitBtnStop.Enabled := True;
end;


procedure reload_lang();
// 重置语言
var
  FilePath: string;
  IniFile: TIniFile;
  langPath: string;
  LangFile: TIniFile;
  lang: string;
begin
  FilePath := 'config.ini';
  IniFile := TIniFile.Create(FilePath);
  try
    lang := IniFile.ReadString('base', 'lang', 'en');
  finally
    IniFile.Free;
  end;
  Form1.ComboBoxSelectLang.Text := lang;
  if lang <> 'en' then
  begin
    langpath := 'lang' + syssep + lang + '.ini';
    LangFile := TIniFile.Create(langpath);
    try
      // 语言
      Form1.BitBtnAddPic.Caption :=
        LangFile.ReadString('langstring', 'addtask', 'addtask');
      Form1.BitBtnEditTask.Caption :=
        LangFile.ReadString('langstring', 'edittask', 'edittask');
      Form1.BitBtnClearAll.Caption :=
        LangFile.ReadString('langstring', 'clearall', 'clearall');
      Form1.BitBtnClearFinished.Caption :=
        LangFile.ReadString('langstring', 'clearfinished', 'clearfinished');
      Form1.BitBtnClearSelected.Caption :=
        LangFile.ReadString('langstring', 'clearselected', 'clearselected');
      Form1.BitBtnAbout.Caption := LangFile.ReadString('langstring', 'about', 'about');
      Form1.BitBtnLog.Caption :=
        LangFile.ReadString('langstring', 'displaylog', 'displaylog');
      displaylog := LangFile.ReadString('langstring', 'displaylog', 'displaylog');
      hidelog := LangFile.ReadString('langstring', 'hidelog', 'hidelog');
      Form1.BitBtnConfig.Caption := LangFile.ReadString('langstring', 'config', 'config');
      Form1.BitBtnStop.Caption := LangFile.ReadString('langstring', 'stop', 'stop');
      Form1.BitBtnstart.Caption := LangFile.ReadString('langstring', 'start', 'start');
      Form1.BitBtnQuit.Caption := LangFile.ReadString('langstring', 'quit', 'quit');
      Form1.GroupBoxSource.Caption :=
        LangFile.ReadString('langstring', 'ssfatp', 'ssfatp');
      Form1.BitBtnSelectPicSource.Caption :=
        LangFile.ReadString('langstring', 'ssf', 'ssf');
      Form1.BitBtnSelectVideo.Caption :=
        LangFile.ReadString('langstring', 'ssf', 'ssf');
      Form1.BitBtnTargetPath.Caption := LangFile.ReadString('langstring', 'stf', 'stf');
      Form1.GroupBoxPara.Caption :=
        LangFile.ReadString('langstring', 'setparameters', 'setparameters');
      Form1.LabelSelectPicModel.Caption :=
        LangFile.ReadString('langstring', 'model', 'model');
      Form1.LabelPicScale.Caption := LangFile.ReadString('langstring', 'scale', 'scale');
      Form1.LabelFilenameFormat.Caption :=
        LangFile.ReadString('langstring', 'filename', 'filename');
      Form1.RadioButtonPrefix.Caption :=
        LangFile.ReadString('langstring', 'prefix', 'prefix');
      Form1.RadioButtonSuffix.Caption :=
        LangFile.ReadString('langstring', 'suffix', 'suffix');
      Form1.GroupBoxSettings.Caption :=
        LangFile.ReadString('langstring', 'appsettings', 'appsettings');
      Form1.CheckBoxAdv.Caption :=
        LangFile.ReadString('langstring', 'enableadv', 'enableadv');
      Form1.GroupBoxAdv.Caption := LangFile.ReadString('langstring', 'adv', 'adv');
      Form1.CheckBoxTilesize.Caption :=
        LangFile.ReadString('langstring', 'tilesize', 'tilesize');
      Form1.Labeltile.Caption :=
        LangFile.ReadString('langstring', 'tilesizeprompt', 'tilesizeprompt');
      Form1.CheckBoxGpuid.Caption := LangFile.ReadString('langstring', 'gpuid', 'gpuid');
      Form1.Labelgpu.Caption :=
        LangFile.ReadString('langstring', 'gpuidprompt', 'gpuidprompt');
      Form1.CheckBoxThread.Caption := LangFile.ReadString('langstring', 'lps', 'lps');
      Form1.Labelthread.Caption :=
        LangFile.ReadString('langstring', 'lpsprompt', 'lpsprompt');
      Form1.CheckBoxTTA.Caption := LangFile.ReadString('langstring', 'tta', 'tta');
      Form1.CheckBoxVerbose.Caption :=
        LangFile.ReadString('langstring', 'verbose', 'verbose');
      Form1.GroupBoxOutput.Caption :=
        LangFile.ReadString('langstring', 'outputsetting', 'outputsetting');
      Form1.LabelFormatPrompt.Caption :=
        LangFile.ReadString('langstring', 'formatprompt', 'formatprompt');
      Form1.LabelOutputFormat.Caption :=
        LangFile.ReadString('langstring', 'outputformat', 'outputformat');
      Form1.BitBtnSelectFolderSource.Caption:=
        LangFile.ReadString('langstring', 'selectsrcfolder', 'selectsrcfolder');
      Form1.LabelFolderPrompt.Caption:=
        LangFile.ReadString('langstring', 'folderprompt', 'folderprompt');
      Form1.TabSheetSingleFile.Caption:=
        LangFile.ReadString('langstring', 'tabsingle', 'tabsingle');
      Form1.TabSheetFolder.Caption:=
        LangFile.ReadString('langstring', 'tabfolder', 'tabfolder');
      noFolderPrompt:=
        LangFile.ReadString('langstring', 'nofolderprompt', 'nofolderprompt');
      noFilePrompt:=
        LangFile.ReadString('langstring', 'nofileprompt', 'nofileprompt');
      noTargetPrompt:=
        LangFile.ReadString('langstring', 'notargetprompt', 'notargetprompt');
      form1.Labelworkfolderprompt.Caption:=
        LangFile.ReadString('langstring', 'workfolderprompt', 'workfolderprompt');
      form1.Labelworkfolder.Caption:=
        LangFile.ReadString('langstring', 'workfolder', 'workfolder');
      form1.CheckBoxForceMultihread.Caption:=
        LangFile.ReadString('langstring', 'batch', 'batch');
      forceMultiThreadPrompt:=
        LangFile.ReadString('langstring', 'batchprompt', 'batchprompt');
      videoprompt :=
        LangFile.ReadString('langstring', 'videoprompt', 'videoprompt');
      Form1.TabSheet1.Caption:=
        LangFile.ReadString('langstring', 'tabvideo', 'tabvideo');
      Form1.ffmpeglabel.Caption:=
        LangFile.ReadString('langstring', 'ffmpeglabel', 'ffmpeglabel');
    finally
      LangFile.Free;
    end;
  end;
end;

function ExtractFileNameNoExt(FileString: string): string;
var
  FileWithExtString: string;
  FileExtString: string;
  LenExt: integer;
  LenNameWithExt: integer;
begin
  FileWithExtString := ExtractFileName(FileString);
  LenNameWithExt := Length(FileWithExtString);
  FileExtString := ExtractFileExt(FileString);
  LenExt := Length(FileExtString);
  if LenExt = 0 then
  begin
    Result := FileWithExtString;
  end
  else
  begin
    Result := Copy(FileWithExtString, 1, (LenNameWithExt - LenExt));
  end;
end;

procedure TForm1.BitBtnAddPicClick(Sender: TObject);
begin
  disable_all;
  PanelAddTask.Visible := True;
end;

procedure TForm1.BitBtnAddOKClick(Sender: TObject);
var
  i: integer;
  tmpFolder: string;
begin
  if EditTargetPath.Text='' then
  begin
    Application.MessageBox(PChar(noTargetPrompt),'WARNING',MB_ICONWARNING+MB_OK);
    abort;
  end;
  case PageCtrlFileorFolder.ActivePage.TabIndex of
    0 :    begin
            if not CheckBoxForceMultihread.Checked then
              begin
                begin
                  for i := 0 to ListBoxPicSelect.Items.Count - 1 do
                  begin
                    with ListViewMain.Items.Add do
                    begin
                      Caption := 'Picture'; //添加第一项
                      SubItems.add(ListBoxPicSelect.Items[i]);
                      if RadioButtonPrefix.Checked then
                        SubItems.Add(
                          StringReplace(
                          EditTargetPath.Text + syssep + EditPrefix.Text +
                          ExtractFileNameNoExt(ListBoxPicSelect.Items[i]) + '.' +
                          ComboBoxOutputFormat.Text, syscrlf,
                          '', [rfReplaceAll])
                          )
                      else
                      begin
                        SubItems.Add(
                          StringReplace(
                          EditTargetPath.Text + syssep +
                          ExtractFileNameNoExt(ListBoxPicSelect.Items[i]) +
                          EditPrefix.Text + '.' + ComboBoxOutputFormat.Text,
                          syscrlf, '', [rfReplaceAll])
                          );
                      end;
                      SubItems.add(ComboBoxPicModelSelector.Text);
                      SubItems.add(IntToStr(SpinEditPicScale.Value));
                      SubItems.add('WAIT');
                      SubItems.add(ComboBoxOutputFormat.Text);
                    end;
                  end;
                  ListBoxPicSelect.Items.Clear;
                  EditSourcePath.Text:='';
                  enable_all;
                  PanelAddTask.Visible := False;
                end
              end
            else
              begin
                if ListBoxPicSelect.Items.Count=0 then
                  begin
                    Application.MessageBox(PChar(noFilePrompt),'WARNING',MB_ICONWARNING+MB_OK);
                    abort;
                  end;
                PanelAddTask.Enabled:=False;
                PanelCpFile.Visible:=True;
                ProgressBarCpFile.Max:=ListBoxPicSelect.Items.Count;
                tmpFolder:=TGUID.NewGuid.ToString();
                ForceDirectories(EditWorkingFolder.Text+syssep+tmpFolder);
                for i:=0 to ListBoxPicSelect.Items.Count-1 do
                begin
                  copyfile(ListBoxPicSelect.Items[i], EditWorkingFolder.Text+syssep+tmpFolder+syssep+ExtractFileName(ListBoxPicSelect.Items[i]));
                  ProgressBarCpFile.Position := ProgressBarCpFile.Position + 1;
                end;
                with ListViewMain.Items.Add do
                begin
                  Caption:='Batch';
                  SubItems.add(StringReplace(EditWorkingFolder.Text+syssep+tmpFolder,syscrlf,'',[rfReplaceAll]));
                  SubItems.add(StringReplace(EditTargetPath.Text,syscrlf,'',[rfReplaceAll]));
                  SubItems.add(ComboBoxPicModelSelector.Text);
                  SubItems.add(IntToStr(SpinEditPicScale.Value));
                  SubItems.add('WAIT');
                  SubItems.add(ComboBoxOutputFormat.Text);
                  SubItems.add(EditWorkingFolder.Text + syssep + tmpFolder);
                end;
                enable_all;
                PanelCpFile.Visible:=False;
                PanelAddTask.Enabled:=True;
                PanelAddTask.Visible:=False;
                ComboBoxPicModelSelector.Clear;
              end;
          end;
    1:   begin
          if EditSourcePath.Text='' then
          begin
            Application.MessageBox(PChar(noFolderPrompt),'WARNING',MB_ICONWARNING+MB_OK);
            abort;
          end;
          with ListViewMain.Items.Add do
          begin
            Caption := 'Folder';
            SubItems.add(StringReplace(EditSourcePath.Text,syscrlf, '', [rfReplaceAll]));
            SubItems.Add(
              StringReplace(
              EditTargetPath.Text,
              syscrlf, '', [rfReplaceAll])
              );
            SubItems.add(ComboBoxPicModelSelector.Text);
            SubItems.add(IntToStr(SpinEditPicScale.Value));
            SubItems.add('WAIT');
            SubItems.add(ComboBoxOutputFormat.Text);
            ListBoxPicSelect.Items.Clear;
            EditSourcePath.Text:='';
            enable_all;
            PanelAddTask.Visible := False;
          end;
        end;
    2: begin
                begin
                  for i := 0 to ListBoxvideo.Items.Count - 1 do
                  begin
                    with ListViewMain.Items.Add do
                    begin
                      Caption := 'Video';
                      SubItems.add(ListBoxvideo.Items[i]);
                      if RadioButtonPrefix.Checked then
                        SubItems.Add(
                          StringReplace(
                          EditTargetPath.Text + syssep + EditPrefix.Text +
                          ExtractFileNameNoExt(ListBoxvideo.Items[i]) + '.' +
                          ComboBoxOutputFormat.Text, syscrlf,
                          '', [rfReplaceAll])
                          )
                      else
                      begin
                        SubItems.Add(
                          StringReplace(
                          EditTargetPath.Text + syssep +
                          ExtractFileNameNoExt(ListBoxvideo.Items[i]) +
                          EditPrefix.Text + '.mp4',
                          syscrlf, '', [rfReplaceAll])
                          );
                      end;
                      SubItems.add(ComboBoxPicModelSelector.Text);
                      SubItems.add(IntToStr(SpinEditPicScale.Value));
                      SubItems.add('WAIT');
                      SubItems.add('jpg');
                      tmpFolder:=TGUID.NewGuid.ToString();
                      ForceDirectories(EditWorkingFolder.Text+syssep+tmpFolder);
                      SubItems.add(EditWorkingFolder.Text + syssep + tmpFolder);
                    end;
                  end;
                  ListBoxvideo.Items.Clear;
                  EditSourcePath.Text:='';
                  enable_all;
                  PanelAddTask.Visible := False;
                end
          end;
    end;
  end;

procedure TForm1.BitBtnStopClick(Sender: TObject);
begin
  stopflag := True;
  proc.Close;
  steps := totalsteps+1;
end;

procedure TForm1.BitBtnSelectFolderSourceClick(Sender: TObject);
var
  OpenDialog: TSelectDirectoryDialog;
begin
  OpenDialog := TSelectDirectoryDialog.Create(Self);
  try
    OpenDialog.Options := [ofPathMustExist];
    if OpenDialog.Execute then
    begin
      EditSourcePath.Text := OpenDialog.Files.Text;
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TForm1.BitBtnSelectVideoClick(Sender: TObject);
var
  dialog:TOpenDialog;
  i: integer;
begin
  dialog := TOpenDialog.Create(Self);
  dialog.Filter:='Video (*.avi;*.ts;*.vob;*.mp4;*.mkv;*.mov;*.3gp;*.wmv;*.rm;*.rmvb;*.mpg;*.m4v;*.mpeg;*.flv;*.f4v;)|*.avi;*.ts;*.vob;*.mp4;*.mkv;*.mov;*.3gp;*.wmv;*.rm;*.rmvb;*.mpg;*.m4v;*.mpeg;*.flv;*.f4v|All Files (*.*)|*.*';
  try
    dialog.Options:=[ofAllowMultiSelect,ofEnableSizing,ofViewDetail];
    if Dialog.Execute then
    begin
      for i := 0 to Dialog.Files.Count - 1 do
      begin
        ListBoxVideo.Items.Add(Dialog.Files[i]);
      end;
    end;
  finally
    Dialog.Free;
  end;
end;

procedure TForm1.BitBtnModSelectTarget1Click(Sender: TObject);
var
  OpenDialog: TSelectDirectoryDialog;
begin
  OpenDialog := TSelectDirectoryDialog.Create(Self);
  try
    OpenDialog.Options := [ofPathMustExist];
    if OpenDialog.Execute then
    begin
      EditWorkingFolder.Text := StringReplace(OpenDialog.Files.Text,
        syscrlf, '', [rfReplaceAll]);
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TForm1.BitBtnConfigClick(Sender: TObject);
begin
  disable_all;
  //BitbtnConfig.Enabled:=False;
  PanelAdvanced.Visible := True;
end;

procedure TForm1.BitBtnSettingsOKClick(Sender: TObject);
var
  IniFile: TIniFile;
  FilePath: string;
begin
  FilePath := 'config.ini';
  IniFile := TIniFile.Create(FilePath);
  try
    IniFile.WriteString('base', 'lang', ComboBoxSelectLang.Caption);
  finally
    IniFile.Free;
  end;
  PanelSettings.Visible := False;
  enable_all;
end;

procedure TForm1.BitBtnAboutClick(Sender: TObject);
var
  frm2: TForm;
begin
  frm2 := TForm2.Create(nil);
  frm2.ShowModal;
end;

procedure TForm1.BitBtnClearAllClick(Sender: TObject);
var
  i: integer = 0;
begin
  for i:= 0 to ListViewMain.Items.Count-1 do
  begin
    if ListViewMain.Items[i].Caption='Batch' then
    DeleteDirectory(string(ListViewMain.Items[i].SubItems[6]), False);
  end;
  ListViewMain.Items.Clear;
end;

procedure TForm1.BitBtnEditTaskClick(Sender: TObject);
begin
  disable_all;
  EditModTarget.Text := ListViewMain.Selected.SubItems[1];
  EditModScale.Text := ListViewMain.Selected.SubItems[3];
  PanelModifyPic.Visible := True;
end;

procedure TForm1.BitBtnAddCancelClick(Sender: TObject);
begin
  PanelAddTask.Visible := False;
  enable_all;
end;

procedure TForm1.BitBtnClearFinishedClick(Sender: TObject);
var
  i: integer;
  del: integer = 0;
begin
  for i := 0 to ListViewMain.Items.Count - 1 do
  begin
    if ListViewMain.Items[i - del].SubItems.Strings[4] = 'DONE' then
    begin
      if ListViewMain.Items[i - del].Caption='Batch' then
      DeleteDirectory(string(ListViewMain.Items[i - del].SubItems[6]), False);
      ListViewMain.Items.Delete(i - del);
      del += 1;
    end;
  end;
  del := 0;
end;

procedure TForm1.BitBtnClearSelectedClick(Sender: TObject);
var
  i: integer;
  del: integer = 0;
begin
  for i := 0 to ListViewMain.Items.Count - 1 do
  begin
    if ListViewMain.Items[i - del].Selected then
    begin
      if ListViewMain.Items[i - del].Caption='Batch' then
      DeleteDirectory(string(ListViewMain.Items[i - del].SubItems[6]), False);
      ListViewMain.Items.Delete(i - del);
      del += 1;
    end;
  end;
  del := 0;
end;

procedure TForm1.BitBtnQuitClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.BitBtnLogClick(Sender: TObject);
begin
  if BitBtnLog.Caption = displaylog then
  begin
    BitBtnLog.Caption := hidelog;
    PanelLog.Height := 150;
  end
  else
  begin
    BitBtnLog.Caption := displaylog;
    PanelLog.Height := 0;
  end;
end;

procedure TForm1.BitBtnModSelectTargetClick(Sender: TObject);
var
  OpenDialog: TSelectDirectoryDialog;
  tsltmp: TStringArray;
  filename: string;
begin
  if ListViewMain.Selected.Caption='Picture'
  then
  begin
    tsltmp := ListViewMain.Selected.SubItems.Strings[1].Split([syssep]);
    filename := tsltmp[length(tsltmp) - 1];
    OpenDialog := TSelectDirectoryDialog.Create(Self);
    try
      OpenDialog.Options := [ofPathMustExist];
      if OpenDialog.Execute then // 显示文件保存对话框
      begin
        EditModTarget.Text := StringReplace(OpenDialog.Files.Text + syssep + filename,
          syscrlf, '', [rfReplaceAll]);
      end;
    finally
      OpenDialog.Free;
    end;
  end;
  if ListViewMain.Selected.Caption='Folder'
  then
  begin
    OpenDialog := TSelectDirectoryDialog.Create(Self);
    try
      OpenDialog.Options := [ofPathMustExist];
      if OpenDialog.Execute then
      begin
        EditModTarget.Text := StringReplace(OpenDialog.Files.Text,
          syscrlf, '', [rfReplaceAll]);
      end;
    finally
      OpenDialog.Free;
    end;
  end;
end;

procedure TForm1.BitBtnSelectPicSourceClick(Sender: TObject);
var
  OpenDialog: TOpenPictureDialog;
  i: integer;
begin
  OpenDialog := TOpenPictureDialog.Create(Self);
  OpenDialog.Filter :=
    'Graphic (*.png;*.xpm;*.bmp;*.cur;*.ico;*.icns;*.jpeg;*.jpg;*.jpe;*.jfif;*.tif;*.tiff;*.gif;*.pbm;*.pgm;*.ppm;*.webp)|*.png;*.xpm;*.bmp;*.cur;*.ico;*.icns;*.jpeg;*.jpg;*.jpe;*.jfif;*.tif;*.tiff;*.gif;*.pbm;*.pgm;*.ppm;*.webp|PNG Files (*.png)|*.png|Pixmap Files (*.xpm)|*.xpm|Bitmap Files (*.bmp)|*.bmp|Cursor Files (*.cur)|*.cur|Icon Files (*.ico)|*.ico|macOS Icon Files (*.icns)|*.icns|JPEG Files (*.jpeg;*.jpg;*.jpe;*.jfif)|*.jpeg;*.jpg;*.jpe;*.jfif|Tagged Image File Format Files (*.tif;*.tiff)|*.tif;*.tiff|Graphics Interchange Format Files (*.gif)|*.gif|Portable Pixmap Files (*.pbm;*.pgm;*.ppm)|*.pbm;*.pgm;*.ppm|All files (*.*)|*.*';
  try
    OpenDialog.Options := [ofAllowMultiSelect];
    if OpenDialog.Execute then // 显示文件保存对话框
    begin
      for i := 0 to OpenDialog.Files.Count - 1 do
      begin
        ListBoxPicSelect.Items.Add(OpenDialog.Files[i]);
      end;
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TForm1.BitBtnSettingsCancelClick(Sender: TObject);
begin
  PanelSettings.Visible := False;
  enable_all;
end;

function getAttr(index: integer; _index: integer): string;
begin
  Result := Form1.ListViewMain.Items[index].SubItems.Strings[_index];
end;

procedure stepTasks();
var
  command_tail: string;
begin
  if stopflag then
  begin
    enable_start;
    stopflag := False;
    Form1.LabelStatus.Color := clRed;
    Form1.LabelStatus.Caption := 'aborted';
    Form1.ListViewMain.Items[steps-1].SubItems[4]:='ABORTED';
    abort;
  end;

  if steps < totalsteps then
  begin
    if (not Form1.ListViewMain.Items[steps].SubItems[4].Contains('WAIT')) and (not Form1.ListViewMain.Items[steps].SubItems[4].Contains('PENDING')) then
    begin
      proc.Open(sysprompt,'');
      steps += 1;
      proc.Close;
      exit;
    end;
    if Form1.ListViewMain.Items[steps].Caption = 'Video'
    then
      begin
        case videostepcounter of
          0 : begin
                Form1.LabelStatus.Caption := IntToStr(steps + 1) + ' of ' + IntToStr(Form1.ProgressBar1.Max);
                Form1.ListViewMain.Items[steps].SubItems[4] := 'PENDING';
                command_tail := ' -i "' + getattr(steps, 0) + '" "' + getattr(steps, 6) + syssep +'%d.jpg"';
                Form1.MemoLog.Append(ffmpeg + command_tail);
                steps += 1;
                proc.Open(ffmpeg, command_tail);
              end;
          1 : begin
                command_tail := ' -i "' + getattr(steps, 6) + '" -o "' +
                  getattr(steps, 6)+syssep+'enlarged' + '" -n ' + getattr(steps, 2) + ' -s ' + getattr(steps, 3)+' -f ' + getattr(steps, 5);
                Form1.MemoLog.Append(commandhead + command_tail + extra_cmd_paras);
                ForceDirectories(getattr(steps, 6)+syssep+'enlarged');
                steps += 1;
                proc.Open(commandhead, command_tail + extra_cmd_paras);
              end;
          2 : begin
                command_tail := ' -f image2 -i "' +  getattr(steps, 6) + syssep + 'enlarged' + syssep + '%d.jpg" ' + getattr(steps, 1)
                + syssep + Form1.EditFFmpegArgs.Text;
                Form1.MemoLog.Append(ffmpeg+command_tail);
                steps += 1;
                proc.Open(ffmpeg, command_tail);
              end;
        end;
        //proc.Open(ffmpeg, command_tail);
      end
    else
      begin
        Form1.LabelStatus.Caption := IntToStr(steps + 1) + ' of ' + IntToStr(Form1.ProgressBar1.Max);
        Form1.ListViewMain.Items[steps].SubItems[4] := 'PENDING';
        command_tail := ' -i "' + getattr(steps, 0) + '" -o "' +
          getattr(steps, 1) + '" -n ' + getattr(steps, 2) + ' -s ' + getattr(steps, 3) +
          ' -f ' + getattr(steps, 5);
        Form1.MemoLog.Append(commandhead + command_tail + extra_cmd_paras);
        steps += 1;
        proc.Open(commandhead, command_tail + extra_cmd_paras);
      end;
  end
  else
  begin
    Application.MessageBox(PChar('Total tasks ' + IntToStr(steps) + ' Finished!'),
      'Finish!', MB_ICONINFORMATION + MB_OK);
    Form1.LabelStatus.Caption := 'idle';
    steps := 1;
    totalsteps := 0;
    Form1.LabelStatus.Color := clNone;
    enable_start;
  end;
end;

procedure TForm1.BitBtnStartClick(Sender: TObject);
begin
  ProgressBar1.Position := 0;
  LabelStatus.Color := clLime;
  disable_start;
  ProgressBar1.Max := ListViewMain.Items.Count;
  totalsteps := ListViewMain.Items.Count;
  steps := 0;
  videostepcounter := 0;
  stepTasks;
end;

procedure TForm1.BitBtnTargetPathClick(Sender: TObject);
var
  OpenDialog: TSelectDirectoryDialog;
  IniFile: TIniFile;
begin
  OpenDialog := TSelectDirectoryDialog.Create(Self);
  try
    OpenDialog.Options := [ofPathMustExist];
    if OpenDialog.Execute then
    begin
      EditTargetPath.Text := OpenDialog.Files.Text;
    end;
  finally
    OpenDialog.Free;
  end;
  IniFile := TIniFile.Create('config.ini');
  try
     IniFile.WriteString('base', 'latest_targget_folder', EditTargetPath.Text);
  finally
    IniFile.Free;
  end;
end;

procedure TForm1.ButtonAdvApplyClick(Sender: TObject);
var
  IniFile: TIniFile;
  FilePath: string;
begin
  FilePath := 'config.ini';
  IniFile := TIniFile.Create(FilePath);
  try
    IniFile.WriteString('base', 'lang', ComboBoxSelectLang.Caption);
    IniFile.WriteString('settings', 'working_folder', EditWorkingFolder.Text);
    if CheckBoxTilesize.Checked then IniFile.WriteString('settings', 't', '1')
    else IniFile.WriteString('settings', 't', '0');
    if CheckBoxGpuid.Checked then IniFile.WriteString('settings', 'g', '1')
    else IniFile.WriteString('settings', 'g', '0');
    if CheckBoxThread.Checked then IniFile.WriteString('settings', 'lps', '1')
    else IniFile.WriteString('settings', 'lps', '0');
    if CheckBoxTTA.Checked then IniFile.WriteString('settings', 'x', '1')
    else IniFile.WriteString('settings', 'x', '0');
    if CheckBoxVerbose.Checked then IniFile.WriteString('settings', 'v', '1')
    else IniFile.WriteString('settings', 'v', '0');
    if CheckBoxAdv.Checked then IniFile.WriteString('settings', 'adv_enabled', '1')
    else IniFile.WriteString('settings', 'adv_enabled', '0');
    IniFile.WriteString('settings', 'tc', EditTileSize.Text);
    IniFile.WriteString('settings', 'gc', EditGpuid.Text);
    IniFile.WriteString('settings', 'lpsc', EditThread.Text);
    IniFile.WriteString('settings', 'ffmpegargs', EditFFmpegargs.Text);
  finally
    IniFile.Free;
  end;
  reload_lang;
  if CheckBoxAdv.Checked then
  begin
    extra_cmd_paras := '';
    if CheckBoxTileSize.Checked then
      extra_cmd_paras := extra_cmd_paras + ' -t ' + EditTileSize.Text;
    if CheckBoxGpuid.Checked then
      extra_cmd_paras := extra_cmd_paras + ' -g ' + EditGpuid.Text;
    if CheckBoxThread.Checked then
      extra_cmd_paras := extra_cmd_paras + ' -j ' + EditThread.Text;
    if CheckBoxTTA.Checked then extra_cmd_paras := extra_cmd_paras + ' -x';
    if CheckBoxVerbose.Checked then extra_cmd_paras := extra_cmd_paras + ' -v';
  end
  else
    extra_cmd_paras := '';
  PanelAdvanced.Visible := False;
  enable_all;
end;

procedure TForm1.ButtonAdvCancelClick(Sender: TObject);
begin
  PanelAdvanced.Visible := False;
  enable_all;
end;


procedure TForm1.ButtonModApplyClick(Sender: TObject);
begin
  ListViewMain.Selected.SubItems[1] := EditModTarget.Text;
  ListViewMain.Selected.SubItems[3] := EditModScale.Text;
  ListViewMain.Selected.SubItems[2] := ComboBoxModModel.Text;
  PanelModifyPic.Visible := False;
  if steps <= totalsteps then
  begin
    enable_all;
    disable_start;
  end
  else
  begin
    enable_all;
    BitBtnEditTask.Enabled := True;
  end;
end;

procedure TForm1.ButtonModCancelClick(Sender: TObject);
begin
  PanelModifyPic.Visible := False;
  if steps <= totalsteps then
  begin
    enable_all;
    disable_start;
  end
  else
  begin
    enable_all;
    BitBtnEditTask.Enabled := True;
  end;
end;

procedure TForm1.CheckBoxAdvChange(Sender: TObject);
begin
  if CheckBoxAdv.Checked then GroupBoxAdv.Enabled := True
  else
    GroupBoxAdv.Enabled := False;

end;

procedure TForm1.CheckBoxForceMultihreadClick(Sender: TObject);
begin
  if CheckBoxForceMultihread.Checked then
  begin
    Application.MessageBox(PChar(forceMultiThreadPrompt),'WARNING',MB_ICONWARNING+MB_OK);
    PanelSingleFileCtrl.Enabled:=False;
  end
  else PanelSingleFileCtrl.Enabled:=True;
end;

procedure TForm1.ComboBoxPicModelSelectorChange(Sender: TObject);
begin
  if pos('x2', ComboBoxPicModelSelector.Text) > 0 then SpinEditPicScale.Text := '2';
  if pos('x3', ComboBoxPicModelSelector.Text) > 0 then SpinEditPicScale.Text := '3';
  if pos('x4', ComboBoxPicModelSelector.Text) > 0 then SpinEditPicScale.Text := '4';
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  proc.Close;
end;

procedure loadconfig();
var
  IniFile: TIniFile;
  FilePath: string;
begin
  FilePath := 'config.ini';
  IniFile := TIniFile.Create(FilePath);
  try
    if IniFile.ReadString('base', 'latest_targget_folder', '') = ''
    then IniFile.WriteString('base', 'latest_targget_folder', ExtractFileDir(ParamStr(0)));
    if IniFile.ReadString('base', 'working_folder', '') = ''
    then IniFile.WriteString('base', 'working_folder', ExtractFileDir(ParamStr(0)));
    Form1.EditTargetPath.Text := IniFile.ReadString('base', 'latest_targget_folder', ExtractFileDir(ParamStr(0)));
    Form1.EditWorkingFolder.Text := IniFile.ReadString('base', 'working_folder', ExtractFileDir(ParamStr(0)));
    if IniFile.ReadString('settings', 'adv_enabled', '0') = '0' then
    begin
      Form1.CheckBoxAdv.Checked:=False;
      Form1.GroupBoxAdv.Enabled:=False;
    end
    else
    begin
      Form1.CheckBoxAdv.Checked:=True;
      Form1.GroupBoxAdv.Enabled:=True;
    end;
    if Form1.CheckBoxAdv.Checked then
    begin
      extra_cmd_paras := '';
      if Form1.CheckBoxTileSize.Checked then
        extra_cmd_paras := extra_cmd_paras + ' -t ' + Form1.EditTileSize.Text;
      if Form1.CheckBoxGpuid.Checked then
        extra_cmd_paras := extra_cmd_paras + ' -g ' + Form1.EditGpuid.Text;
      if Form1.CheckBoxThread.Checked then
        extra_cmd_paras := extra_cmd_paras + ' -j ' + Form1.EditThread.Text;
      if Form1.CheckBoxTTA.Checked then extra_cmd_paras := extra_cmd_paras + ' -x';
      if Form1.CheckBoxVerbose.Checked then extra_cmd_paras := extra_cmd_paras + ' -v';
    end
    else extra_cmd_paras := '';
    if IniFile.ReadString('settings', 't', '0') = '0' then
      Form1.CheckBoxTilesize.Checked:=False
    else
      Form1.CheckBoxTilesize.Checked:=True;
    if IniFile.ReadString('settings', 'g', '0') = '0' then
      Form1.CheckBoxGpuid.Checked:=False
    else
      Form1.CheckBoxGpuid.Checked:=True;
    if IniFile.ReadString('settings', 'lps', '0') = '0' then
      Form1.CheckBoxThread.Checked:=False
    else
      Form1.CheckBoxThread.Checked:=True;
    if IniFile.ReadString('settings', 'x', '0') = '0' then
      Form1.CheckBoxTTA.Checked:=False
    else
      Form1.CheckBoxTTA.Checked:=True;
    if IniFile.ReadString('settings', 'v', '0') = '0' then
      Form1.CheckBoxVerbose.Checked:=False
    else
      Form1.CheckBoxVerbose.Checked:=True;
    form1.EditTileSize.Text:=IniFile.ReadString('settings', 'tc', '0');
    form1.EditGpuid.Text:=IniFile.ReadString('settings', 'gc', 'auto');
    form1.EditThread.Text:=IniFile.ReadString('settings', 'lpsc', '1:2:2');
    form1.EditFFmpegargs.Text := IniFile.ReadString('settings', 'ffmpegargs', '');
  finally
    IniFile.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  BinFiles: TStringList;
  langfiles: TStringList;
  i: integer;
  tsatmp: TStringArray;
  tsatmp2: TStringArray;
begin
  loadconfig;
  PageCtrlFileorFolder.TabIndex:=0;
  BinFiles := TStringList.Create;
  try
    FindAllFiles(BinFiles, 'bin/realesrgan/models', '*.bin', True);
    for i := 0 to BinFiles.Count - 1 do
    begin
      tsatmp := BinFiles.Strings[i].Split(['/', '\']);
      tsatmp2 := tsatmp[Length(tsatmp) - 1].Split(['.bin']);
      ComboBoxPicModelSelector.Items.Add(tsatmp2[0]);
      ComboBoxModModel.Items.Add(tsatmp2[0]);
    end;
    ComboBoxPicModelSelector.Caption := 'realesrgan-x4plus-anime';
    ComboBoxModModel.ItemIndex := 0;
  finally
    BinFiles.Free;
  end;

  langFiles := TStringList.Create;
  try
    FindAllFiles(langFiles, 'lang', '*.ini', True);
    for i := 0 to langFiles.Count - 1 do
    begin
      tsatmp := langFiles.Strings[i].Split(['/', '\']);
      tsatmp2 := tsatmp[Length(tsatmp) - 1].Split(['.ini']);
      ComboBoxSelectLang.Items.Add(tsatmp2[0]);
      ComboBoxSelectLang.ItemIndex := 0;
    end;
  finally
    langFiles.Free;
  end;
  PanelLog.Height := 0;
  proc := TConsoleProc.Create(nil);
  proc.OnInitScreen := @procInitScreen;
  proc.OnRefreshLine := @procRefreshLine;
  proc.OnRefreshLines := @procRefreshLines;
  proc.OnAddLine := @procAddLine;
  proc.OnChangeState := @procChangeState;
  commandhead := 'bin\realesrgan\realesrgan-ncnn-vulkan.exe';
  ffmpeg := 'bin\ffmpeg\bin\ffmpeg.exe';
  syssep := '\';
  {$ifdef linux}
  //txtProcess.Text:= 'bash';
  //txtCommand.Text := 'ls';
  commandhead:='bin/realesrgan/realesrgan-ncnn-vulkan';
  ffmpeg := 'bin/ffmpeg/bin/ffmpeg';
  proc.LineDelimSend := LDS_LF;
  syssep:='/';
  syscrlf:=chr(10);
  sysprompt := 'bash';
  {$endif}
  reload_lang;
end;

procedure TForm1.LabelAdvancedSettingsClick(Sender: TObject);
begin
  PanelAdvanced.Visible := True;
  disable_all;
end;


procedure TForm1.ListViewMainSelectItem(Sender: TObject; Item: TListItem;
  Selected: boolean);
var
  i: integer;
  _selected: integer = 0;
begin
  for i := 0 to ListViewMain.Items.Count - 1 do
  begin
    if ListViewMain.Items[i].Selected then
      _selected += 1;
  end;
  if _selected = 1 then BitBtnEditTask.Enabled := True
  else
    BitBtnEditTask.Enabled := False;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  proc.Destroy;
end;

procedure TForm1.PageCtrlFileorFolderChange(Sender: TObject);
begin
  // if PageCtrlFileorFolder.ActivePage.TabIndex=0 then PanelSingleFileCtrl.Enabled:=True;
  if PageCtrlFileorFolder.ActivePage.TabIndex=1 then PanelSingleFileCtrl.Enabled:=False else PanelSingleFileCtrl.Enabled:=True;
  if PageCtrlFileorFolder.ActivePage.TabIndex=2 then GroupBoxOutput.Enabled:=False else GroupBoxOutput.Enabled:=True;
end;

procedure TForm1.procChangeState(State: string; pFinal: TPoint);
begin
  //showmessage(State);
  if State = 'Stopped' then
    //Form1.ListViewMain.Items[steps-1].SubItems[4]:='DONE';
  begin
    if stopflag then
    begin
      stepTasks;
      stopflag := False;
    end;
    if Form1.ListViewMain.Items[steps - 1].Caption='Video' then
    begin
      case videostepcounter of
        0 : begin
              videostepcounter := videostepcounter + 1;
              steps-=1;
              stepTasks;
              exit;
            end;
        1 : begin
              videostepcounter := videostepcounter + 1;
              steps-=1;
              stepTasks;
              exit;
            end;
        //2 : videostepcounter := videostepcounter + 1;
        2 : begin
              Form1.ListViewMain.Items[steps - 1].SubItems[4] := 'DONE';
              DeleteDirectory(string(Form1.ListViewMain.Items[steps - 1].SubItems[6]), False);
              videostepcounter := 0;
            end;
      end;
    end;
    Form1.ListViewMain.Items[steps - 1].SubItems[4] := 'DONE';
    if Form1.ListViewMain.Items[steps - 1].Caption='Batch' then
    begin
      DeleteDirectory(string(Form1.ListViewMain.Items[steps - 1].SubItems[6]), False);
    end;
    //if Form1.ListViewMain.Items[steps - 1].Caption='Video' then
    //begin
    //  DeleteDirectory(string(Form1.ListViewMain.Items[steps - 1].SubItems[6]), False);
    //end;
    //Form1.ListViewMain.Selected.;
    Form1.ProgressBar1.Position := steps;
    stepTasks;
  end;
end;

procedure TForm1.procAddLine(HeightScr: integer);
begin
  MemoLog.Lines.Add('');
end;

procedure TForm1.procInitScreen(const grilla: TtsGrid; fIni, fFin: integer);
var
  i: integer;
begin
  for i := fIni to fFin do MemoLog.Lines.Add(grilla[i]);
end;

procedure TForm1.procRefreshLine(const grilla: TtsGrid; fIni, HeightScr: integer);
var
  yvt: integer;
begin
  yvt := MemoLog.Lines.Count - HeightScr - 1;
  MemoLog.Lines[yvt + fIni] := grilla[fIni];
end;

procedure TForm1.procRefreshLines(const grilla: TtsGrid;
  fIni, fFin, HeightScr: integer);
var
  yvt: integer;
  f: integer;
begin
  yvt := MemoLog.Lines.Count - HeightScr - 1;
  //Calculate equivalent row to start of VT100 screen
  for f := fIni to fFin do
  begin
    MemoLog.Lines[yvt + f] := grilla[f];
  end;
end;


end.

