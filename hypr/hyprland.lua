-- ~/.config/hypr/hyprland.lua
-- Entry point: carrega cada módulo de config/
-- Refer to the wiki for more information: https://wiki.hypr.land/Configuring/Start/
--
-- IMPORTANTE: no config antigo (notebook), este arquivo não fazia require()
-- de nada — os módulos abaixo existiam mas nunca eram carregados de verdade.
-- Corrigido aqui.

require("config.environment")
require("config.colors")
require("config.defaults")
require("config.decorations")
require("config.animations")
require("config.monitors")
require("config.input")
require("config.misc")
require("config.autostart")
require("config.keybinds")
require("config.windowrules")