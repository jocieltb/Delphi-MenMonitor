unit Unit1;

interface

uses
  Windows, ShellApi,IniFiles, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, Mask, MPlayer, Menus;

type
  TForm1 = class(TForm)
    Image1: TImage;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    sbstop: TSpeedButton;
    sbplay: TSpeedButton;
    sbpause: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Timer1: TTimer;
    Image2: TImage;
    Image3: TImage;
    Media: TMediaPlayer;
    Timer2: TTimer;
    Image5: TImage;
    ComboBox1: TComboBox;
    Label8: TLabel;
    sbvolt: TSpeedButton;
    sbavanc: TSpeedButton;
    PopupMenu1: TPopupMenu;
    Sair1: TMenuItem;
    SempreaFrente1: TMenuItem;
    Limpa: TMenuItem;
    SpeedButton1: TSpeedButton;
    Timer3: TTimer;
    function tempmusic(temp: integer): string;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbplayClick(Sender: TObject);
    procedure sbpauseClick(Sender: TObject);
    procedure sbstopClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure MediaNotify(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure sbavancClick(Sender: TObject);
    procedure sbvoltClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SempreaFrente1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LimpaClick(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    
  private
    { Private declarations }
    procedure PegarArquivoArrastato(var Msg : TWMDropFiles); message WM_DROPFILES;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Hdesl, Transp, Musica, skin, progress:string;
  EscArq, LerArq : TIniFile;
  a,b,sext, Tdesl: integer;
implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.Timer1Timer(Sender: TObject);
const
  cBytesPorMb = 1024 * 1024;
var
  convert,mem: Integer;
  shora, strmem, sseg: string;
  hora1, hora2, total: TDateTime;
  EspLivre, EspTotal: Real;
  M: TMemoryStatus;
begin
  label3.Caption:=datetostr(date);
  label4.Caption:=timetostr(time);
  label5.Caption:=timetostr(strtotime(form2.MaskEdit1.Text)- time);
  convert:= (DiskSize(0)div 1048576) div 108;
  EspTotal:= Trunc(DiskSize(0)/1073741824 * 100)/ 100 ;
  image2.Width:=((disksize(0)-diskfree(0))div 1048576) div convert;
  EspLivre:= trunc(diskfree(0) / 1073741824 * 100)/ 100;
  label1.caption:= floattostr(100 - Trunc((diskfree(0)*100)/ DiskSize(0)*100)/100)+ '% Usado';
  M.dwLength := SizeOf(M);
  GlobalMemoryStatus(M);
  label2.Caption:= Format('%d%%',
  [M.dwMemoryLoad])+' em Uso.';
  strmem:=format('%d%',[M.dwMemoryLoad]);
  image3.Width:= trunc(strtoint(strmem)* 1.08);
  speedbutton1.Hint:= 'Tamanho: ' + floattostr(espTotal)+' GB'+#13+'Espaço Usado: '+ floattostr(Trunc((disksize(0)-diskfree(0)) /1073741824 * 100)/ 100)+#13+ 'Espaço Livre: '+ floattostr(esplivre)+' GB';
  speedbutton2.Hint:= 'Memória Total '+Format('%f MB',[M.dwTotalPhys / cBytesPorMb]);
  if form2.CheckBox1.Checked = true then
  begin
    if label5.Caption = '00:00:00' then
    begin
      tdesl:=15;
      timer3.Enabled:=true;
      timer1.Enabled:=false;
      Case MessageBox (Application.Handle, Pchar ('Deseja Desligar o Computador' + #13 + 'desligar em 15 segundos'), 'Desligamento Automático', MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2) of
        idOk: begin Winexec('shutdown -s -f -t 00',0); end;
        idCancel:begin
           timer3.Enabled:=false;
          timer1.Enabled:=true;
          label5.Visible:=false;
        end;
      end;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  media.FileName:= ExtractFilePath(Application.Exename)+'som.mp3';
  combobox1.ItemIndex:=0;
  DragAcceptFiles(Handle, True);
  top:=15;
  Left:= screen.width - 220;
  image5.Width:=1;
  label6.Caption:= Hdesl;
  LerArq:=TiniFile.Create(ExtractFilePath(Application.Exename)+'Configuration.Ini');
  skin:=lerarq.ReadString('Configuration','skin','');
  if skin = '01' then
  begin
    image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'skins/01.bmp');
    form1.label1.Font.Color:=clyellow;
    form1.label2.Font.Color:=clyellow;
  end;
  if skin = '02' then
  begin
    image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'skins/02.bmp');
    form1.label1.Font.Color:=clyellow;
    form1.label2.Font.Color:=clyellow;
  end;
  if skin = '03' then
  begin
    image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'skins/03.bmp');
  end;
  if skin = '04' then
  begin
    image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'skins/04.bmp');
    form1.label1.Font.Color:=clyellow;
    form1.label2.Font.Color:=clyellow;
  end;
  if skin = '05' then
  begin
    image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'skins/05.bmp');
    form1.label1.Font.Color:=clblack;
    form1.label2.Font.Color:=clblack;
  end;
  LerArq:=TiniFile.Create(ExtractFilePath(Application.Exename)+'Configuration.Ini');
  Transp:=lerarq.ReadString('Configuration','Transparencia','');
  form1.AlphaBlendValue:= strtoint(transp);
  Label6.Hint:= 'Horário Especificado para Desligar o Computador';
  Label5.Hint:= 'Tempo Restante para Desligar o Computador';
  Label5.Visible:=false;
  label6.Visible:=false;
