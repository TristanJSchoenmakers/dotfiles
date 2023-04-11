#!/bin/sh

case "$1" in
  *.md) glow -s dark -p -w "$(($4-2))" "$1";;
  *) bat --theme "Visual Studio Dark+" --terminal-width "$(($4-2))" -f "$1";;
esac
