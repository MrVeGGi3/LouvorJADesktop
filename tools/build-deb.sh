#!/bin/bash
# build-deb.sh — Gera o pacote .deb do LouvorJA Desktop para Linux (amd64)
#
# Uso:
#   cd /path/to/LouvorJADesktop
#   bash tools/build-deb.sh [versao]
#
# Pré-requisitos:
#   - lazbuild instalado (Lazarus/FPC)
#   - dpkg-deb disponível
#   - libbass.so em /usr/local/lib/ ou no diretório do projeto
#   - config/database.db presente (banco de letras)
#   - imagemagick (convert) para gerar ícone PNG a partir de louvorja.ico
#
# O binário final é strippado automaticamente pelo flag -Xs no LouvorJA.lpi
# (Release build mode).

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
VERSION="${1:-26.6.0}"
DEB_NAME="louvorja_${VERSION}_amd64.deb"
PKG_DIR="$PROJECT_DIR/pkg"

echo "=== LouvorJA Desktop — Build .deb v${VERSION} ==="
echo "Diretório: $PROJECT_DIR"

# 1. Compila em modo Release (com -Xs para strip automático)
echo ""
echo "[1/5] Compilando em modo Release..."
cd "$PROJECT_DIR"
lazbuild LouvorJA.lpi --bm=Release
echo "  Binário: $(ls -lh LouvorJA | awk '{print $5, $9}')"

# 2. Cria estrutura do pacote
echo ""
echo "[2/5] Criando estrutura do pacote..."
rm -rf "$PKG_DIR"
mkdir -p "$PKG_DIR/DEBIAN"
mkdir -p "$PKG_DIR/opt/louvorja/config/server/file"
mkdir -p "$PKG_DIR/usr/bin"
mkdir -p "$PKG_DIR/usr/share/applications"
mkdir -p "$PKG_DIR/usr/share/icons/hicolor/64x64/apps"
mkdir -p "$PKG_DIR/usr/share/doc/louvorja"

# 3. Copia arquivos
echo ""
echo "[3/5] Copiando arquivos..."

# Binário
cp "$PROJECT_DIR/LouvorJA" "$PKG_DIR/opt/louvorja/louvorja"
chmod 755 "$PKG_DIR/opt/louvorja/louvorja"

# libbass.so (procura em locais comuns)
BASS_SO=""
for BASS_PATH in /usr/local/lib/libbass.so "$PROJECT_DIR/libbass.so" /usr/lib/libbass.so; do
    if [ -f "$BASS_PATH" ]; then
        BASS_SO="$BASS_PATH"
        break
    fi
done
if [ -z "$BASS_SO" ]; then
    echo "  AVISO: libbass.so não encontrado! Baixe de https://un4seen.com"
    echo "  O pacote será criado sem áudio."
else
    cp "$BASS_SO" "$PKG_DIR/opt/louvorja/libbass.so"
    chmod 644 "$PKG_DIR/opt/louvorja/libbass.so"
    echo "  libbass.so: $BASS_SO"
fi

# Banco de dados
if [ -f "$PROJECT_DIR/config/database.db" ]; then
    cp "$PROJECT_DIR/config/database.db" "$PKG_DIR/opt/louvorja/config/database.db"
    chmod 644 "$PKG_DIR/opt/louvorja/config/database.db"
else
    echo "  AVISO: config/database.db não encontrado!"
fi

# Arquivos do servidor HTTP
for HTML_FILE in 404.html index.html mirror.html; do
    if [ -f "$PROJECT_DIR/config/server/$HTML_FILE" ]; then
        cp "$PROJECT_DIR/config/server/$HTML_FILE" "$PKG_DIR/opt/louvorja/config/server/"
        chmod 644 "$PKG_DIR/opt/louvorja/config/server/$HTML_FILE"
    fi
done

# Ícone (converte de .ico para .png)
if command -v convert &>/dev/null && [ -f "$PROJECT_DIR/louvorja.ico" ]; then
    convert "$PROJECT_DIR/louvorja.ico[0]" "$PKG_DIR/usr/share/icons/hicolor/64x64/apps/louvorja.png"
    chmod 644 "$PKG_DIR/usr/share/icons/hicolor/64x64/apps/louvorja.png"
fi

# Wrapper script
# Garante que o usuário tem uma cópia gravável do database.db em ~/.local/share/LouvorJA/config/
# e passa o caminho absoluto como dir_config para o app (fmIniciando.pas suporta caminhos absolutos)
cat > "$PKG_DIR/usr/bin/louvorja" << 'EOF'
#!/bin/sh
SYSTEM_CONFIG="/opt/louvorja/config"
USER_CONFIG="$HOME/.local/share/LouvorJA/config"

