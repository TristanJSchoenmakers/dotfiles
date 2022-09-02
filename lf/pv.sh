#!/bin/sh

case "$1" in
  *) bat --theme "Visual Studio Dark+" --terminal-width "$(($4-2))" -f "$1";;
esac
