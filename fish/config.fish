# =============================================================
# CONFIGURAÇÃO FISH - GABRYEL (VERSÃO FINAL DE ALINHAMENTO)
# =============================================================

function fish_greeting
    clear
    
    # 1. Desenha o Pinguim (Fastfetch)
    if type -q fastfetch
        fastfetch
    end

    # Pequena pausa para o Kitty processar a imagem
    sleep 0.2

    # 2. CONFIGURAÇÃO DE ALINHAMENTO
    # Quantas linhas vamos subir (ajustado para o tamanho do pinguim)
    set -l subir 17
    # Espaço para empurrar o texto para a direita da imagem
    set -l esp "                                      " 

    # Sobe o cursor
    tput cuu $subir 

   # --- VARIÁVEIS DE INFORMAÇÃO (MÉTODO INFALÍVEL) ---
    
    # RAM: Pega o valor da 3ª e 2ª coluna da linha "Mem"
    set -l ram_used (free -h | grep "Mem" | awk '{print $3}')
    set -l ram_total (free -h | grep "Mem" | awk '{print $2}')
    set -l ram_info "$ram_used / $ram_total"

    # DISK: Pega o valor da 3ª e 2ª coluna da linha da partição raiz
    set -l disk_used (df -h / | grep "/" | tail -1 | awk '{print $3}')
    set -l disk_total (df -h / | grep "/" | tail -1 | awk '{print $2}')
    set -l disk_info "$disk_used / $disk_total"

    # IP: Local
    set -l my_ip (ip route get 1.1.1.1 | awk '{print $7}')

    # --- SEÇÃO INFORMAÇÕES ---
    echo -e "$esp"(set_color 262626)"────────── INFORMAÇÕES ──────────"
    echo -e "$esp "(set_color e0e0e0)"󰘧 OS:   CachyOS"
    echo -e "$esp "(set_color e0e0e0)"󰻠 CPU:  Ryzen 5 5600G"
    echo -e "$esp "(set_color e0e0e0)"󰢮 GPU:  Radeon RX 580"
    echo -e "$esp "(set_color e0e0e0)"󰍛 RAM:  $ram_info"
    echo -e "$esp "(set_color e0e0e0)"󰋊 DISK: $disk_info"
    echo -e "$esp "(set_color e0e0e0)"󰩟 IP:   $my_ip"
    
    echo "" # Espaço

    # --- SEÇÃO CONFIGURAÇÕES ---
    echo -e "$esp"(set_color 262626)"───────── CONFIGURAÇÕES ─────────"
    echo -e "$esp "(set_color e0e0e0)"󰘳 conf-hypr  󰘳 conf-waybar  󰘳 conf-fish"
    
    echo "" # Espaço

    # --- SEÇÃO SISTEMA ---
    echo -e "$esp"(set_color 262626)"──────────── SISTEMA ────────────"
    echo -e "$esp "(set_color e0e0e0)"󰚰 update     󰆆 install      󰆴 remove"
    
    # 3. VOLTA O CURSOR PARA BAIXO DA IMAGEM
    tput cud 0
    set_color normal
end

# --- ALIASES ---
alias conf-hypr='code ~/.config/hypr/hyprland.conf'
alias conf-waybar='code ~/.config/hypr/waybar/config.jsonc'
alias conf-fish='code ~/.config/fish/config.fish'

alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias ls='eza --icons --group-directories-first'

# INICIALIZAÇÃO DO STARSHIP
set -g fish_greeting ""
if type -q starship
    starship init fish | source
end