#!/usr/bin/env bash

# --- Config ---
USE_SYSTEM_ICONS=false # false = Emojis, true = System-Symbolicons

# --- Action ---
case $1 in
up) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ ;;
down) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
mute) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
mic) wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle ;;
*)
  echo "Usage: $0 {up|down|mute|mic}"
  exit 1
  ;;
esac

# --- MIC ---
if [ "$1" = "mic" ]; then
  muted=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED && echo 1 || echo 0)
  if [ "$muted" -eq 1 ]; then
    [ "$USE_SYSTEM_ICONS" = true ] && icon="microphone-sensitivity-muted-symbolic" || icon="🎙️"
    text="Mic muted"
    val=0
  else
    [ "$USE_SYSTEM_ICONS" = true ] && icon="microphone-sensitivity-high-symbolic" || icon="🎤"
    text="Mic active"
    val=100
  fi
  dunstify -a "Microphone" -r 9996 -u low -i " " -h int:value:"$val" "$icon  $text"
  exit 0
fi

# --- SINK / VOLUME ---
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | cut -d'.' -f1)
muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 1 || echo 0)

if [ "$muted" -eq 1 ]; then
  [ "$USE_SYSTEM_ICONS" = true ] && icon="audio-volume-muted-symbolic" || icon="🔇"
  dunstify -a "Volume" -r 9993 -u low -i " " -h int:value:0 "$icon  Muted"
  exit 0
fi

if [ "$USE_SYSTEM_ICONS" = true ]; then
  if [ "$volume" -lt 30 ]; then
    icon="audio-volume-low-symbolic"
  elif [ "$volume" -lt 70 ]; then
    icon="audio-volume-medium-symbolic"
  else
    icon="audio-volume-high-symbolic"
  fi
else
  if [ "$volume" -lt 30 ]; then
    icon="🔈"
  elif [ "$volume" -lt 70 ]; then
    icon="🔉"
  else
    icon="🔊"
  fi
fi

dunstify -a "Volume" -r 9993 -u low -i " " -h int:value:"$volume" "$icon  ${volume}%"
