unit fmLiturgia;
{$mode delphi}{$H+} {LAZARUS: modo Delphi para compatibilidade}

interface

uses
  {LAZARUS: removidos Winapi.*/Vcl.*/BusinessSkinForm/bsSkin*/FireDAC.*/ShellApi}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  DBCtrls, DB, Menus, StrUtils, LCLIntf, LCLType, ColorBox,
  ZDataset, LResources;

type
  TfLiturgia = class(TForm)
    {bsBusinessSkinForm1: TbsBusinessSkinForm;} {LAZARUS: removido}
    GridPanel2: TPanel {LAZARUS: TGridPanel};
    btAdd: TButton {LAZARUS: TbsSkinButton};
    bsSkinPanel1: TPanel {LAZARUS: TbsSkinPanel};
    lblItem: TLabel {LAZARUS: TbsSkinLabel};
    txtItem: TEdit {LAZARUS: TbsSkinEdit};
    bsSkinLabel2: TLabel {LAZARUS: TbsSkinLabel};
    cbItens: TComboBox {LAZARUS: TbsSkinComboBox};
    ScrollBox1: TScrollBox;
    dsHinos: TDataSource;
    qrHinos: TZQuery {LAZARUS: TFDQuery→TZQuery};
    pnlHinos: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider10: TBevel {LAZARUS: TbsRibbonDivider→TBevel};
    bsSkinPanel2: TPanel {LAZARUS: TbsSkinPanel};
    opcHinosOpc1: TRadioButton {LAZARUS: TbsSkinRadioButton};
    pnlHinosOpc1: TPanel {LAZARUS: TbsSkinPanel};
    skLitLabel: TLabel {LAZARUS: TbsSkinStdLabel};
    bsSkinPanel4: TPanel {LAZARUS: TbsSkinPanel};
    dbLitHinoLista: TDBLookupComboBox {LAZARUS: TbsSkinDBLookupComboBox};
    csCor: TColorButton {LAZARUS: TbsSkinColorButton};
    bsSkinLabel3: TLabel {LAZARUS: TbsSkinLabel};
    btDel: TButton {LAZARUS: TbsSkinButton};
    pnlAnotacoes: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider1: TBevel {LAZARUS: TbsRibbonDivider→TBevel};
    bsSkinPanel6: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel1: TLabel {LAZARUS: TbsSkinStdLabel};
    pnlSite: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinSpeedButton1: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    edtAnotacao: TEdit {LAZARUS: TbsSkinEdit};
    bsRibbonDivider2: TBevel {LAZARUS: TbsRibbonDivider→TBevel};
    bsSkinPanel3: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel2: TLabel {LAZARUS: TbsSkinStdLabel};
    urlSite: TEdit {LAZARUS: TbsSkinURLEdit→TEdit};
    bsSkinSpeedButton2: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    pnlArquivo: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider3: TBevel {LAZARUS: TbsRibbonDivider→TBevel};
    bsSkinPanel7: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel3: TLabel {LAZARUS: TbsSkinStdLabel};
    edtDiretorio: TEdit {LAZARUS: TbsSkinEdit};
    bsSkinSpeedButton3: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    bsSkinSpeedButton4: TSpeedButton {LAZARUS: TbsSkinSpeedButton};
    edtDiretorioInfo: TEdit {LAZARUS: TbsSkinEdit};
    pnlItensAgendados: TPanel {LAZARUS: TbsSkinPanel};
    bsRibbonDivider4: TBevel {LAZARUS: TbsRibbonDivider→TBevel};
    bsSkinPanel8: TPanel {LAZARUS: TbsSkinPanel};
    bsSkinStdLabel4: TLabel {LAZARUS: TbsSkinStdLabel};
    dblItem: TDBLookupComboBox;
    bsSkinPanel5: TPanel {LAZARUS: TbsSkinPanel};
    procedure cbItensChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure executaOpcoes();
    procedure opcHinosOpc1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bsSkinSpeedButton1Click(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btDelClick(Sender: TObject);
    procedure txtItemKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bsSkinSpeedButton2Click(Sender: TObject);
    function validaURL(url: string): string;
    procedure urlSiteExit(Sender: TObject);
    procedure bsSkinSpeedButton4Click(Sender: TObject);
    procedure edtDiretorioEnter(Sender: TObject);
    procedure edtDiretorioExit(Sender: TObject);
    procedure bsSkinSpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id: string;
    arquivoInicial: string; {LAZARUS: port upstream b09c49b — drag-and-drop na liturgia}
  end;

var
  fLiturgia: TfLiturgia;

implementation


uses fmMenu, fmBuscaMusica, dmComponentes, fmIniciando;

procedure TfLiturgia.edtDiretorioEnter(Sender: TObject);
begin
  edtDiretorio.Text := fmIndex.verificaURL(edtDiretorio.Text, edtDiretorioInfo, true);
end;

procedure TfLiturgia.edtDiretorioExit(Sender: TObject);
begin
  edtDiretorio.Text := fmIndex.verificaURL(edtDiretorio.Text, edtDiretorioInfo, false);
  {LAZARUS: port b09c49b — rola para o fim p/ nome do arquivo ficar visível
   (EM_SCROLLCARET é Windows-only; no GTK2 o SelStart já rola o caret)}
  edtDiretorio.SelStart := Length(edtDiretorio.Text);
end;

procedure TfLiturgia.bsSkinSpeedButton1Click(Sender: TObject);
begin
  fIniciando.AppCreateForm(TfBuscaMusica, fBuscaMusica);
  fBuscaMusica.ShowModal;
  if (fBuscaMusica.id) > 0
    then dbLitHinoLista.KeyValue := fBuscaMusica.id;
end;

procedure TfLiturgia.bsSkinSpeedButton2Click(Sender: TObject);
begin
  urlSite.text := validaURL(urlSite.text);
  fmIndex.abrirArquivo(urlSite.Text);
end;

procedure TfLiturgia.bsSkinSpeedButton3Click(Sender: TObject);
var
  dir: string;
begin
  dir := fmIndex.openDialog('pasta', '', 'Liturgia',false,edtDiretorio.Text);
  if dir <> '' then edtDiretorio.Text := dir;
  edtDiretorioExit(Sender);
end;

procedure TfLiturgia.bsSkinSpeedButton4Click(Sender: TObject);
var
  arq: string;
begin
  arq := fmIndex.openDialog('arquivo', '', 'Liturgia',false,ExtractFilePath(edtDiretorio.Text));
  if arq <> '' then edtDiretorio.Text := arq;
  edtDiretorioExit(Sender);
end;

procedure TfLiturgia.btAddClick(Sender: TObject);
var
  semana: string;
  tipo: string;
  subitem: string;
  param: string;
  itens: array of TParamItem;

  procedure Add(const p, v: string);
  begin
    SetLength(itens, Length(itens)+1);
    itens[High(itens)].Grupo := id;
    itens[High(itens)].Param := p;
    itens[High(itens)].Valor := v;
  end;
begin
  if (cbItens.ItemIndex < 0) then
  begin
    application.MessageBox('Escolha o tipo de item!', fmIndex.titulo, mb_ok + MB_ICONEXCLAMATION);
    cbItens.SetFocus;
    Exit;
  end;

  if (txtItem.Visible) and (Trim(txtItem.Text) = '') then
  begin
    application.MessageBox('Defina o nome do item!', fmIndex.titulo, mb_ok + MB_ICONEXCLAMATION);
    txtItem.SetFocus;
    Exit;
  end;

  if (pnlItensAgendados.Visible) and (trim(dblItem.KeyValue) = '') then
  begin
    application.MessageBox('Escolha o item!', fmIndex.titulo, mb_ok + MB_ICONEXCLAMATION);
    dblItem.SetFocus;
    Exit;
  end;

  semana := fmIndex.loadCol.Strings.Values['LITURGIA:SEMANA'];

  if (Trim(id) = '') then
    id := 'item_'+FormatDateTime('yyyymmddhhnnsszzz', Now);

  tipo := '';
  case cbItens.ItemIndex of
    0: tipo := 'anotacao';
    1: tipo := 'arquivo';
    2: tipo := 'categoria';
    3: tipo := 'itensagendados';
    4: tipo := 'musica';
    5: tipo := 'site';
  end;

  Add('tipo', tipo);
  Add('item', txtItem.Text);
  Add('cor', ColorToString(csCor.ButtonColor {LAZARUS: TColorButton.ColorValue→ButtonColor}));

  try
    fmIndex.gravaLog('btAddClick: pre-build id=' + id + ' pnlArquivo=' + BoolToStr(pnlArquivo.Visible, True) + ' edtDiretorio=' + edtDiretorio.Text + ' edtDiretorioInfo=' + edtDiretorioInfo.Text);
  except
    // silencioso
  end;

  if (pnlAnotacoes.Visible) then
  begin
    Add('subitem', edtAnotacao.Text);
  end
  else
  if (pnlItensAgendados.Visible) then
  begin
    Add('item', dblItem.Text);
    Add('subitem', '');
    Add('id', dblItem.KeyValue);
  end
  else
  if (pnlSite.Visible) then
  begin
    urlSite.text := validaURL(urlSite.text);
    Add('subitem', 'Site '+urlSite.Text);
    Add('url', urlSite.Text);
  end
  else
  if (pnlArquivo.Visible) then
  begin
    edtDiretorio.Text := trim(edtDiretorio.Text);
    if (edtDiretorioInfo.Text = 'I')
      then param := ExtractFilePath(Application.ExeName)+edtDiretorio.Text
      else param := edtDiretorio.Text;

    if (Copy(param,Length(param),1) = PathDelim) then {LAZARUS: '\' → PathDelim}
    begin
      Add('subtipo', 'dir');
      Add('subitem', 'Pasta '+edtDiretorio.Text);
    end
    else if FileExists(param) then
    begin
      Add('subtipo', 'arq');
      Add('subitem', 'Arquivo '+edtDiretorio.Text);
    end
    else if DirectoryExists(param) then
    begin
      edtDiretorio.Text := edtDiretorio.Text+PathDelim; {LAZARUS: '\' → PathDelim}
      Add('subtipo', 'dir');
      Add('subitem', 'Pasta '+edtDiretorio.Text);
    end
    else
    begin
      Add('subtipo', 'arq');
      Add('subitem', 'Arquivo '+edtDiretorio.Text);
    end;

    Add('dir', edtDiretorio.Text);
    Add('dir_info', edtDiretorioInfo.Text);
  end
  else
  if (pnlHinos.Visible) then
  begin
    if (dbLitHinoLista.KeyValue < 0)
      then opcHinosOpc1.Checked := true;

    if opcHinosOpc1.Checked then
    begin
      Add('escolha', '1');
      Add('musica', '-1');
      Add('subtipo', 'escolha');
      subitem := 'Clique para escolher a música';
      Add('subitem', subitem);
    end
    else
    begin
      Add('escolha', '0');
      Add('musica', IntToStr(dbLitHinoLista.KeyValue));
      if (qrHinos.FieldByName('TIPO_HASD').AsString = 'S')
        then Add('subtipo', 'hasd')
      else if (qrHinos.FieldByName('TIPO_JA').AsString = 'S')
        then Add('subtipo', 'ja')
      else Add('subtipo', 'div');

      if (qrHinos.FieldByName('TIPO_HASD').AsString = 'S')
        then subitem := 'Hino nº '
        else subitem := 'Música ';
      subitem := subitem + qrHinos.FieldByName('NOME').AsString;
      Add('subitem', subitem);
    end;
  end;

  fmIndex.gravaParamLote(fmIndex.arq_liturgia, itens);

  try
    fmIndex.gravaLog('btAddClick: salvando item ' + id + ' tipo=' + tipo);
  except
    // silencioso: log falhou -> continua
  end;

  if fmIndex.lbLiturgia.Items.IndexOf(id) < 0 then
  begin
    fmIndex.lbLiturgia.Items.Add(id);
    fmIndex.salvaItensLiturgia;
    fmIndex.carregaItemLiturgia(id,fmIndex.lbLiturgia.Items.Count);
  end
  else fmIndex.carregaItemLiturgia(id);

  close;
end;

procedure TfLiturgia.btDelClick(Sender: TObject);
begin
  if (application.MessageBox('Deseja realmente excluir este item?', fmIndex.titulo, mb_yesno + mb_iconquestion) <> 6) then Exit;
  fmIndex.apagaItemLiturgia(id);
  Close;
end;

procedure TfLiturgia.cbItensChange(Sender: TObject);
const
  IDX_ANOTACAO       = 0;
  IDX_ARQUIVO        = 1;
  IDX_ITENSAGENDADOS = 3;
  IDX_MUSICA         = 4;
  IDX_SITE           = 5;
var
  idx: Integer;
begin
  idx := cbItens.ItemIndex;

  pnlAnotacoes.Visible      := (idx = IDX_ANOTACAO);
  pnlArquivo.Visible        := (idx = IDX_ARQUIVO);
  pnlItensAgendados.Visible := (idx = IDX_ITENSAGENDADOS);
  pnlHinos.Visible          := (idx = IDX_MUSICA);
  pnlSite.Visible           := (idx = IDX_SITE);

  lblItem.Visible := not pnlItensAgendados.Visible;
  txtItem.Visible := not pnlItensAgendados.Visible;

  if idx < 0 then Exit;
  executaOpcoes;
end;

procedure TfLiturgia.executaOpcoes;
var
  item: string;
begin
  try
    if (pnlHinos.Visible) then
    begin
      opcHinosOpc1Click(nil);
      qrHinos.Close;
      qrHinos.Open;
    end
    else if pnlItensAgendados.Visible then
    begin
      item := '';
      if (dblItem.KeyValue <> null) then
        item := dblItem.KeyValue;
      if not DM.cdsCategoriasItensAgendados.Active then
      begin
        DM.cdsCategoriasItensAgendados.CreateDataSet;
        DM.cdsCategoriasItensAgendados.IndexName := '';
        DM.cdsCategoriasItensAgendados.IndexFieldNames := 'NOME';
        {LAZARUS: LogChanges removido — TBufDataset nao tem LogChanges}
      end;

      if (FileExists(fmIndex.dir_dados + 'itensAgendadosCategorias.xml')) then
        DM.cdsCategoriasItensAgendados.LoadFromFile(fmIndex.dir_dados + 'itensAgendadosCategorias.xml');
      DM.cdsCategoriasItensAgendados.Open;
      dblItem.KeyValue := item;
    end;
  except
    // Silencioso - erros em opções não devem quebrar a UI
  end;
end;

procedure TfLiturgia.FormActivate(Sender: TObject);
var
  tipo: string;
  idx: Integer;
  function FindIndexForTipo(const code: string): Integer;
  var
    i: Integer;
    c: string;
  begin
    Result := -1;
    if Trim(code) = '' then Exit;
    // try direct code-index mapping (legacy behavior)
    Result := AnsiIndexStr(code, ['anotacao','arquivo','categoria','itensagendados','musica','site']);
    if (Result >= 0) and (Result < cbItens.Items.Count) then Exit;

    // fallback: match by partial label (case-insensitive)
    for i := 0 to cbItens.Items.Count - 1 do
    begin
      c := cbItens.Items[i];
      if AnsiContainsText(c, 'Anot') and ((code = 'anotacao')) then
      begin
        Result := i; Exit;
      end;
      if (AnsiContainsText(c, 'Arquiv') or AnsiContainsText(c, 'Diretor') or AnsiContainsText(c, 'Diret')) and (code = 'arquivo') then
      begin
        Result := i; Exit;
      end;
      if AnsiContainsText(c, 'Categor') and (code = 'categoria') then
      begin
        Result := i; Exit;
      end;
      if (AnsiContainsText(c, 'Itens') or AnsiContainsText(c, 'Agend')) and (code = 'itensagendados') then
      begin
        Result := i; Exit;
      end;
      if (AnsiContainsText(c, 'Músic') or AnsiContainsText(c, 'Musica') or AnsiContainsText(c, 'Hino')) and (code = 'musica') then
      begin
        Result := i; Exit;
      end;
      if AnsiContainsText(c, 'Site') and (code = 'site') then
      begin
        Result := i; Exit;
      end;
    end;
  end;
begin
  pnlAnotacoes.Visible := False;
  pnlHinos.Visible := False;
  pnlSite.Visible := False;
  pnlArquivo.Visible := False;
  pnlItensAgendados.Visible := False;
  ScrollBox1.Visible := True;

  if (Trim(id) = '') then
  begin
    btAdd.Caption := ' Adicionar';
    {LAZARUS: btAdd.ImageIndex → TButton sem ImageIndex}
    btDel.Visible := False;
  end
  else
  begin
    btAdd.Caption := ' Salvar';
    {LAZARUS: btAdd.ImageIndex → TButton sem ImageIndex}
    btDel.Visible := True;
  end;

  try
    fmIndex.gravaLog('FormActivate: carrega item ' + id);
    tipo := fmIndex.lerParam(id, 'tipo', '', fmIndex.arq_liturgia);

    // Prefill simple controls that do not require datasets
    if tipo = 'anotacao' then
      edtAnotacao.Text := fmIndex.lerParam(id, 'subitem', '', fmIndex.arq_liturgia)
    else
      edtAnotacao.Text := '';

    if tipo = 'site' then
      urlSite.Text := fmIndex.lerParam(id, 'url', '', fmIndex.arq_liturgia)
    else
      urlSite.Text := '';

    if tipo = 'arquivo' then
    begin
      edtDiretorio.Text := fmIndex.lerParam(id, 'dir', '', fmIndex.arq_liturgia);
      edtDiretorioInfo.Text := fmIndex.lerParam(id, 'dir_info', '', fmIndex.arq_liturgia);
      {LAZARUS: port b09c49b — caminho longo: deixa o nome do arquivo visível}
      edtDiretorio.SelStart := Length(edtDiretorio.Text);
    end
    else
    begin
      edtDiretorio.Text := '';
      edtDiretorioInfo.Text := '';
    end;

      opcHinosOpc1.Checked := (fmIndex.lerParam(id, 'escolha', '0', fmIndex.arq_liturgia) = '1');
      txtItem.Text := fmIndex.lerParam(id, 'item', '', fmIndex.arq_liturgia);
      csCor.ButtonColor {LAZARUS: TColorButton.ColorValue→ButtonColor} := StringToColor(fmIndex.lerParam(id, 'cor', '$004F0000', fmIndex.arq_liturgia));

      // Map and set ItemIndex so cbItensChange opens datasets before KeyValue assignment
      try
        idx := FindIndexForTipo(tipo);
        if idx >= 0 then
          cbItens.ItemIndex := idx
        else
        begin
          cbItens.ItemIndex := -1;
          fmIndex.gravaLog('FormActivate: tipo desconhecido para item ' + id + ' -> "' + tipo + '"');
        end;
      except
        cbItens.ItemIndex := -1;
        fmIndex.gravaLog('FormActivate: erro ao mapear tipo para item ' + id);
      end;

    // Ensure datasets and lookup lists are initialized
    cbItensChange(Sender);

    // Now safe to assign DB lookup KeyValues
    if tipo = 'itensagendados' then
      dblItem.KeyValue := fmIndex.lerParam(id, 'id', '', fmIndex.arq_liturgia)
    else
      dblItem.KeyValue := '';

    dbLitHinoLista.KeyValue := fmIndex.lerParam(id, 'musica', '-1', fmIndex.arq_liturgia);

  except
    cbItens.ItemIndex := -1;
    try fmIndex.gravaLog('FormActivate: excecao ao carregar item ' + id); except end;
  end;

  {LAZARUS: port b09c49b — pré-preenchimento via drag-and-drop de arquivo na liturgia}
  if (Trim(arquivoInicial) <> '') and (Trim(id) = '') then
  begin
    cbItens.ItemIndex := 1; // Arquivo
    cbItensChange(nil);
    edtDiretorio.Text := arquivoInicial;
    edtDiretorioExit(nil);
    arquivoInicial := '';
    if txtItem.CanFocus then txtItem.SetFocus;
  end;
end;

procedure TfLiturgia.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfLiturgia.opcHinosOpc1Click(Sender: TObject);
begin
  pnlHinosOpc1.Visible := not opcHinosOpc1.Checked;
end;

procedure TfLiturgia.txtItemKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.edtKeyUp(Sender,Key,Shift);
end;

procedure TfLiturgia.urlSiteExit(Sender: TObject);
begin
  urlSite.text := validaURL(urlSite.text);
end;

function TfLiturgia.validaURL(url: string): string;
begin
  if (Copy(url,1,7) <> 'http://') and
     (Copy(url,1,8) <> 'https://') and
     (Copy(url,1,6) <> 'ftp://')
    then url := 'http://'+url;

  Result := url;
end;


initialization
  {$I fmLiturgia.lrs}

end.
