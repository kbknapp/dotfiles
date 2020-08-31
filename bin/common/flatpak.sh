#!/bin/bash

FLATPAK_INSTALL_CMD='flatpak install --user -y'

function f_flatpak_common() {
    f_out "Installing flathub"

    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

function f_git_kraken_main() {
    f_check_prog "flatpak"

    f_out "Installing GitKraken"

    $FLATPAK_INSTALL_CMD flathub com.axosoft.GitKraken
}

function f_discord_main() {
    f_check_prog "flatpak"

    f_out "Installing Discord"

    $FLATPAK_INSTALL_CMD flathub com.discordapp.Discord
}

function f_dropbox_main() {
    f_check_prog "flatpak"

    f_out "Installing Dropbox"

    $FLATPAK_INSTALL_CMD flathub com.dropbox.Client
}

function f_slack_main() {
    f_check_prog "flatpak"

    f_out "Installing Slack"

    $FLATPAK_INSTALL_CMD flathub com.slack.Slack
}

function f_code_main() {
    f_check_prog "flatpak"

    f_out "Installing Visual Studio Code"

    $FLATPAK_INSTALL_CMD flathub com.visualstudio.code.oss
}

function f_signal_main() {
    f_check_prog "flatpak"

    f_out "Installing Signal"

    $FLATPAK_INSTALL_CMD flathub org.signal.Signal
}

function f_telegram_main() {
    f_check_prog "flatpak"

    f_out "Installing Telegram"

    $FLATPAK_INSTALL_CMD flathub org.telegram.desktop
}

function f_riot_main() {
    f_check_prog "flatpak"

    f_out "Installing Riot"

    $FLATPAK_INSTALL_CMD flathub im.riot.Riot
}

function f_flatseal_main() {
    f_check_prog "flatpak"

    f_out "Installing Flatseal"

   $FLATPAK_INSTALL_CMD flathub com.github.tchx84.Flatseal
}

function f_flatpak_apps_main() {
    local _FP_APPS

    _FP_APPS=$(dialog --checklist "Which Flatpak Apps?" 400 400 8 \
       git_kraken "GitKraken" on \
       discord "Discord" on \
       dropbox "Dropbox" off \
       slack "Slack" off \
       code "Visual Studio Code" off \
       signal "Signal" on \
       telegram "Telegram" on \
       riot "Riot" off \
       flatseal "Flatseal" on \
        --output-fd 1)
    clear

    readonly _FP_APPS

    for APP in ${_FP_APPS[@]}; do
        f_${APP}_main
    done
}
