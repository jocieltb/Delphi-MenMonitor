unit Unit2;

interface

uses
  Windows, Messages, shellapi, Inifiles, StdCtrls, Mask, Controls, ComCtrls, Classes, SysUtils, Variants, Graphics, Forms,
  Dialogs, jpeg, ExtCtrls, Buttons;

type
  TForm2 = class(TForm)
    Page: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Label7: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Image2: TImage;
    MaskEdit1: TMaskEdit;
    CheckBox1: TCheckBox;
    TrackBar1: TTrackBar;
    ListBox1: TListBox;
    Button1: TButton;
    CheckBox2: TCheckBox;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Image1: TImage;
    Label3: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure MaskEdit1Enter(Sender: TObject);
    procedure MaskEdit1Exit(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  Hdesl:= maskedit1.Text;
  form1.label6.Caption:= Hdesl;
  EscArq:= TIniFile.Create(ExtractFilePath(Application.Exename)+'Configuration.Ini');
  EscArq.WriteString('Configuration','Transparencia',inttostr(trackbar1.Position));
  if checkbox1.Checked = true then begin
    form1.label5.Visible:=true;
    form1.Label6.Visible:=true;
  end;
  if checkbox1.Checked = false then begin
    EscArq:= TIniFile.Create(ExtractFilePath(Application.Exename)+'Configuration.Ini');
    EscArq.WriteString('Configuration','Checked','false');
    form1.label5.Visible:=false;
    form1.label6.Caption:='00:00:00';
  end;
  close;
end;


procedure TForm2.TrackBar1Change(Sender: TObject);
begin
form1.AlphaBlendValue:= trackbar1.Position;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  LerArq:=TiniFile.Create(ExtractFilePath(Application.Exename)+'Configuration.Ini');
  Transp:=lerarq.ReadString('Configuration','Transparencia','');
  trackbar1.Position:= strtoint(transp);
  top:= form1.top + 50;
  Left:= form1.Left - 300;

end;

procedure TForm2.CheckBox2Click(Sender: TObject);
begin
  form1.SempreaFrente1.Checked:=checkbox2.Checked;
end;

procedure TForm2.ListBox1DblClick(Sender: TObject);
  begin
  if listbox1.itemindex = 0 then
  begin
    image2.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'skins/01.bmp');
    form1.image1.Picture:=image2.Picture;
    EscArq:= TIniFile.Create(ExtractFilePath(Application.Exename)+'Configuration.Ini');
    EscArq.WriteString('Configuration','Skin','01');
    form1.label1.Font.Color:=clyellow;
    form1.label2.Font.Color:=clyellow;
  end;
if listbox1.itemindex = 1 then
begin
image2.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'skins/02.bmp');
form1.image1.Picture:=image2.Picture;
EscArq:= TIniFile.Create(ExtractFilePath(Application.Exename)+'Configuration.Ini');
EscArq.WriteString('Configuration','Skin','02');
form1.label1.Font.Color:=clyellow;
form1.label2.Font.Color:=clyellow;
end;
if listbox1.itemindex = 2 then
begin
image2.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'skins/03.bmp');
form1.image1.Picture:=image2.Picture;
EscArq:= TIniFile.Create(ExtractFilePath(Application.Exename)+'Configuration.Ini');
EscArq.WriteString('Configuration','Skin','03');
form1.label1.Font.Color:=clblack;
form1.label2.Font.Color:=clblack;
end;
if listbox1.itemindex = 3 then
begin
image2.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'skins/04.bmp');
form1.image1.Picture:=image2.Picture;
EscArq:= TIniFile.Create(ExtractFilePath(Application.Exename)+'Configuration.Ini');
EscArq.WriteString('Configuration','Skin','04');
form1.label1.Font.Color:=clyellow;
form1.label2.Font.Color:=clyellow;
end;
if listbox1.itemindex = 4 then
begin
image2.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'skins/05.bmp');
form1.image1.Picture:=image2.Picture;
EscArq:= TIniFile.Create(ExtractFilePath(Application.Exename)+'Configuration.Ini');
EscArq.WriteString('Configuration','Skin','05');
form1.label1.Font.Color:=clblack;
form1.label2.Font.Color:=clblack;
end;
end;

procedure TForm2.MaskEdit1Enter(Sender: TObject);
begin
form1.timer1.Enabled:=false;
end;

procedure TForm2.MaskEdit1Exit(Sender: TObject);
begin
form1.Timer1.Enabled:=true;
end;

procedure TForm2.CheckBox1Click(Sender: TObject);
begin
if checkbox1.Checked = true then
begin
maskedit1.Enabled:=true;
end
else
begin
maskedit1.Enabled:=false;
end;
end;

procedure TForm2.ListBox1Click(Sender: TObject);
begin
image2.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'skins/0'+inttostr(listbox1.ItemIndex + 1)+'.bmp');
end;

end.