end;

procedure TForm1.sbplayClick(Sender: TObject);
begin
  media.Play;
  limpa.Enabled:=false;
  sbplay.Visible:=false;
  sbstop.Visible:=true;
  sbpause.Visible:=true;
  sbavanc.Visible:=true;
  sext:= length(extractfilename(media.FileName))-4;
  label8.Caption:= copy(extractfilename(media.FileName),1,sext);
  label8.Visible:=true;
  if length(label8.Caption) > 25 then
  begin
    label8.Caption:= copy(label8.Caption,1,25)+'...';
  end;
end;
procedure TForm1.sbpauseClick(Sender: TObject);
begin
  media.Pause;
  sbpause.Visible:= false;
  sbplay.Visible:=true;
  sbavanc.Visible:=false;
  sbstop.Visible:=true;
  sbvolt.Visible:=false;
end;

procedure TForm1.sbstopClick(Sender: TObject);
begin
  media.Previous;
  media.Stop;
  sbstop.Visible:=false;
  sbplay.Visible:=true;
  sbpause.Visible:=false;
  sbavanc.Visible:=false;
  sbvolt.Visible:=false;
  limpa.Enabled:=true;
  label8.Visible:=false;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  b:=media.TrackLength[1];
  a:=b div 158;
  image5.Width:=(media.Position div a);
  image5.Hint:='Tempo: '+tempmusic(media.Position);
end;

procedure TForm1.PegarArquivoArrastato(var Msg: TWMDropFiles);
var
  i : Integer;
  NumerodeArquivo : Integer;
  NomedoArquivo : String;
begin
  SetLength(NomedoArquivo,255);
  NumerodeArquivo := DragQueryFile(Msg.Drop,$FFFFFFFF,PChar(NomedoArquivo),255);
  for i := 0 to NumerodeArquivo-1 do begin
  DragQueryFile(Msg.Drop,i,PChar(NomedoArquivo),255);
  combobox1.Items.Add(NomedoArquivo);
  combobox1.ItemIndex:=0;
  media.FileName:=combobox1.Items.Strings[combobox1.ItemIndex];
  media.Open;
  sbplay.Visible:=true;
  timer2.Enabled:=true;
  end;
end;
procedure TForm1.MediaNotify(Sender: TObject);
var
  s:string;
  total:integer;
  begin
  case media.NotifyValue of
  nvsuccessful:begin
  inc(total);
  s:=inttostr(total);
  end;
end;

if s=inttostr(total) then
begin
  sbvolt.Visible:= true;
  combobox1.ItemIndex:=combobox1.ItemIndex+1;
  media.FileName:=combobox1.Items.Strings[combobox1.ItemIndex];
  media.Open;
  sext:=  length(extractfilename(combobox1.Items.Strings[combobox1.itemindex]))-4;
  label8.Caption:=copy(extractfilename(combobox1.Items.Strings[combobox1.itemindex]),1,sext);
  if length(label8.Caption) > 25 then
  begin
    label8.Caption:= copy(label8.Caption,1,25)+'...';
  end;
  if combobox1.ItemIndex = combobox1.Items.Count then
  begin
    combobox1.ItemIndex:=0;
    media.FileName:=combobox1.Items.Strings[combobox1.ItemIndex];
    media.Open;
    media.Play;
  end;
   media.Play;
  end;
