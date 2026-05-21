unit fmMusicaOperador;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade com código portado}

interface

uses
  {LAZARUS: removidos Winapi.*/Vcl.*/bsSkin*/System.Types}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, DBCtrls, ComCtrls,
  LCLIntf, LCLType, LResources;

type
  TfMusicaOperador = class(TForm)
    Panel2: TPanel;
    DBGrid1: TDBGrid; {LAZARUS: TbsSkinDBGrid}
    bsSkinScrollBar7: TScrollBar; {LAZARUS: TbsSkinScrollBar}
    Panel: TPanel;
    pnlLetra: TPanel;
    imgFundo: TImage;
    imgFundoTexto: TImage;
    lblLetra: TLabel; {LAZARUS: TbsSkinStdLabel}
    lblLetra_aux: TLabel; {LAZARUS: TbsSkinStdLabel}
    pnlProgress: TPanel; {LAZARUS: TGridPanel}
    gSlide: TProgressBar; {LAZARUS: TbsSkinGauge}
    Panel3: TPanel;
    gSlideTotal: TProgressBar; {LAZARUS: TbsSkinGauge}
    lblTempo: TLabel; {LAZARUS: TbsSkinLabel}
    GridPanel2: TPanel; {LAZARUS: TGridPanel}
    bsSkinSpeedButton1: TSpeedButton; {LAZARUS: TbsSkinSpeedButton}
    btPausePlay: TSpeedButton; {LAZARUS: TbsSkinSpeedButton}
    bsSkinSpeedButton3: TSpeedButton; {LAZARUS: TbsSkinSpeedButton}
    bsSkinSpeedButton4: TSpeedButton; {LAZARUS: TbsSkinSpeedButton}
    bsSkinSpeedButton5: TSpeedButton; {LAZARUS: TbsSkinSpeedButton}
    Panel1: TPanel;
    lblSlides: TLabel; {LAZARUS: TbsSkinLabel}
    pnlInfo: TPanel;
    pnlErroMsg: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn {LAZARUS: TbsColumn}; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn {LAZARUS: TbsColumn});
    procedure bsSkinSpeedButton5Click(Sender: TObject);
    procedure bsSkinSpeedButton1Click(Sender: TObject);
    procedure btPausePlayClick(Sender: TObject);
    procedure bsSkinSpeedButton3Click(Sender: TObject);
    procedure bsSkinSpeedButton4Click(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    inicio: Boolean;
    recno: Integer;
  end;

var
  fMusicaOperador: TfMusicaOperador;

implementation


uses
  fmMusica, fmMenu, dmComponentes;

{ TfSlidesMusica }

procedure TfMusicaOperador.bsSkinSpeedButton1Click(Sender: TObject);
begin
  fMusica.acaoSlide('ant');
end;

procedure TfMusicaOperador.btPausePlayClick(Sender: TObject);
begin
  fMusica.pauseplay;
end;

procedure TfMusicaOperador.bsSkinSpeedButton3Click(Sender: TObject);
begin
  fMusica.acaoSlide('prox');
end;

procedure TfMusicaOperador.bsSkinSpeedButton4Click(Sender: TObject);
begin
  fMusica.acaoSlide('ult');
end;

procedure TfMusicaOperador.bsSkinSpeedButton5Click(Sender: TObject);
begin
  fMusica.acaoSlide('pri');
end;

procedure TfMusicaOperador.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1') then
    Params.WndParent := 0;
end;

procedure TfMusicaOperador.DBGrid1CellClick(Column: TColumn {LAZARUS: TbsColumn});
begin
  fMusica.irSlide(DM.cdsSLIDE_MUSICA.RecNo);
end;

procedure TfMusicaOperador.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn {LAZARUS: TbsColumn}; State: TGridDrawState);
var
  R: TRect;
begin
  if DM.cdsSLIDE_MUSICA.RecNo = 1 then
    DBGrid1.Canvas.Font.Color := $02AC3F6;
  DBGrid1.Canvas.Brush.Color := $00353535;

  if DM.cdsSLIDE_MUSICA.RecNo = fMusica.nslide then
  begin
    DBGrid1.Canvas.Brush.Color := $00FFFFFF;
    DBGrid1.Canvas.Font.Color := $00353535;
  end;
//  if gdSelected in State then


  R := Rect;
  Dec(R.Bottom, 0);
  R.Top := R.Top + 10;
  R.Left := R.Left + 10;

  if Column.Index = 0 then
  begin
    DBGrid1.Canvas.FillRect(Rect);
    DBGrid1.Canvas.TextRect(R, R.Left, R.Top, IntToStr(DM.cdsSLIDE_MUSICA.RecNo)); {LAZARUS: DrawText→TextRect}
  end
  else if Column.Field = DM.cdsSLIDE_MUSICA.FieldByName('LETRA_UCASE') then
  begin
    DBGrid1.Canvas.FillRect(Rect);
    DBGrid1.Canvas.TextRect(R, R.Left, R.Top, DM.cdsSLIDE_MUSICA.FieldByName('LETRA_UCASE').AsString); {LAZARUS: DrawText→TextRect}
  end;

end;

procedure TfMusicaOperador.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Key := 0;
end;

procedure TfMusicaOperador.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TfMusicaOperador.FormActivate(Sender: TObject);
begin
  if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') <> '1') then
  begin
    fMusicaOperador.AlphaBlend := True;
    fMusicaOperador.AlphaBlendValue := 0;
  end;

  if (inicio <> true) then
  begin
    inicio := True;
    recno := 0;
    fMusicaOperador.Tag := 1;
  end;
end;

procedure TfMusicaOperador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') <> '1') then
  begin
    fMusicaOperador.Tag := 0;
    fMusica.fecharSlides := True;
    fMusica.Close;
  end
  else
  begin
    if fMusicaOperador.Tag = 1 then
    begin
      if (application.MessageBox('Ao fechar esta tela, os slides tamb�m ser�o fechados! Deseja fechar os slides?', fmIndex.titulo, mb_yesno + mb_iconquestion) <> 6) then
      begin
        Abort;
        Exit;
      end;
      fMusicaOperador.Tag := 0;
    end;
    fMusica.fecharSlides := True;
    fMusica.Close;
  end;
end;

procedure TfMusicaOperador.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfMusicaOperador.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  fmIndex.MouseWheel('Down', Sender, Shift, MousePos, Handled);
end;

procedure TfMusicaOperador.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  fmIndex.MouseWheel('Up', Sender, Shift, MousePos, Handled);
end;


initialization
  {$I fmMusicaOperador.lrs}

end.
