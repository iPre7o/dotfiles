function fish_prompt
    # Cores Stealth
    set -l cyan (set_color -o cyan)
    set -l white (set_color -o white)
    set -l gray (set_color 666666)
    set -l normal (set_color normal)

    # Ícone e Pasta Atual
    echo -n -s $white "󰣇 " $cyan (prompt_pwd) $normal $gray " 󰁔 " $normal
end