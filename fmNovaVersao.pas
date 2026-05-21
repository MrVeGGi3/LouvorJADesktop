unit fmNovaVersao;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos Windows/Messages/VCL/bsSkin*/FireDAC/Indy/Delphi-specific}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grids, DBGrids,
  DBCtrls, DB, Menus, ValEdit, MaskEdit, IniFiles, StrUtils,
  CheckLst, Spin, EditBtn, ColorBox, LCLIntf, LCLType, LResources;

type
  TfNovaVersao = class(TForm)
    OpenDialog1: TOpenDialog {LAZARUS: TbsSkinOpenDialog};
    {bsBusinessSkinForm1: TbsBusinessSkinForm;} {LAZARUS: removido}
    bsSkinPanel1: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinButton2: TButton {LAZARUS: TbsSkinButton};
    bsSkinButton3: TButton {LAZARUS: TbsSkinButton};
    bsSkinPanel2: TPanel {LAZARUS: TbsSkinPanel};
    Image1: TImage {LAZARUS: TbsPngImageView};
    bsSkinPanel3: TPanel {LAZARUS: TbsSkinPanel};
    lbl1: TLabel {LAZARUS: TbsSkinStdLabel};
    lblMsg: TLabel {LAZARUS: TbsSkinStdLabel};
    GridPanel4: TPanel {LAZARUS: TGridPanel};
    lbl2: TLabel {LAZARUS: TbsSkinStdLabel};
    lblVAtu: TLabel {LAZARUS: TbsSkinStdLabel};
    lbl3: TLabel {LAZARUS: TbsSkinStdLabel};
    lblVNova: TLabel {LAZARUS: TbsSkinStdLabel};
    progress: TProgressBar;
    Timer1: TTimer;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure bsSkinButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    setup_dir: string;
  public
    { Public declarations }

  end;

var
  fNovaVersao: TfNovaVersao;

implementation

uses
  fmMenu, fmAtualiza, fmIniciando, dmComponentes;



procedure TfNovaVersao.bsSkinButton2Click(Sender: TObject);
begin
  close;
end;

procedure TfNovaVersao.bsSkinButton3Click(Sender: TObject);
var
  lista: TStringList;
  Flags: Cardinal;
  inst: string;
begin

  if False then {LAZARUS: InternetGetConnectedState removido — assume conectado}
  begin
    application.messagebox(PChar('N�o foi poss�vel conectar � internet! Verifique sua conex�o e tente novamente.'), fmIndex.TITULO, MB_OK + mb_iconerror);
    Exit;
  end;

  progress.Visible := true;
  bsSkinButton3.Enabled := false;
  bsSkinButton2.Enabled := false;
  lbl1.Caption := 'Aguarde... atualizando o programa...';

  timer1.Enabled := true;
end;

procedure TfNovaVersao.FormActivate(Sender: TObject);
begin
  progress.Visible := false;
  bsSkinButton3.Enabled := true;
  bsSkinButton2.Enabled := true;
  lbl1.Caption := 'H� uma nova vers�o dispon�vel de sua colet�nea.';
end;

procedure TfNovaVersao.FormCreate(Sender: TObject);
var
  Result : Integer;
  SearchRec: TSearchRec;
begin
  if (DirectoryExists(ExtractFilePath(application.ExeName)+'setup\Output')) then
  begin
    result := FindFirst(ExtractFilePath(application.ExeName)+'setup\Output\*.*', faAnyFile, SearchRec);
    While Result = 0 do
    begin
      DeleteFile(ExtractFilePath(application.ExeName)+'setup\Output\' + SearchRec.Name);
      Result := FindNext(SearchRec);
    end;
  end;
end;

procedure TfNovaVersao.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfNovaVersao.Timer1Timer(Sender: TObject);
var
  arquivo: string;
  baixado: Boolean;
begin
  timer1.Enabled := false;


  arquivo := fmIndex.dir_temp + '\'+LowerCase(fIniciando.LANG)+'_'+fmIndex.param.Strings.Values['setup_name'];
  baixado := fmIndex.DownloadArquivo(fmIndex.param.Strings.Values[LowerCase(fIniciando.LANG)+'_download']+'?lang='+fIniciando.LANG,arquivo);


  if (not FileExists(arquivo)) or (baixado = false) then
  begin
    Application.MessageBox('N�o foi poss�vel baixar/executar a atualiza��o do menu!'+#13#10+'Favor, acesse o site https://louvorja.com.br/ e efetue a instala��o manual da nova vers�o.',fmIndex.TITULO,mb_ok+mb_iconerror);
    Exit;
  end
  else
  begin
    fmIndex.abrirArquivo(arquivo);
    DM.tmrSair.enabled := true;
    Application.Terminate;
  end;
end;


initialization
  {$I fmNovaVersao.lrs}

end.
