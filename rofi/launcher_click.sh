#!/bin/bash

# LISTA DE APPS: "Nome do App|Ícone|Comando"
# Você pode achar os nomes dos ícones em /usr/share/icons
apps=(
    "Kitty|utilities-terminal|kitty"
    "Zen Browser|browser|zen-browser"
    "Obsidian|obsidian|obsidian"
    "VS Code|vscode|code"
    "Thunar|folder|thunar"
)

# Gera a lista para o Rofi com ícones
function gen_list() {
    for app in "${apps[@]}"; do
        IFS="|" read -r nome icone cmd <<< "$app"
        echo -en "$nome\0icon\x1f$icone\n"
    done
}

# Captura a escolha do usuário
selected=$(gen_list | rofi -dmenu -i -p "Apps" -theme ~/.config/rofi/config.rasi)

# Executa o comando baseado na escolha
for app in "${apps[@]}"; do
    IFS="|" read -r nome icone cmd <<< "$app"
    if [[ "$selected" == "$nome" ]]; then
        exec $cmd
    fi
done