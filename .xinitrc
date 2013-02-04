#!/bin/bash

export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx # 或者是xim，取决于你是否编译了对应的输入法模块
export QT_IM_MODULE=fcitx # 或者是xim，取决于你是否编译了对应的输入法模块
#启用gnome的主题
gnome-settings-daemon &    
#电源管理程序
gnome-power-manager &      
#网络管理程序
nm-applet --sm-disable &                           
#自动更新程序
update-notifier &

exec awesome
