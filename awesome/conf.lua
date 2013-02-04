-- Local Configs for rc.lua
conf = {}

-- the net interface , 'eth0' or 'wlan0' in most cases
conf.NET_INTERFACE = "eth0"

-- This is used later as the default terminal and editor to run.
conf.TERMINAL = "urxvt"

--editor = os.getenv("EDITOR") or "nano"
conf.EDITOR = "gvim"

conf.BROWSER = "firefox"
conf.FILE_MANAGER = "nautilus"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
conf.MODKEY = "Mod4"

-- startup programs here.
-- e.g. 
-- { easystroke = "easystroke" } or { 'easystroke'}
conf.STARTUP_PROGRAM = { 'xcompmgr',
						'fcitx',
						'synergys' }


-- your app menu
conf.MY_APP_MENU = {
    { "&amule"      , "amule"           } ,
    { "&chrome"     , "google-chrome" , } ,
    { "&deluge"     , "deluge"          } ,
    { "&easystroke" , "easystroke"      } ,
    { "go&ldendict" , "goldendict"      } ,
    { "&office"     , "libreoffice"   , } ,
    { "&shutter"    , "shutter"       , } ,
    { "&virtualbox" , "virtualbox"      } ,
    { "&xchat"      , "xchat"           } ,
    { "---------"   , ""                } ,
    { "gimp"        , "gimp"            } ,
    { "mypaint"     , "mypaint"         } ,
    { "sublime2"    , "subl"            } ,
    { "screenkey"   , "screenkey"       } ,
}

-- pictures (wallpaper)
conf.WALLPAPER_CMD = "feh --bg-scale -z ~/Pictures/wallpaper"


-- 'orange' or 'theme' for default
conf.THEME = "theme"

-- unfocused client with transparency
-- Note: You need a running compositor such as xcompmgr or cairo-compmgr. 
conf.TRANSPARENCY = 1.0
return conf
