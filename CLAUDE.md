# CLAUDE.md — LouvorJA Desktop (Port Delphi → Lazarus/Linux)

> Este arquivo instrui o Claude Code sobre o contexto, arquitetura, mapeamento de
> incompatibilidades e ordem de trabalho para portar o LouvorJA Desktop de
> Delphi/Windows para Lazarus/FPC/Linux. Leia este arquivo inteiro antes de qualquer ação.

---

## 1. Visão Geral do Projeto

**LouvorJA Desktop** é o software original de projeção de letras de músicas da
comunidade adventista, escrito em **Object Pascal (Delphi RAD Studio 10.2 Tokyo)**.
Roda exclusivamente em Windows. Este fork tem como objetivo portá-lo para Linux via
**Lazarus/FPC**, mantendo compatibilidade com os dados existentes (SQLite, XMLs).

**Funcionalidades principais:**
- Projeção de letras de músicas (Hinário Adventista, CDs jovens, coletâneas)
- Projeção de versículos da Bíblia
- Player de áudio (cantado, playback, silencioso)
- Tela de retorno / stage display (`fmMusicaRetorno`)
- Organizador de liturgia e cronômetros
- Saída HTML para transmissão ao vivo (OBS/Vmix) — pasta `server/`
- Editor de slides
- Utilitários: sorteador, relógio, painel de recados, identificação de monitores

**Repositórios:**
- Fork (seu): `https://github.com/MrVeGGi3/LouvorJADesktop`
- Oficial: `https://github.com/louvorja/desktop`

**Diferença do fork em relação ao upstream:** o fork adiciona a pasta `server/` —
não presente no upstream. Preservar e adaptar esse conteúdo.

---

## 2. Stack Original (Delphi) vs. Destino (Lazarus)

| Camada | Delphi (original) | Lazarus/FPC (destino) |
|---|---|---|
| Compilador | Delphi RAD Studio 10.2 | Free Pascal Compiler (FPC) 3.2+ |
| IDE | RAD Studio | Lazarus IDE |
| UI framework | VCL (`Vcl.*`) | LCL (`LCLIntf`, `LCLType`) |
| Skin/tema | BusinessSkinForm (`bsSkin*`) | **Remover** — usar tema nativo GTK2/Qt5 |
| Imagens PNG | PNGComponents (`TbsPngImageList`) | `TImageList` + `TPortableNetworkGraphic` (LCL nativo) |
| Database | FireDAC + SQLite | **`SQLite3` via `ZeosLib`** ou `TSQLite3Connection` (FCL-DB nativo) |
| Dataset em memória | `TClientDataSet` | `TBufDataset` (FCL) |
| HTTP | `TIdHTTP` (Indy) | `TFPHTTPClient` (FCL) ou manter Indy se disponível |
| FTP | `TIdFTP` (Indy) | `TFTPSend` (`synapse`) ou `TFPFTPClient` |
| SSL | `TIdSSLIOHandlerSocketOpenSSL` | `opensslsockets` (LCL package) |
| Áudio player | `TMediaPlayer` (Windows MCI) | `bass.so` (BASS library) ou `GStreamer` via `gst-pascal` |
| Shell | `ShellApi` (`ShellExecute`) | `fpExecve` ou `OpenURL` (LCLIntf) |
| Registry/INI | `TRegistry` (Windows) | `TIniFile` (`IniFiles`) — já usa `.ini` via `lerParam`/`gravaParam` |
| Formulários | `.dfm` | `.lfm` (converter com `dfm2lfm` ou manualmente) |
| Projeto | `.dproj` | `.lpi` + `.lpr` |

---

## 3. Regras Gerais para o Claude Code

- **Nunca apagar** lógica de negócio dos `.pas` — apenas adaptar as units e componentes.
- **Nunca recriar** funcionalidades já existentes; reutilizar o código Pascal sempre que possível.
- Ao substituir um componente incompatível, **documentar a substituição** com um comentário
  `{LAZARUS: substituído TbsSkinXxx → TXxx}` na linha alterada.
- Alterações nos `.lfm` são geradas pelo Lazarus IDE — o Claude Code só deve editar `.pas`.
  Exceção: ajustes textuais simples em `.lfm` que não envolvam layout (ex: remover referências
  a componentes de skin).
- Manter compatibilidade com os arquivos de dados existentes: banco SQLite em
  `config/dados.db`, XMLs em `config/*.xml`, INI em `config/config.ini`.