# Na primeira execução: copia database.db e arquivos do servidor para dir gravável do usuário
if [ ! -f "$USER_CONFIG/database.db" ]; then
    mkdir -p "$USER_CONFIG/server/file"
    cp "$SYSTEM_CONFIG/database.db" "$USER_CONFIG/database.db"
    cp -r "$SYSTEM_CONFIG/server/"* "$USER_CONFIG/server/" 2>/dev/null || true
fi

# Injeta dir_config absoluto no segundo argumento (key=value params do LouvorJA)
FIRST_ARG="${1:-}"
SECOND_ARG="${2:-}"
if [ -n "$SECOND_ARG" ]; then
    PARAMS="dir_config=$USER_CONFIG;$SECOND_ARG"
else
    PARAMS="dir_config=$USER_CONFIG"
fi
shift 2 2>/dev/null || shift $# 2>/dev/null || true

exec /opt/louvorja/louvorja "$FIRST_ARG" "$PARAMS" "$@"
EOF
chmod 755 "$PKG_DIR/usr/bin/louvorja"

# 4. Cria arquivos de controle DEBIAN
echo ""
echo "[4/5] Criando arquivos DEBIAN/..."

INSTALLED_SIZE=$(du -sk "$PKG_DIR/opt" "$PKG_DIR/usr" 2>/dev/null | awk '{sum+=$1} END{print sum}')

cat > "$PKG_DIR/DEBIAN/control" << EOF
Package: louvorja
Version: ${VERSION}
Architecture: amd64
Maintainer: MrVeGGi3 <mveras1897@gmail.com>
Installed-Size: ${INSTALLED_SIZE}
Depends: libgtk2.0-0, libglib2.0-0, libfontconfig1, libx11-6, libxrender1, libxinerama1, libxi6, libxrandr2, libxcursor1
Recommends: fonts-noto
Section: misc
Priority: optional
Homepage: https://github.com/MrVeGGi3/LouvorJADesktop
Description: LouvorJA Desktop - Software de projeção de letras
 Software de projeção de letras de músicas e versículos bíblicos
 para comunidades adventistas. Suporta projeção em tela secundária,
 player de áudio, editor de slides, servidor HTTP para OBS/Vmix
 e organizador de liturgia.
 .
 Esta versão é um port para Linux via Lazarus/FPC.
EOF

cat > "$PKG_DIR/DEBIAN/postinst" << 'EOF'
#!/bin/sh
set -e
echo "/opt/louvorja" > /etc/ld.so.conf.d/louvorja.conf
ldconfig
if [ -n "$SUDO_USER" ]; then
    USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
    if [ -n "$USER_HOME" ]; then
        mkdir -p "$USER_HOME/.local/share/LouvorJA"
        chown "$SUDO_USER:" "$USER_HOME/.local/share/LouvorJA"
    fi
fi
exit 0
EOF
chmod 755 "$PKG_DIR/DEBIAN/postinst"

cat > "$PKG_DIR/DEBIAN/postrm" << 'EOF'
#!/bin/sh
set -e
if [ "$1" = "remove" ] || [ "$1" = "purge" ]; then
    rm -f /etc/ld.so.conf.d/louvorja.conf
    ldconfig
fi
exit 0
EOF
chmod 755 "$PKG_DIR/DEBIAN/postrm"

cat > "$PKG_DIR/usr/share/applications/louvorja.desktop" << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=LouvorJA Desktop
Comment=Software de projeção de letras para igrejas adventistas
Exec=/usr/bin/louvorja
Icon=louvorja
Terminal=false
Categories=AudioVideo;Education;
Keywords=louvor;música;projeção;hinário;adventista;letra;
StartupNotify=true
StartupWMClass=LouvorJA
EOF

cat > "$PKG_DIR/usr/share/doc/louvorja/copyright" << 'EOF'
Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: LouvorJA Desktop
Source: https://github.com/MrVeGGi3/LouvorJADesktop

Files: *
Copyright: LouvorJA contributors
License: proprietary

Files: libbass.so
Copyright: Un4seen Developments
License: BASS non-commercial license
 Free for non-commercial use. See https://www.un4seen.com/ for details.
EOF

# 5. Gera o .deb
echo ""
echo "[5/5] Gerando $DEB_NAME..."
cd "$PROJECT_DIR"
dpkg-deb --build --root-owner-group "$PKG_DIR" "$DEB_NAME"

echo ""
echo "=== Concluído! ==="
echo "Pacote: $PROJECT_DIR/$DEB_NAME"
ls -lh "$PROJECT_DIR/$DEB_NAME"
echo ""
echo "Para instalar:"
echo "  sudo dpkg -i $DEB_NAME"
echo "  louvorja"
