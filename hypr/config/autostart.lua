-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
--
-- Confirmado: este PC não tem noctalia.service (systemctl --user não achou),
-- e "cachyos-hypr-noctalia" é só o pacote de dotfiles/config, não um binário.
-- Então o Hyprland precisa subir o Noctalia v5 (binário nativo) sozinho.

hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")

    -- Descomente se o tray do KDE (kded6) ficar roubando os ícones do Noctalia
    -- hl.exec_cmd("pkill kded6")
end)