- A pasta `server/` do fork é código adicional — não modificar sem instrução explícita.
- Commits devem seguir o padrão: `[lazarus] descrição` para mudanças de port,
  `[fix] descrição` para correções independentes.

---

## 4. Setup do Ambiente Linux

### 4.1 Lazarus e FPC

**Debian/Ubuntu:**
```bash
sudo apt update
sudo apt install -y lazarus fpc fpc-source lcl lcl-utils \
  libgtk2.0-dev libglib2.0-dev libcairo2-dev \
  libpango1.0-dev libatk1.0-dev libgdk-pixbuf2.0-dev
```

**Fedora:**
```bash
sudo dnf install -y lazarus fpc gtk2-devel
```

**Arch:**
```bash
sudo pacman -S lazarus fpc
```

Verificar: `fpc -version` (deve ser 3.2+) e `lazarus --version`.

### 4.2 ZeosLib (acesso SQLite)

```bash
sudo apt install -y libsqlite3-dev
```

Instalar ZeosLib via Lazarus IDE: **Packages → Install/Uninstall Packages → ZeosLib**.
Ou clonar e compilar:
```bash
git clone https://github.com/zeos/zeoslib.git
```

### 4.3 Synapse (HTTP/FTP)

```bash
# Instalar via Online Package Manager do Lazarus
# ou manualmente:
sudo apt install -y libsynapse-dev
```

### 4.4 Áudio — BASS Library

O projeto usa `TMediaPlayer` (Windows MCI) e um player customizado. No Linux,
a recomendação é BASS (binário nativo, licença gratuita para uso não-comercial):

```bash
# Baixar libbass.so para Linux em https://un4seen.com
# Copiar para /usr/local/lib/ ou pasta do executável
sudo cp libbass.so /usr/local/lib/
sudo ldconfig
```

Alternativamente, usar GStreamer para player de pré-visualização leve:
```bash
sudo apt install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
```

### 4.5 OpenSSL

```bash
sudo apt install -y libssl-dev openssl
```

---

## 5. Mapeamento de Componentes Incompatíveis

Esta é a seção mais crítica. Cada componente `bsSkin*` do BusinessSkinForm precisa
ser substituído pelo equivalente LCL nativo.

### 5.1 BusinessSkinForm (`bsSkin*`) → LCL nativo

| Componente Delphi | Substituto LCL | Observação |
|---|---|---|
| `TbsBusinessSkinForm` | Remover | Apenas skin visual — sem equivalente necessário |
| `TbsSkinData` + `TbsCompressedSkinList` | Remover | Skin engine — não portar |
| `TbsSkinPanel` | `TPanel` | Direto |
| `TbsSkinButton` | `TButton` ou `TBitBtn` | Se tiver imagem, usar `TBitBtn` |
| `TbsSkinEdit` | `TEdit` | Direto |
| `TbsSkinRichEdit` | `TRichMemo` (package RichMemo) ou `TMemo` | Instalar package RichMemo se precisar RTF |
| `TbsSkinDBLookupListBox` | `TDBLookupListBox` | LCL nativo |
| `TbsSkinDBText` | `TDBText` | LCL nativo |
| `TbsSkinScrollBar` | `TScrollBar` | Direto |
| `TbsSkinSplitter` | `TSplitter` | Direto |
| `TbsSkinStdLabel` | `TLabel` | Direto |
| `TbsSkinOfficeItem` / listas skin | `TListBox` ou `TCheckListBox` | Verificar uso caso a caso |
| `TbsSkinProgressDialog` | `TProgressBar` em `TForm` customizado | Criar um `TfProgressDialog` simples |
| `TbsSkinSaveDialog` | `TSaveDialog` | Direto |
| `TbsSkinSelectDirectoryDialog` | `TSelectDirectoryDialog` | LCL nativo |
| `TbsSkinPasswordDialog` | `TInputQuery` ou form customizado | Simples |
| `TbsSkinShellCtrls` | Remover / substituir por `TFileListBox` | Verificar uso |
| `TbsPngImageList` | `TImageList` | LCL suporta PNG nativamente |

### 5.2 FireDAC → ZeosLib/SQLite

O projeto usa `TFDConnection` + `TFDQuery` para SQLite. Substituição por ZeosLib:

