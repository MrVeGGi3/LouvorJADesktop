unit fmPlayer;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade com código portado}

interface

uses
  {LAZARUS: removidos Winapi.*/Vcl.*/Vcl.MPlayer — player via BASS em fmMenu}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, LCLIntf, LCLType, LResources;

type
  TfPlayer = class(TForm)
    Panel1: TPanel;
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  fPlayer: TfPlayer;

implementation


uses fmMenu, dmComponentes, Bass;

procedure TfPlayer.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := 0;
end;

procedure TfPlayer.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  if (fPlayer.AlphaBlendValue > 0) then
  begin
    if fmIndex.ckFadeForm.Checked then
    begin
      for i := fPlayer.AlphaBlendValue downto 0 do
      begin
        fPlayer.AlphaBlendValue := i;
        sleep(1);
      end;
    end
    else fPlayer.AlphaBlendValue := 0;
  end;

  try
    BASS_ChannelStop(fmIndex.PlayerStream); {LAZARUS: MediaPlayer1.Stop→BASS}
  except
    //
  end;
  BASS_StreamFree(fmIndex.PlayerStream); {LAZARUS: MediaPlayer1.Close→BASS_StreamFree}
  fmIndex.PlayerStream := 0; {LAZARUS: MediaPlayer1.FileName:=''→PlayerStream reset}
  fmIndex.pnlPlayer.Visible := False;
  fmIndex.lblPlayer.Caption := '';
  DM.tmrPlayer.Enabled := False;
  fmIndex.pbPlayer.Position := 0; {LAZARUS: TProgressBar.Value->Position}
end;

procedure TfPlayer.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfPlayer.FormResize(Sender: TObject);
begin
  {LAZARUS: MediaPlayer1.DisplayRect removido — BASS não renderiza vídeo}
end;


initialization
  {$I fmPlayer.lrs}

end.
