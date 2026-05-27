# LouvorJA Desktop — Linux (Lazarus/FPC)

Software de projeção de letras de músicas com centenas de músicas do Hinário Adventista, CDs jovens e coletâneas diversas.

> **Este fork porta o LouvorJA Desktop de Delphi/Windows para Lazarus/FPC/Linux.**
> O projeto original (Windows) está em [louvorja/desktop](https://github.com/louvorja/desktop).

[Site oficial](https://louvorja.com.br/) · [Fork público](https://github.com/MrVeGGi3/LouvorJADesktop)

---

## Recursos

- Projeção de letras de músicas (Hinário Adventista, CDs jovens, coletâneas)
- Projeção de versículos da Bíblia
- Músicas cantadas, playbacks (sem vocal) ou projeção silenciosa (sem áudio)
- Tela de retorno (stage display) com prévia do slide seguinte
- Organizador de liturgia, agendamentos de cultos e cronômetros
- Saída em HTML para transmissão ao vivo (OBS/Vmix) — pasta `server/`
- Editor de slides
- Utilitários: sorteador, relógio, painel de recados, identificação de monitores

---

## Requisitos do sistema

- **Sistema operacional:** Linux (x86_64) com GTK2
- **Bibliotecas em tempo de execução:**
  - `libsqlite3-0`
  - `libgtk2.0-0`
  - `libssl3` (ou `libssl1.1`)
  - `libbass.so` — [BASS library](https://www.un4seen.com/) (incluída no repositório como `libbass.so`)

---

## Instalação

### Via pacote `.deb` (Ubuntu/Debian — recomendado)

Baixe o `.deb` mais recente na [página de releases](https://github.com/MrVeGGi3/LouvorJADesktop/releases) e instale:

```bash
sudo dpkg -i louvorja_26.6.0_amd64.deb
sudo apt-get install -f   # resolve dependências ausentes, se houver
```

Após instalar, execute:

```bash
louvorja
```

### Via binário (portable)

```bash
# Clonar o repositório
git clone https://github.com/MrVeGGi3/LouvorJADesktop.git
cd LouvorJADesktop

# Copiar libbass.so para o sistema (ou manter na pasta do executável)
sudo cp libbass.so /usr/local/lib/
sudo ldconfig

# Executar
./LouvorJA
```

Os dados do usuário (banco de dados, configurações, imagens) são armazenados em:

```
~/.local/share/LouvorJA/
```

---

## Compilar a partir do código-fonte

### Dependências de build

```bash
# Debian/Ubuntu
sudo apt install -y lazarus fpc fpc-source lcl lcl-utils \
  libgtk2.0-dev libglib2.0-dev libsqlite3-dev libssl-dev \
  libcairo2-dev libpango1.0-dev libatk1.0-dev libgdk-pixbuf2.0-dev

# Fedora
sudo dnf install -y lazarus fpc gtk2-devel sqlite-devel openssl-devel

# Arch
sudo pacman -S lazarus fpc sqlite openssl
```

**Packages do Lazarus necessários** (instalar via Lazarus IDE → _Package → Install/Uninstall Packages_):

| Package | Uso |
|---------|-----|
| ZeosLib | Acesso ao banco SQLite |
| RichMemo | Exibição de letras com formatação |
| Synapse (opcional) | HTTP/FTP |

### Compilar

```bash
# Debug (padrão)
lazbuild LouvorJA.lpi

# Release (otimizado, binário stripped)
lazbuild LouvorJA.lpi --bm=Release
```

### Gerar pacote `.deb`

```bash
bash build-deb.sh
```

O script gera `louvorja_<versão>_amd64.deb` na raiz do repositório.

---

## Stack técnica

| Camada | Tecnologia |
|--------|-----------|
| Compilador | Free Pascal Compiler (FPC) 3.2+ |
| UI framework | LCL (GTK2) |
| Banco de dados | SQLite via ZeosLib (`TZConnection` / `TZQuery`) |
| Áudio | BASS library (`libbass.so`) |
| HTTP | `TFPHTTPClient` (FCL) |
| FTP (atualização) | `curl` via `TProcess` |
| Servidor HTML (transmissão) | `TFPHttpServer` (FCL) |
| Dataset em memória | `TBufDataset` (FCL) |

---

## Estrutura de dados

| Caminho | Conteúdo |
|---------|---------|
| `~/.local/share/LouvorJA/config/dados.db` | Banco SQLite do usuário (favoritos, agendamentos) |
| `~/.local/share/LouvorJA/config/database.db` | Banco principal de músicas/versículos (baixado na 1ª execução) |
| `~/.local/share/LouvorJA/config/config.ini` | Configurações gerais |
| `~/.local/share/LouvorJA/config/*.xml` | Favoritos, itens agendados, liturgia |
| `~/.local/share/LouvorJA/config/imagens/` | Imagens de fundo para projeção |
| `~/.local/share/LouvorJA/config/musicas/` | Arquivos de áudio (MP3/OGG) |

---

## CI/CD

O projeto usa **GitHub Actions com self-hosted runner** (a máquina de desenvolvimento, que já possui Lazarus, ZeosLib e `libbass.so` instalados).

| Workflow | Trigger | O que faz |
|----------|---------|-----------|
| `ci.yml` | push/PR em `main` | Compila em Release, verifica ELF, teste de startup headless (Xvfb) |
| `release.yml` | push de tag `v*` | Compila Release, gera `.deb`, cria GitHub Release (draft) |
| `deb-install-test.yml` | manual | Instala o `.deb` e verifica dependências |

Para configurar o runner, veja [RUNNER_SETUP.md](RUNNER_SETUP.md).

---

## Relação com o projeto original

| Aspecto | Original ([louvorja/desktop](https://github.com/louvorja/desktop)) | Este fork |
|---------|--------------------------------------------------------------------|-----------|
| Plataforma | Windows | Linux |
| Compilador | Delphi RAD Studio 10.2 | Lazarus/FPC 3.2+ |
| UI | VCL + BusinessSkinForm | LCL (GTK2) |
| Banco | FireDAC + SQLite | ZeosLib + SQLite |
| Áudio | Windows MCI (`TMediaPlayer`) | BASS library |
| Extras | — | Pasta `server/` para transmissão ao vivo |

> **Contribuições** que envolvam lógica de negócio devem ser direcionadas ao repositório oficial.
> Este fork foca exclusivamente na compatibilidade com Linux/Lazarus.

---

## Licença

Distribuído sob os mesmos termos do projeto original. Consulte o repositório oficial para detalhes.
