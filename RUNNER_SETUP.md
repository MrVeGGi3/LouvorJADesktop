# Configurar Self-Hosted GitHub Actions Runner

Este projeto usa um **self-hosted runner** para CI/CD porque:
- Lazarus, FPC, ZeosLib e RichMemo já estão instalados na máquina local
- `libbass.so` está disponível em `/usr/local/lib/`
- O startup test usa `DISPLAY=:0` (sessão X11 ativa do usuário)

## Instalação (uma vez)

### 1. Acessar a página de configuração

```
GitHub → MrVeGGi3/LouvorJADesktop → Settings
→ Actions → Runners → New self-hosted runner
→ Selecionar: Linux / x64
```

### 2. Copiar e rodar os comandos gerados

A página do GitHub vai gerar comandos específicos com um token. Seguir exatamente o que está lá. O fluxo geral é:

```bash
# Baixar o runner (URL gerada pelo GitHub, exemplo)
mkdir -p ~/actions-runner && cd ~/actions-runner
curl -o actions-runner-linux-x64.tar.gz -L https://github.com/actions/runner/releases/download/v2.xxx/actions-runner-linux-x64-2.xxx.tar.gz
tar xzf actions-runner-linux-x64.tar.gz

# Configurar (usar o token gerado pelo GitHub)
./config.sh --url https://github.com/MrVeGGi3/LouvorJADesktop --token <TOKEN_GERADO>

# Testar (modo foreground, para verificar que funciona)
./run.sh
```

### 3. Instalar como serviço (para rodar sempre, mesmo após reboot)

```bash
cd ~/actions-runner
sudo ./svc.sh install
sudo ./svc.sh start

# Verificar status
sudo ./svc.sh status
```

### 4. Verificar no GitHub

```
GitHub → Settings → Actions → Runners
→ O runner deve aparecer como "Idle" (pronto)
```

## Desinstalar

```bash
cd ~/actions-runner
sudo ./svc.sh stop
sudo ./svc.sh uninstall
./config.sh remove --token <TOKEN_GERADO>
```

## Notas

- O runner roda como o usuário atual (acesso ao `DISPLAY=:0`)
- **Não rodar como root** — o runner precisa do ambiente GTK2 do usuário
- O runner tem acesso ao `~/.local/share/LouvorJA/` (dados do usuário) para o startup test
- Para o startup test funcionar, a sessão X11 deve estar ativa (não pode ser SSH puro)

## Atualizar o banco de dados (quando o database.db mudar)

```bash
cd /path/to/LouvorJADesktop
gh release upload database-latest config/database.db --clobber
```
