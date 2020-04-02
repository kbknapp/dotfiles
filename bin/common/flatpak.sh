#!/bin/bash

function f_flatpak_common() {
    f_out "Installing flathub"

    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

function f_git_kraken_main() {
    f_check_prog "flatpak"

    f_out "Installing GitKraken"

    flatpak install -y flathub com.axosoft.GitKraken
}

function f_discord_main() {
    f_check_prog "flatpak"

    f_out "Installing Discord"

    flatpak install -y flathub com.discordapp.Discord
}

function f_dropbox_main() {
    f_check_prog "flatpak"

    f_out "Installing Dropbox"

    flatpak install -y flathub com.dropbox.Client
}

function f_slack_main() {
    f_check_prog "flatpak"

    f_out "Installing Slack"

    flatpak install -y flathub com.slack.Slack
}

function f_code_main() {
    f_check_prog "flatpak"

    f_out "Installing Visual Studio Code"

    flatpak install -y flathub com.visualstudio.code.oss
}

function f_signal_main() {
    f_check_prog "flatpak"

    f_out "Installing Signal"

    flatpak install -y flathub org.signal.Signal
}

function f_telegram_main() {
    f_check_prog "flatpak"

    f_out "Installing Telegram"

    flatpak install -y flathub org.telegram.desktop
}

function f_riot_main() {
    f_check_prog "flatpak"

    f_out "Installing Riot"

    flatpak install -y flathub im.riot.Riot
}

function f_flatpak_apps_main() {
    local _FP_APPS

    _FP_APPS=$(dialog --checklist "Which Flatpak Apps?" 400 400 8 \
       git_kraken "GitKraken" on \
       discord "Discord" on \
       dropbox "Dropbox" off \
       slack "Slack" off \
       code "Visual Studio Code" on \
       signal "Signal" on \
       telegram "Telegram" on \
       riot "Riot" off \
        --output-fd 1)
    clear

    readonly _FP_APPS

    for APP in ${_FP_APPS[@]}; do
        f_${APP}_main
    done
}


