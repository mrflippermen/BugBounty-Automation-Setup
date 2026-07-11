```
   ██████╗ ██╗   ██╗ ██████╗     ██████╗  ██████╗ ██╗   ██╗███╗   ██╗████████╗██╗   ██╗
   ██╔══██╗██║   ██║██╔════╝     ██╔══██╗██╔═══██╗██║   ██║████╗  ██║╚══██╔══╝╚██╗ ██╔╝
   ██████╔╝██║   ██║██║  ███╗    ██████╔╝██║   ██║██║   ██║██╔██╗ ██║   ██║    ╚████╔╝ 
   ██╔══██╗██║   ██║██║   ██║    ██╔══██╗██║   ██║██║   ██║██║╚██╗██║   ██║     ╚██╔╝  
   ██████╔╝╚██████╔╝╚██████╔╝    ██████╔╝╚██████╔╝╚██████╔╝██║ ╚████║   ██║      ██║   
   ╚═════╝  ╚═════╝  ╚═════╝     ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝      ╚═╝   
                                                                                          
       █████╗ ██╗   ██╗████████╗ ██████╗ ███╗   ███╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
      ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗████╗ ████║██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
      ███████║██║   ██║   ██║   ██║   ██║██╔████╔██║███████║   ██║   ██║██║   ██║██╔██╗ ██║
      ██╔══██║██║   ██║   ██║   ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
      ██║  ██║╚██████╔╝   ██║   ╚██████╔╝██║ ╚═╝ ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
      ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                                                                                              
                        ███████╗███████╗████████╗██╗   ██╗██████╗                           
                        ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗                          
                        ███████╗█████╗     ██║   ██║   ██║██████╔╝                          
                        ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝                           
                        ███████║███████╗   ██║   ╚██████╔╝██║                               
                        ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝                               
```

