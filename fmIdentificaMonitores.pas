unit fmIdentificaMonitores;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos Windows/Messages/VCL/bsSkin*/FireDAC/Indy/Delphi-specific}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grids, DBGrids,
  DBCtrls, DB, Menus, ValEdit, MaskEdit, IniFiles, StrUtils,
  CheckLst, Spin, EditBtn, ColorBox, LCLIntf, LCLType, BufDataset, LResources;

type
  TfIdentificaMonitores = class(TForm)
    rotulo: TLabel;
    Timer1: TTimer;
    detalhes: TLabel;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fIdentificaMonitores: TfIdentificaMonitores;

implementation


procedure TfIdentificaMonitores.Timer1Timer(Sender: TObject);
begin
  Close;
end;


initialization
  {$I fmIdentificaMonitores.lrs}

end.
