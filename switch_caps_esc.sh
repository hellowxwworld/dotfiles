#!/bin/sh

xmodmap - <<EOF
remove Lock = Caps_Lock
keysym Escape = Caps_Lock
keysym Caps_Lock = Escape
add Lock = Caps_Lock
EOF
echo swith caps and esc finished!
