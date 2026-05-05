#!/bin/bash

# Cores Stealth (Forçando o Dark em tudo)
bg="#111111"
fg="#ffffff"
border_color="#ffffff"
select_bg="#222222"

# Opções com ícones (Markup)
shutdown="<span color='#f38ba8'></span>  Desligar"
reboot="<span color='#fab387'></span>  Reiniciar"
suspend="<span color='#a6e3a1'></span>  Suspender"
logout="<span color='#89b4fa'></span>  Sair"

chosen=$(printf "$shutdown\n$reboot\n$suspend\n$logout" | rofi -dmenu \
    -i \
    -p "Power" \
    -markup-rows \
    -theme-str "
        * {
            background-color: ${bg};
            text-color: ${fg};
        }
        window {
            background-color: ${bg};
            border: 1px;
            border-color: #333333;
            width: 350px;
            padding: 10px;
            border-radius: 0px;
        }
        listview {
            background-color: transparent;
            lines: 4;
            spacing: 5px;
            scrollbar: false;
            fixed-height: true;
        }
        element {
            background-color: ${bg};
            text-color: ${fg};
            padding: 12px;
            border: 2px;
            border-color: ${bg};
        }
        /* Isso aqui mata o bege nos itens que não estão selecionados */
        element normal.normal, element alternate.normal {
            background-color: ${bg};
            text-color: ${fg};
        }
        element selected.normal, element selected.urgent, element selected.active {
            background-color: ${select_bg};
            text-color: ${fg};
            border: 2px;
            border-color: ${border_color};
        }
        element-text {
            background-color: transparent;
            text-color: inherit;
            vertical-align: 0.5;
        }
        inputbar, entry, prompt, case-indicator {
            enabled: false;
        }
    ")

case "$chosen" in
    "$shutdown") shutdown now ;;
    "$reboot") reboot ;;
    "$suspend") systemctl suspend ;;
    "$logout") hyprctl dispatch exit ;;
esac