```pascal
// Delphi (FireDAC)
ADO: TFDConnection;          // TZConnection (ZeosLib)
qrMUSICAS: TFDQuery;         // TZQuery (ZeosLib)

// Configuração da conexão (ZeosLib)
ZConnection1.Protocol := 'sqlite-3';
ZConnection1.Database := dir_dados + 'dados.db';
ZConnection1.Connect;
```

Alternativa sem ZeosLib — usar `TSQLite3Connection` (FCL-DB nativo):
```pascal
uses sqlite3conn, sqldb;

Conn: TSQLite3Connection;
Trans: TSQLTransaction;
Query: TSQLQuery;
```

**Escolha:** ZeosLib é mais próximo da API FireDAC e facilita a migração. Usar ZeosLib.

### 5.3 TClientDataSet → TBufDataset

```pascal
// Delphi
cdsFavoritos: TClientDataSet;
// ↓
// Lazarus
cdsFavoritos: TBufDataset;
```

`TBufDataset` suporta `LoadFromFile`/`SaveToFile` em XML — compatível com os XMLs
existentes (`favoritos.xml`, `itensAgendados.xml`, etc.).

### 5.4 TMediaPlayer (Windows MCI) → BASS ou GStreamer

O `TMediaPlayer` é Windows-only. Há dois usos no projeto:

- `mpMusica` em `fmMenu` — player de pré-visualização rápida (MP3)
- `MediaPlayer1` em `fmMenu` (player principal com `pbPlayer`)

Substituição via BASS (recomendada para compatibilidade com MP3/OGG):

```pascal
uses bass;

// Inicializar
BASS_Init(-1, 44100, 0, 0, nil);

// Carregar e tocar
var stream: HSTREAM;
stream := BASS_StreamCreateFile(False, PChar(arquivo), 0, 0, 0);
BASS_ChannelPlay(stream, False);

// Posição e duração
BASS_ChannelGetPosition(stream, BASS_POS_BYTE);
BASS_ChannelGetLength(stream, BASS_POS_BYTE);
```

O binding Pascal para BASS está em: https://www.un4seen.com/forum/?topic=7540

### 5.5 ShellExecute → OpenURL / fpExecve

```pascal
// Delphi
ShellExecute(handle, nil, PChar(url), nil, nil, SW_MAXIMIZE);

// Lazarus
uses LCLIntf;
OpenURL(url);

// Para abrir arquivo/pasta
uses Process;
RunCommand('xdg-open', [arquivo], '');
```

### 5.6 Windows-specific units → Equivalentes cross-platform

| Unit Delphi/Windows | Substituto Lazarus/Linux |
|---|---|
| `Windows` | `LCLIntf`, `LCLType` |
| `Messages` | `LMessages` |
| `Vcl.Controls` | `Controls` |
| `Vcl.Forms` | `Forms` |
| `Vcl.Graphics` | `Graphics` |
| `Vcl.ExtCtrls` | `ExtCtrls` |
| `Vcl.StdCtrls` | `StdCtrls` |
| `Vcl.ComCtrls` | `ComCtrls` |
| `Vcl.Dialogs` | `Dialogs` |
| `Vcl.Menus` | `Menus` |
| `Vcl.ImgList` | `ImgList` |
| `Data.Win.ADODB` | Remover (era ADODB — substituído por ZeosLib) |
| `Datasnap.DBClient` | `BufDataset` |
| `Datasnap.Provider` | Remover |
| `Data.DBXMySQL` | Remover (não usado no SQLite) |
| `FireDAC.*` | `ZConnection`, `ZQuery` (ZeosLib) |
| `IdHTTP` | `FPHTTPClient` |
| `IdSSLOpenSSL` | `opensslsockets` |
| `ShellApi` | `LCLIntf` + `Process` |

---

## 6. Inventário de Formulários e Prioridade de Port

### Formulários de Alta Prioridade (core da aplicação)

| Arquivo | Descrição | Complexidade |
|---|---|---|
| `fmMenu.pas` / `.dfm` | Formulário principal — contém quase toda a lógica | 🔴 Alta |
| `dmComponentes.pas` / `.dfm` | DataModule central — queries, timers, ImageLists, skin | 🔴 Alta |
| `fmIniciando.pas` | Splash screen e inicialização | 🟡 Média |
| `fmLetra.pas` | Busca e exibição de letras (FireDAC, bsSkin*) | 🟡 Média |
| `fmMusica.pas` | Controle de projeção de música | 🟡 Média |
| `fmPlayer.pas` | Player de áudio principal | 🟡 Média |

