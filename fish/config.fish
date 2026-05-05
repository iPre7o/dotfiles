# Tira a mensagem de boas-vindas do fish
set -g fish_greeting ""

if status is-interactive
    # Inicia o Starship (Sinalzinho do Git e Ícones)
    # Se ele não aparecer, vamos reinstalar ele no próximo passo
    starship init fish | source

    # Traz o Fastfetch de volta ao abrir o terminal
    fastfetch

    # --- Atalhos (Aliases) do CachyOS ---
    alias ls='lsd'
    alias ll='lsd -l'
    alias la='lsd -a'
    alias l.='lsd -d .*'
    alias cat='bat'
    alias grep='ugrep'
    end