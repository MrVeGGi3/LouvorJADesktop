unit fmMusicaRetorno;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade com código portado}

interface

uses
  {LAZARUS: removidos Winapi.*/Vcl.*/bsSkinCtrls/Vcl.Imaging.pngimage}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, LCLIntf, LCLType, LResources;

type
  TfMusicaRetorno = class(TForm)
    Panel: TPanel;
    pnlProgress: TPanel; {LAZARUS: TGridPanel}
    gSlide: TProgressBar; {LAZARUS: TbsSkinGauge}
    gSlideTotal: TProgressBar; {LAZARUS: TbsSkinGauge}
    lblTempo: TLabel; {LAZARUS: TbsSkinLabel}
    Panel2: TPanel;
    lblSlides: TLabel; {LAZARUS: TbsSkinLabel}
    lblLetra_prox: TLabel; {LAZARUS: TbsSkinStdLabel}
    pnlLetra: TPanel;
    lblLetra: TLabel; {LAZARUS: TbsSkinStdLabel}
    lblLetra_aux: TLabel; {LAZARUS: TbsSkinStdLabel}
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    inicio: Boolean;
  end;

var
  fMusicaRetorno: TfMusicaRetorno;

implementation


uses fmMenu, fmMusica;

procedure TfMusicaRetorno.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  if (fmIndex.lerParam('Musicas', 'ModoRetorno', '1') = '1') then
    Params.WndParent := 0;
end;

procedure TfMusicaRetorno.FormActivate(Sender: TObject);
begin
  if fmIndex.ckMusicaTopo.Checked then
    FormStyle := fsStayOnTop;
  if (fmIndex.lerParam('Musicas', 'ModoRetorno', '1') <> '1') then
  begin
    fMusicaRetorno.AlphaBlend := True;
    fMusicaRetorno.AlphaBlendValue := 0;
  end;

  if (inicio <> true) then
  begin
    inicio := True;
    fMusicaRetorno.Tag := 1;
  end;
end;

procedure TfMusicaRetorno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (fmIndex.lerParam('Musicas', 'ModoRetorno', '1') <> '1') then
  begin
    fMusicaRetorno.Tag := 0;
    fMusica.fecharSlidesRetorno := True;
    fMusica.Close;
  end
  else
  begin
    if fMusicaRetorno.Tag = 1 then
    begin
      if (application.MessageBox('Ao fechar esta tela, os slides tamb�m ser�o fechados! Deseja fechar os slides?', fmIndex.titulo, mb_yesno + mb_iconquestion) <> 6) then
      begin
        Abort;
        Exit;
      end;
      fMusicaRetorno.Tag := 0;
    end;
    fMusica.fecharSlidesRetorno := True;
    fMusica.Close;
  end;
end;

procedure TfMusicaRetorno.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;


initialization
  {$I fmMusicaRetorno.lrs}

end.