end;
procedure TForm1.SpeedButton9Click(Sender: TObject);
begin
  form2.Show;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  tdesl:=15;
  timer3.Enabled:=true;
  Case MessageBox (Application.Handle, Pchar ('Deseja Desligar o Computador' + #13 + 'desligar em 15 segundos'), 'Desligamento Automático', MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2) of
  idOk: begin Winexec('shutdown -s -f -t 00',0); end;
    idCancel:begin
      timer3.Enabled:=false;
    end;
  end;
end;

procedure TForm1.sbavancClick(Sender: TObject);
begin
  sbvolt.Visible:= true;
  combobox1.ItemIndex:=combobox1.ItemIndex+1;
  media.FileName:=combobox1.Items.Strings[combobox1.ItemIndex];
  media.Open;
  sext:=  length(extractfilename(combobox1.Items.Strings[combobox1.itemindex]))-4;
  label8.Caption:=copy(extractfilename(combobox1.Items.Strings[combobox1.itemindex]),1,sext);
  if length(label8.Caption) > 25 then
  begin
    label8.Caption:= copy(label8.Caption,1,25)+'...';
  end;
  media.Play;
end;

procedure TForm1.sbvoltClick(Sender: TObject);
begin
  combobox1.ItemIndex:=combobox1.ItemIndex-1;
  if combobox1.ItemIndex = 0 then
  begin
    sbvolt.Visible:= false;
  end;
  media.FileName:=combobox1.Items.Strings[combobox1.ItemIndex];
  media.Open;
  sext:=  length(extractfilename(combobox1.Items.Strings[combobox1.itemindex]))-4;
  label8.Caption:=copy(extractfilename(combobox1.Items.Strings[combobox1.itemindex]),1,sext);
  if length(label8.Caption) > 25 then
  begin
    label8.Caption:= copy(label8.Caption,1,25)+'...';
  end;
  media.Play;
end;

function TForm1.tempmusic(temp: integer): string;
var
  strseg, strmin:string;
  s,m:integer;
begin
  s:=temp div 1000;
  if s<60 then
  begin
    m:=0;
    s:=s;
  end;
  if s >=59 then
  begin
    m:=s div 60;
    s:=s -(m*60);
end;

strseg:=inttostr(s);
strmin:=inttostr(m);
if length(strseg)<2 then
strseg:='0'+strseg;
if length(strmin)<2 then
strmin:='0'+strmin;
result:=strmin+':'+strseg;
end;

procedure TForm1.Sair1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012; { a magic number, no idea where it's documented }
begin 
  if Button = mbLeft then 
    begin 
      ReleaseCapture;
      Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0); 
    end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ShowWindow(FindWindow(nil,'MenMonitor'),SW_HIDE);
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar(ExtractFilePath(Application.Exename)+'manual.doc'), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.SempreaFrente1Click(Sender: TObject);
begin
  if sempreafrente1.Checked = true then
  begin
    sempreafrente1.Checked:=false;
    SetWindowPos(Form1.handle, HWND_NOTOPMOST, Form1.Left, Form1.Top,Form1.Width, Form1.Height, 0); // HWND_NOTOPMOST normal
  end
  else
  begin
    sempreafrente1.Checked:=true;
    SetWindowPos(Form1.handle, HWND_TOPMOST, Form1.Left, Form1.Top,Form1.Width, Form1.Height, 0); // HWND_NOTOPMOST normal
  end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  if sempreafrente1.Checked = true then
  begin
    SetWindowPos(Form1.handle, HWND_TOPMOST, Form1.Left, Form1.Top,Form1.Width, Form1.Height, 0); // HWND_NOTOPMOST normal
  end
  else
  begin
    SetWindowPos(Form1.handle, HWND_NOTOPMOST, Form1.Left, Form1.Top,Form1.Width, Form1.Height, 0); // HWND_NOTOPMOST normal
  end;
end;

procedure TForm1.LimpaClick(Sender: TObject);
begin
  combobox1.Clear;
  sbplay.Visible:=false;
  sbpause.Visible:=false;
  sbstop.Visible:=false;
  sbavanc.Visible:=false;
  sbvolt.Visible:=false;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
  tdesl:=tdesl-1;
  if tdesl = 0 then
  begin
    Winexec('shutdown -s -f -t 00',0);
  end;
end;

end.
