INTRO
=====

This is my config file for awesome_.

Dark theme.

.. _awesome: http://awesome.naquadah.org/


ScreenShot:

.. image:: http://i.minus.com/ibfu4HgE23Lf9U.png

Files
-----

* rc.lua

  + change basic setting in conf.lua
  + add some keybindings, see KeyBinding_
  + add some widgets , see Widgets_
  + widget and key to show/hide bottom panel
  + menu with apps.
  + change the default icon of awesome and floating.

* themes/default/theme.lua
    
  + changed some color and font settings. (Dejavu Sans Mono)

* keydoc.lua  

  + keydoc for keybindings.

* conf.lua

  + You should copy ``conf.lua.bak`` to conf.lua
  + change some basic settings here.
  + add autostart programs.

  :NOTE: to show the up/down net speed without error.
         You must set the ``NET_INTERFACE``

  


Instruction
===========

Install
-------

Requirements
~~~~~~~~~~~~

* volume: ``pamixer``
* music: ``mpd`` , ``mpc``, ``mpdlyrics``
* print screen : ``import``
* reboot/shutdown/log out : 
        
  have ``dbus`` and ``consolekit`` installed.
  add ``exec ck-launch-session awesome`` in ``.xinitrc``.

  or use ``gnome`` and ``gnome-session``

* Fonts: ``Dejavu Sans Mono`` and ``Monaco``

Commands
~~~~~~~~

.. This part should use code directive, but not supported by github

::

   git clone git://github.com/Rykka/awesome.git ~/.config/awesome
   cd ~/.config/awesome
   git clone git://github.com/Mic92/vicious.git 
   cp conf.lua.bak conf.lua

KeyBinding
----------

* Win + c : Show KeyBindings

Layouts
~~~~~~~

* Win + j/k (Up/Down) (Alt+Tab) : 
  move focus to next/prev client position
* Win + Shift + j/k (Up/Down) : 
  shift client to next/prev client position

* Win + h/l (Left/Right) (Win+Tab): 
  move to next/prev tag.
* Win + Shift + h/l (Left/Right) : 
  move client to next/prev tag.
* Win + n/p : 
  move to next/prev screen

Client Control
~~~~~~~~~~~~~~

* Win + ` /(q)   : Minimize
* Win + Ctrl+`   : UnMinimize
* Win + Space: Maxmize Toggle
* Win + Ctrl+Space :FullScreen Toggle
* Win + f :Floating client Toggle
* Win + r :redraw client
* Win + q :minimize 
* Win + x (Alt +F4) : close client

Miscs
~~~~~

* Win + F1/F2/F3/F4 : terminal,editor,browser,file manger.
* Win + Home/End  : mpc  prev / next
* Win + PgUp/PgDn: volumne Up/Down

* Win + b or widget ``◈`` on the top_right:
  show/hide bottom panel

* Buttons on tasklist:

  + right click : focus and toggle floating.
  + left click : minimize


Widgets
-------

* Volume: volume control 

  + left-click(toggle mute)
  + wheel-down/up to decrease/increase volume
  + show volume in tooltip

* CPU:show CPU details in tooltip
* Mem:show Mem details in tooltip
* Uptime
* Battery
* Mpd: add mpd control 

  + wheel-down/up(next/prev)
  + left-click(toggle playing)
  + right-click(stop)
  + middle-click (show lyric)

Config
------

* edit in conf.lua
* More : 

  see https://wiki.archlinux.org/index.php/Awesome 

  and http://awesome.naquadah.org/wiki/Main_Page