[![Bash](https://img.shields.io/badge/Bash-4.0+-green.svg)](https://www.gnu.org/software/bash/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)

> **Automated bug bounty hunting environment setup with latest tools and ZSH configuration.**

---

## 🇬🇧 English

### Description

**BugBounty Automation Setup** is an idempotent, one-command environment setup script for bug bounty hunters and red teamers. Installs and configures all essential reconnaissance tools, modern CLI utilities, and a beautiful ZSH environment.

**What Gets Installed:**
- 🎯 **Bug Bounty Tools**: subfinder, httpx, nuclei, amass, ffuf, waybackurls, gau
- ⚡ **Modern CLI**: lsd, bat, Oh My Zsh, Powerlevel10k
- 📚 **Wordlists**: SecLists repository
- 🔧 **System Updates**: Latest packages and dependencies
- 🎨 **ZSH Plugins**: autosuggestions, syntax-highlighting

### Why This Tool?

Setting up a bug bounty environment manually takes hours. **This script does it in one command**. Perfect for:
- Setting up new VPS instances
- Onboarding new team members
- Creating consistent testing environments
- Rapid deployment for time-sensitive engagements

### Features

✅ **OS Detection**: Supports Debian, Ubuntu, Kali, Arch, Fedora  
✅ **Idempotent**: Safe to run multiple times (won't duplicate)  
✅ **Non-Interactive**: Fully automated, no user input required  
✅ **Latest Versions**: Always installs current tool releases  
✅ **Error Handling**: Comprehensive logging and validation  
✅ **Beautiful Terminal**: Powerlevel10k theme with custom aliases  

### Installation

```bash
# Download script
curl -fsSL https://raw.githubusercontent.com/mrflippermen/BugBounty-Automation-Setup/main/scripts/setup.sh -o setup.sh

# Make executable
chmod +x setup.sh

# Run
./setup.sh
```

### What Gets Installed

#### Bug Bounty Tools

| Tool | Purpose | Use Case |
|------|---------|----------|
| **subfinder** | Subdomain enumeration | Passive recon |
| **httpx** | HTTP probing | Live host detection |
| **nuclei** | Vulnerability scanning | CVE detection |
| **amass** | In-depth asset discovery | Active recon |
| **ffuf** | Web fuzzing | Directory/parameter discovery |
| **waybackurls** | Historical URL extraction | Wayback Machine parsing |
| **gau** | URL gathering | Archive data collection |

#### Modern CLI Tools

- **lsd**: Modern `ls` replacement with colors and icons
- **bat**: `cat` clone with syntax highlighting
- **Oh My Zsh**: ZSH framework
- **Powerlevel10k**: Beautiful ZSH theme

#### Wordlists

- **SecLists**: Comprehensive collection of lists for security testing

### Post-Installation

```bash
# Apply changes
exec zsh

# Verify installations
subfinder -version
httpx -version
nuclei -version

# Test modern CLI
lsd -lha
bat ~/.zshrc
```

### Custom Aliases Included

```bash
# Modern replacements
ll='lsd -lh --group-dirs=first'
la='lsd -a --group-dirs=first'
ls='lsd -lha --group-dirs=first'

# Quick navigation
alias ..='cd ..'
alias ...='cd ../..'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
```

### Configuration

The script creates/modifies:
- `~/.zshrc` - ZSH configuration
- `~/.bugbounty-tools/` - Tools directory
- `~/.zsh/plugins/` - ZSH plugins
- `~/powerlevel10k/` - Theme
- `~/.bugbounty-setup.log` - Installation log

### Project Structure

```
BugBounty-Automation-Setup/
├── scripts/
│   └── setup.sh          # Main setup script
├── configs/
│   ├── .zshrc.template   # ZSH config template
│   └── aliases.zsh       # Custom aliases
├── README.md
├── LICENSE
└── .gitignore
```

---

## 🇪🇸 Español

### Descripción

**BugBounty Automation Setup** es un script de configuración de entorno con un solo comando para cazadores de bug bounties y red teamers. Instala y configura todas las herramientas esenciales de reconocimiento, utilidades CLI modernas y un hermoso entorno ZSH.

**Qué se Instala:**
- 🎯 **Herramientas Bug Bounty**: subfinder, httpx, nuclei, amass, ffuf, waybackurls, gau
- ⚡ **CLI Moderno**: lsd, bat, Oh My Zsh, Powerlevel10k
- 📚 **Wordlists**: Repositorio SecLists
- 🔧 **Actualizaciones del Sistema**: Últimos paquetes y dependencias
- 🎨 **Plugins ZSH**: autosuggestions, syntax-highlighting

### Por qué usar esta herramienta?

Configurar manualmente un entorno de bug bounty toma horas. **Este script lo hace en un comando**. Perfecto para:
- Configurar nuevas instancias VPS
- Onboarding de nuevos miembros del equipo
- Crear entornos de prueba consistentes
- Despliegue rápido para compromisos con tiempo limitado

### Instalación

```bash
# Descargar script
curl -fsSL https://raw.githubusercontent.com/mrflippermen/BugBounty-Automation-Setup/main/scripts/setup.sh -o setup.sh

# Hacer ejecutable
chmod +x setup.sh

# Ejecutar
./setup.sh
```

### Post-Instalación

```bash
# Aplicar cambios
exec zsh

# Verificar instalaciones
subfinder -version
nuclei -version

# Probar CLI moderno
lsd -lha
bat ~/.zshrc
```

---

## 📋 Requirements

- Linux (Debian/Ubuntu/Kali/Arch/Fedora)
- Bash 4.0+
- sudo/root access
- Internet connection

## 🔒 Legal Disclaimer

**FOR AUTHORIZED SECURITY TESTING ONLY**

Tools installed by this script should only be used on systems you own or have explicit written permission to test.

## 📜 License

MIT License - see [LICENSE](LICENSE) file for details.

## 👤 Author

**Esteban Jiménez**
- 🏆 Top 1 Hack The Box Ecuador
- 🎯 Red Team Operator
- 🔗 [GitHub](https://github.com/virtualshoot)

## 🙏 Acknowledgments

- ProjectDiscovery for amazing recon tools
- Oh My Zsh community
- romkatv for Powerlevel10k theme
- SecLists contributors

---

**⚠️ Happy hacking!**