### Formulários de Monitor (projeção em tela secundária)

| Arquivo | Descrição | Complexidade |
|---|---|---|
| `fmLetra.pas` | Tela de projeção de letra | 🟡 Média |
| `fmMonitorBiblia.pas` | Projeção de versículos | 🟡 Média |
| `fmMonitorRelogio.pas` | Relógio em monitor externo | 🟢 Baixa |
| `fmMonitorCronometro.pas` | Cronômetro em monitor externo | 🟢 Baixa |
| `fmMonitorCronometroCulto.pas` | Cronômetro de culto | 🟢 Baixa |
| `fmMonitorSorteio.pas` | Sorteador numérico | 🟢 Baixa |
| `fmMonitorSorteioNomes.pas` | Sorteador de nomes | 🟢 Baixa |
| `fmMonitorPainelDinamico.pas` | Painel dinâmico | 🟡 Média |
| `fmMonitorMenuMusicas.pas` | Menu de músicas no monitor | 🟡 Média |
| `fmMonitorTextoInterativo.pas` | Texto interativo | 🟡 Média |
| `fmMusicaRetorno.pas` | Stage display / tela de retorno | 🟡 Média |
| `fmMusicaOperador.pas` | Tela do operador | 🟡 Média |
| `fmMonitorBibliaBusca.pas` | Busca bíblica no monitor | 🟡 Média |

### Formulários de Suporte

| Arquivo | Descrição | Complexidade |
|---|---|---|
| `fmAtualiza.pas` | Sincronização FTP/HTTPS | 🔴 Alta (FTP, SSL, progresso) |
| `fmBuscaMusica.pas` | Busca avançada de músicas | 🟡 Média |
| `fmEditorSlides.pas` | Editor de slides de música | 🔴 Alta |
| `fmFavoritos.pas` | Gerenciar favoritos | 🟢 Baixa |
| `fmFormatacao.pas` | Configuração de formatação de texto | 🟡 Média |
| `fmHelp.pas` | Tela de ajuda | 🟢 Baixa |
| `fmIdentificaMonitores.pas` | Identificação de monitores | 🟡 Média |
| `fmItensAgendados.pas` | Itens agendados de liturgia | 🟡 Média |
| `fmListaMusica.pas` | Listagem de músicas | 🟢 Baixa |
| `fmLiturgia.pas` | Organizador de liturgia | 🟡 Média |
| `fmNovaVersao.pas` | Notificação de nova versão | 🟢 Baixa |
| `fmTransmitir.pas` | Servidor HTML para transmissão ao vivo | 🔴 Alta |
| `fmVideoOn.pas` | Vídeos online | 🟡 Média |
| `fmArquivosExcesso.pas` | Limpeza de arquivos em excesso | 🟢 Baixa |
| `fmArquivosFalta.pas` | Verificação de arquivos faltando | 🟢 Baixa |

---

## 7. Notas Críticas por Formulário

### fmMenu (formulário principal)

- É o formulário central que referencia todos os outros via `fmMenu.fmIndex`
- Contém `MediaPlayer1`, `mpMusica` — ambos `TMediaPlayer` (Windows MCI)
  → substituir por BASS (seção 5.4)
- Usa `DoubleBuffered := True` extensivamente para animações — funciona no LCL
- `lmdRelogio`, `lmdCrono`, `lmdSorteio` são labels de display — provavelmente
  `TbsSkinLabel` → `TLabel`
- `PageControl1` com abas → `TPageControl` LCL nativo

### dmComponentes (DataModule)

- É o coração do banco de dados — tem ~30 `TFDQuery` todos apontando para SQLite
- Todos os `TbsSkin*` dialogs (`SaveDialog_`, `progressDialog`, `DirectoryDialog`)
  → substituir pelos equivalentes LCL
- `bsSkinData1` + `bsCompressedSkinList1` → **remover completamente**
- `TbsPngImageList` (`ico_16x16`, `ico_24x24`, etc.) → `TImageList` com PNG
- `IdHTTP1` → `TFPHTTPClient`; manter lógica de progresso via eventos `OnDataReceived`

### fmLetra

- Usa `TbsSkinRichEdit` (`reLetra`) para exibir letras com formatação
  → `TRichMemo` (instalar package RichMemo no Lazarus)
