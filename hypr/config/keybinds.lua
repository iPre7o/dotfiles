-- ============================================================================
-- keybinds.lua
-- Traduzido do antigo hyprland.conf (hyprlang) para o novo formato Lua
-- introduzido no Hyprland 0.55+, com integração ao Noctalia (v4/Quickshell).
--
-- Mesma lógica, mesmas teclas, mesmos comandos do arquivo original.
-- Sintaxe nova: hl.bind(TECLAS, DISPATCHER, { opções })
--
-- IPC do Noctalia: confirmamos que sua instalação é a v4 (Quickshell),
-- porque "qs -c noctalia-shell ipc call launcher toggle" funcionou.
-- Se algum dia você migrar para a v5, o binário muda para "noctalia msg ...".
-- ============================================================================

local terminal    = "kitty"
local fileManager  = "dolphin"
-- "menu" (rofi) não é mais usado: o Noctalia (v4) tem launcher e window
-- switcher próprios, chamados via IPC (`qs -c noctalia-shell ipc call ...`).
local ipc          = "qs -c noctalia-shell ipc call"

local mainMod = "SUPER" -- Define a tecla "Windows" como modificador principal

-- ============================================================================
-- --- ATALHOS --- (não dependem de plugin)
-- ============================================================================

-- Alt+Tab: antes era Rofi (-show window), agora abre o window switcher
-- nativo do Noctalia (lista de janelas dentro do próprio launcher)
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. " launcher windows"))

hl.bind("CONTROL + SHIFT + Escape", hl.dsp.exec_cmd("kitty --class floating_btop -e btop"))

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(terminal))

hl.bind("ALT + F4", hl.dsp.window.close())

hl.bind(mainMod .. " + Return", hl.dsp.window.close())

-- No hyprlang antigo isso chamava "hyprctl dispatch exit". No config Lua, o
-- próprio wiki do Hyprland recomenda trocar por hl.dsp.exit() dentro do
-- hyprctl dispatch, por causa do novo sistema de dispatchers.
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(
  "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
))

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- Lançador de apps: antes era Rofi (-show drun), agora abre o launcher
-- nativo do Noctalia via IPC (já confirmado que funciona no seu sistema)
--hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(ipc .. " launcher toggle"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))

hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle

-- ============================================================================
-- --- MOVIMENTACAO DE JANELAS --- #
-- ============================================================================

-- Move o foco com mainMod + setas
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Tela cheia real (modo 0 no hyprlang antigo)
-- OBS: verifique com o LSP/stubs do Hyprland se "fullscreen" é o valor exato
-- esperado para "mode" na sua versão; a documentação recente também mostra o
-- uso de mode = "maximized" para o antigo modo 1.
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- --- Movimentação de Janelas (MainMod + Alt + Setas) ---
-- Move a janela ativa na direção desejada (Tiling)
hl.bind("SUPER + ALT + left",  hl.dsp.window.move({ direction = "left" }))  -- Move para a esquerda
hl.bind("SUPER + ALT + right", hl.dsp.window.move({ direction = "right" })) -- Move para a direita
hl.bind("SUPER + ALT + up",    hl.dsp.window.move({ direction = "up" }))    -- Move para cima
hl.bind("SUPER + ALT + down",  hl.dsp.window.move({ direction = "down" }))  -- Move para baixo

-- --- Movimentação com o Mouse (Estilo Moderno) ---
-- Segure SUPER e arraste com o botão esquerdo para mover
-- Segure SUPER e arraste com o botão direito para redimensionar
--
-- NOTA: no arquivo original você tinha DOIS binds idênticos para isso
-- (um bloco "estilo moderno" com bindm = SUPER, e outro repetido mais abaixo
-- em bindm = $mainMod, sendo que $mainMod já era SUPER). Isso era redundante
-- e, na sintaxe nova, registrar a mesma combinação duas vezes pode causar
-- comportamento inconsistente (há inclusive um bug relatado no Hyprland 0.55
-- sobre isso). Por isso mantive só uma vez abaixo.
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ============================================================================
-- --- WORKSPACES --- #
-- ============================================================================

-- Troca de workspace com mainMod + [0-9]
-- Move a janela ativa para um workspace com mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 mapeia para a tecla 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Exemplo de workspace especial (scratchpad) -- estava comentado no original
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Rola pelos workspaces existentes com mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- ============================================================================
-- Teclas multimídia de notebook para volume e brilho da tela
-- ============================================================================
--
-- Trocamos wpctl/brightnessctl pelas chamadas de IPC do Noctalia, já que ele
-- mostra o OSD (indicador na tela) de volume/brilho quando é ele quem
-- processa o comando. Se você preferir manter wpctl/brightnessctl (sem OSD
-- do Noctalia), é só me pedir que eu volto pras linhas antigas.

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume increase"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume decrease"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume muteOutput"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(ipc .. " volume muteInput"), { locked = true, repeating = true })
hl.bind(mainMod .. " + XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. " brightness increase"), { locked = true, repeating = true })
hl.bind(mainMod .. " + XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness decrease"), { locked = true, repeating = true })

-- Requer playerctl (isso é independente do Noctalia, continua igual)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
-- ============================================================================
-- --- CAPTURA DE TELA ---
-- ============================================================================

-- Print da área selecionada (Super + Shift + S) -> Vai para a área de transferência
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))

-- Print da tela toda (Print) -> Salva em ~/Pictures/Screenshots/
-- Nota: A tecla Print sozinha geralmente é reconhecida como "PRINT"
hl.bind("PRINT", hl.dsp.exec_cmd("grim ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"))

-- Print da tela toda (Super + Print) -> Vai para a área de transferência
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("grim - | wl-copy"))