#!/bin/sh

function handle {
  if [[ ${1:0:12} == "monitoradded" ]]; then
      #hyprctl keyword monitor eDP-1,preferred,auto,1
      hyprctl keyword monitor eDP-1,disable
  elif [[ ${1:0:14} == "monitorremoved" ]]; then
    hyprctl keyword monitor eDP-1,preferred,auto,1
    #if [[ ${1:14} == "DP-2" ]]; then
      #hyprctl keyword monitor eDP-1,disable
    #fi
  fi
}

sleep 5

socat - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do handle $line; done