- `TbsSkinDBLookupListBox` (`dbLista`) → `TDBLookupListBox`
- `TFDQuery` (`qrBUSCA`, `qrLETRA`, `qrALBUNS`) → `TZQuery`
- `ShellExecute` em `btErroClick` → `OpenURL`

### fmAtualiza (sincronização)

- Usa `TIdFTP` + `TIdSSLIOHandlerSocketOpenSSL` para download
- Lógica de handshake via HTTP (`IdHTTP`) com payload URL-encoded
- → Substituir `TIdFTP` por `TFTPSend` (Synapse) ou migrar para HTTPS direto
  (o app Vue já migrou FTP → HTTPS; ver contexto em `louvorja/app#49`)
- Manter compatibilidade com o servidor existente

### fmTransmitir (servidor HTML)

- Serve a SPA do `louvorja/app` como servidor HTTP local (OBS/Vmix)
- O fork tem pasta `server/` adicionada — provavelmente relacionado a isso
- Verificar o conteúdo de `server/` antes de qualquer alteração neste formulário
- No Linux, `TIdHTTPServer` (Indy) funciona — verificar se Indy está disponível
  para Lazarus, ou substituir por servidor HTTP simples com `fpWeb`/`TFPHttpServer`

### fmIdentificaMonitores

- Usa `Screen.Monitors` (VCL) para listar monitores
- No LCL: `Screen.MonitorCount` e `Screen.Monitors[i]` — API equivalente existe
- `cdsMonitores: TClientDataSet` → `TBufDataset`

---

## 8. Convertendo .dfm para .lfm

O Lazarus IDE possui ferramenta integrada de conversão, mas pode ser feita manualmente:

```bash
# Via linha de comando (fpc tools)
convert -2 -L fmLetra.dfm
```

Passos manuais necessários após conversão automática:
1. Remover todos os componentes `TbsSkin*` do `.lfm`
2. Substituir pelos equivalentes LCL listados na seção 5.1
3. Ajustar propriedades não suportadas (ex: `SkinData`, `SkinName`)
4. Recriar layout aproximado no Lazarus IDE

**Ordem recomendada de conversão:** `dmComponentes` → `fmIniciando` → `fmMenu` →
formulários de monitor → formulários de suporte.

---

## 9. Criando o Projeto Lazarus

### 9.1 Arquivo de projeto (.lpi)

Criar `LouvorJA.lpi` no Lazarus IDE: **File → New Project → Application**.

Adicionar todos os `.pas` ao projeto via **Project → Add Files**.

### 9.2 Packages necessários

No Lazarus IDE (**Package → Install/Uninstall Packages**):
- `ZeosLib` — banco de dados
- `RichMemo` — `TRichMemo` para exibir letras formatadas
- `Synapse` — HTTP/FTP
- `LazUtils` — utilitários (já incluso)

### 9.3 Configuração de paths

Em **Project → Project Options → Compiler Options → Paths**:
- Other unit files: adicionar `components/` se houver units Pascal reutilizáveis
- Libraries: adicionar path do `libbass.so`

---

## 10. Build e Empacotamento

### 10.1 Compilar

```bash
# Via linha de comando
lazbuild LouvorJA.lpi --build-all

# Em modo release (otimizado para hardware antigo)
lazbuild LouvorJA.lpi --build-all -B --bm=Release
```

### 10.2 Gerar .deb

```bash
# Estrutura mínima
mkdir -p pkg/DEBIAN pkg/usr/bin pkg/usr/share/applications

cp LouvorJA pkg/usr/bin/louvorja
chmod +x pkg/usr/bin/louvorja

cat > pkg/DEBIAN/control << EOF
Package: louvorja
Version: 26.6
Architecture: amd64
Maintainer: MrVeGGi3
Description: LouvorJA Desktop - Software de projeção de letras
Depends: libsqlite3-0, libgtk2.0-0, libssl3
EOF

dpkg-deb --build pkg louvorja_26.6_amd64.deb
```

### 10.3 Gerar .AppImage

```bash
# Instalar appimagetool
wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
chmod +x appimagetool-x86_64.AppImage

# Estrutura AppDir
mkdir -p AppDir/usr/bin AppDir/usr/lib
cp LouvorJA AppDir/usr/bin/louvorja
cp libbass.so AppDir/usr/lib/

# Criar AppRun e .desktop
./appimagetool-x86_64.AppImage AppDir LouvorJA-26.6-x86_64.AppImage
```

---

## 11. Roadmap de Tarefas (Ordem Sugerida)

