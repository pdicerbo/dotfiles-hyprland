#!/usr/bin/env bash

theme="$HOME/.config/rofi/applets/style.rasi"

list_col='1'
list_row='5'
win_width='120px'

selected_row=0

get_options() {
    # Get current states
    speaker_muted=$(pamixer --get-mute)
    mic_muted=$(pamixer --default-source --get-mute)

    # Set icons based on state
    if [[ "$speaker_muted" == "true" ]]; then
        speaker_icon="🔇"
    else
        speaker_icon="🔊"
    fi

    if [[ "$mic_muted" == "true" ]]; then
        mic_icon="🎤"
    else
        mic_icon="🎙️"
    fi

    option_1="󰝝"
    option_2="󰝞"
    option_3="$speaker_icon"
    option_4="$mic_icon"
    option_5="🎧"
}

rofi_cmd() {
    rofi -theme-str "window {width: $win_width;}" \
        -theme-str "listview {columns: $list_col; lines: $list_row;}" \
        -theme-str 'textbox-prompt-colon {str: "";}' \
        -dmenu \
        -p "Audio" \
        -markup-rows \
        -selected-row "$selected_row" \
        -theme "${theme}"
}

run_rofi() {
    echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

while true; do
    get_options
    chosen="$(run_rofi)"

    case "$chosen" in
        "$option_1") pamixer -i 5; selected_row=0 ;;
        "$option_2") pamixer -d 5; selected_row=1 ;;
        "$option_3") pamixer -t; selected_row=2 ;;
        "$option_4") pamixer --default-source -t; selected_row=3 ;;
        "$option_5")
            pavucontrol &
            break
            ;;
        *) break ;;  # Escape or empty selection exits
    esac
done