Execute nesta sequência. Marque cada etapa antes de prosseguir:

- [ ] **Etapa 1 — Setup do ambiente**
  - Instalar Lazarus, FPC, dependências (seção 4)
  - Instalar packages: ZeosLib, RichMemo, Synapse
  - Baixar e configurar `libbass.so`

- [ ] **Etapa 2 — Criar projeto Lazarus**
  - Criar `LouvorJA.lpi` e adicionar todos os `.pas`
  - Tentar compilar — catalogar todos os erros

- [ ] **Etapa 3 — dmComponentes (DataModule)**
  - Remover `bsSkinData1`, `bsCompressedSkinList1`, todos os `TbsSkin*`
  - Substituir `TFDConnection`/`TFDQuery` → `TZConnection`/`TZQuery`
  - Substituir `TClientDataSet` → `TBufDataset`
  - Substituir `TIdHTTP` → `TFPHTTPClient`
  - Substituir `TbsPngImageList` → `TImageList`
  - Converter `dmComponentes.dfm` → `dmComponentes.lfm`

- [ ] **Etapa 4 — fmIniciando (splash)**
  - Remover componentes skin
  - Converter `.dfm` → `.lfm`
  - Verificar `AppCreateForm` — funciona igual no LCL

- [ ] **Etapa 5 — fmMenu (formulário principal)**
  - Substituir `TMediaPlayer` → BASS (seção 5.4)
  - Remover todos os `bsSkin*`
  - Converter `.dfm` → `.lfm`
  - Verificar `DoubleBuffered`, `PageControl1`, `Screen.Monitors`

- [ ] **Etapa 6 — fmLetra**
  - `TbsSkinRichEdit` → `TRichMemo`
  - `TFDQuery` → `TZQuery`
  - `ShellExecute` → `OpenURL`
  - Converter `.dfm` → `.lfm`

- [ ] **Etapa 7 — Formulários de monitor**
  - Converter em lote: `fmMonitorRelogio`, `fmMonitorCronometro`,
    `fmMonitorSorteio`, `fmMonitorSorteioNomes`, `fmMonitorCronometroCulto`
  - Verificar `Screen.Monitors` para posicionamento em tela secundária

- [ ] **Etapa 8 — fmAtualiza (sincronização)**
  - Avaliar migração FTP → HTTPS (recomendado — ver PR #49 do `louvorja/app`)
  - Se manter FTP: substituir `TIdFTP` → `TFTPSend` (Synapse)
  - Substituir `TIdHTTP` → `TFPHTTPClient`

- [ ] **Etapa 9 — fmTransmitir (servidor HTML)**
  - Verificar conteúdo da pasta `server/` do fork
  - Avaliar `TIdHTTPServer` vs `TFPHttpServer` para o servidor local

- [ ] **Etapa 10 — Formulários restantes**
  - `fmMusica`, `fmPlayer`, `fmEditorSlides`, `fmLiturgia`, etc.

- [ ] **Etapa 11 — Build e testes**
  - Compilar em modo Release
  - Testar em hardware com 2GB RAM
  - Gerar `.deb` e `.AppImage`

---

## 12. Arquivos que o Claude Code NÃO deve modificar

```
server/          # adição do fork — não tocar sem instrução explícita
*.ico            # ícones binários
*.res            # recursos binários
*.bak            # backups
menu.dof         # arquivo de opções Delphi antigo
LouvorJA.dproj   # projeto Delphi original — preservar como referência
components/      # componentes de terceiros originais — preservar como referência
```

---

## 13. Referências

- Lazarus Wiki: https://wiki.lazarus.freepascal.org/
- Guia de migração VCL → LCL: https://wiki.lazarus.freepascal.org/VCL_to_LCL
- Converter DFM → LFM: https://wiki.lazarus.freepascal.org/Converting_a_Delphi_project
- ZeosLib docs: https://zeoslib.sourceforge.io/
- BASS library: https://www.un4seen.com/
- BASS binding Pascal: https://www.un4seen.com/forum/?topic=7540
- RichMemo package: https://github.com/skalogryz/richmemo
- Synapse (HTTP/FTP): http://synapse.ararat.cz/
- LouvorJA Desktop (fork): https://github.com/MrVeGGi3/LouvorJADesktop
- LouvorJA Desktop (oficial): https://github.com/louvorja/desktop
- LouvorJA App (referência arquitetura projeção): https://github.com/louvorja/app
