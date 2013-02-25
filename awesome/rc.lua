-- TODO : --{{{
-- Advancing the awesome wm.
--
--  0. Useful Widgets. Tidy Interface.
--
--  1. Widgets
--    calendar/todo
--    autohiding bar
--
--  2. Mappings , add KeyDoc
--
--  3. theme
--
--      several theme color switch
--
--      icon set.
--          widgets
--          floating.  layout
--          app, tray
--
--      fonts
--
--      relevation? 
--      https://awesome.naquadah.org/wiki/Revelation
--
--      resolution for laptop/desktop
--
--  4. configureable and seperate config file. (rc.conf)
--      show/hide widgets,bars

--  5. extensive,
--      API?
--}}}

-- Libraries --{{{
-- /usr/share/awesome/
local awful = require("awful")
require("awful.autofocus")
awful.rules = require("awful.rules")
require("awful.tag")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local vicious = require('vicious')
local wibox = require("wibox")

local keydoc = require("keydoc")
-- seperate settings
local conf = require('conf')
--}}}

--{{{ Load Vars
terminal = conf.TERMINAL
editor = conf.EDITOR
browser =  conf.BROWSER
file_manager = conf.FILE_MANAGER
modkey = conf.MODKEY
theme = conf.THEME
transparency = conf.TRANSPARENCY

config_dir = awful.util.getdir("config")

function init_theme(theme) --{{{
    local config_dir = config_dir
    beautiful.init(config_dir .. "/".."themes/zenburn/" 
        .. tostring(theme) .. ".lua")
end --}}}

init_theme(theme)

local exes = awful.util.spawn_with_shell
local exec = awful.util.spawn
--exes(conf.wallpaper_cmd)
--}}}

-- {{{ Functions

function merge_table(t1,t2) --{{{
    -- merge two table of {{1,2}, {2,3}}
    local t = {}
    for j = 1 , #t1 do
        t[#t+1] = t1[j]
    end
    for j = 1 , #t2 do
        t[#t+1] = t2[j]
    end
    return t
end --}}}
function rel_movetag(n) --{{{
    local screen = screen
    local scr = mouse.screen
    local query_tag  = awful.tag.selected()
    for i, t in ipairs(screen[query_tag.screen]:tags()) do
        if t == query_tag then
            if tags[scr][i+n] then
                awful.client.movetotag(tags[scr][i+n])
                awful.tag.viewidx(n)
            end
            break
        end
    end
end --}}}

 -- Get a relative tag number
 function getrelativetag(delta, screen)
     return (awful.tag.getidx(selected) + delta - 1) % #tags[screen] + 1
 end
 
 -- Move the focused window to the next tag
 function movetonexttag(delta)
     local stags = {}
     if client.focus then
         stags = tags[client.focus.screen]
         awful.client.movetotag(stags[getrelativetag(delta, 1)])
     else
         stags = tags[1]
     end
 
     awful.tag.viewonly(stags[getrelativetag(delta, 1)])
 end

function dbg(vars) --{{{
    local text = ""
    for i=1, #vars do text = text .. tostring(vars[i]) .. " | " end
    naughty.notify({ text = text, timeout = 0 })
end --}}}
function echo (arg) --{{{
    naughty.notify({text=tostring(arg)})
end --}}}
background_timers = {}
function run_background(cmd,funtocall) --{{{
   local r = io.popen("mktemp")
   local logfile = r:read("*line")
   r:close()

   cmdstr = cmd .. " &> " .. logfile .. " & "
   local cmdf = io.popen(cmdstr)
   cmdf:close()
   background_timers[cmd] = {
       file  = logfile,
       timer = timer{timeout=1}
   }
   background_timers[cmd].timer:connect_signal("timeout",function()
       local cmdf = io.popen("pgrep -f '" .. cmd .. "'")
       local s = cmdf:read("*all")
       cmdf:close()
       if (s=="") then
           background_timers[cmd].timer:stop()
           local lf = io.open(background_timers[cmd].file)
           funtocall(lf:read("*all"))
           lf:close()
           io.popen("rm " .. background_timers[cmd].file)
       end
   end)
   background_timers[cmd].timer:start()
end --}}}
function usefuleval(s) --{{{
	local f, err = loadstring("return "..s);
	if not f then
		f, err = loadstring(s);
	end
	
	if f then
		setfenv(f, _G);
		local ret = { pcall(f) };
		if ret[1] then
			-- Ok
			table.remove(ret, 1)
			local highest_index = #ret;
			for k, v in pairs(ret) do
				if type(k) == "number" and k > highest_index then
					highest_index = k;
				end
				ret[k] = select(2, pcall(tostring, ret[k])) 
                    or "<no value>";
			end
			-- Fill in the gaps
			for i = 1, highest_index do
				if not ret[i] then
					ret[i] = "nil"
				end
			end
			if highest_index > 0 then
                naughty.notify({ 
                    text = awful.util.escape("Result" ..
                        (highest_index > 1 and "s" or "") .. ": " ..
                        tostring(table.concat(ret, ", "))),
                    screen = mouse.screen,
                    title="Lua eval", 
                    position="top_left"})
            else
                naughty.notify({ text="Result: Nothing",
                    screen = mouse.screen,
                    title="Lua eval",
                    position="top_left"})
			end
		else
			err = ret[2];
		end
	end
	if err then
        naughty.notify({ 
            text = awful.util.escape("Error: "..tostring(err)),
            screen = mouse.screen, title="Lua eval",
            position="top_left"})
	end
end --}}}
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ 
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[8])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
local sys = {}
function sys.suspend()
    exec('dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend')
end

function sys.hibernate()
    exec('dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Hibernate')
end
function sys.reboot()
    exec('dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart')
end
function sys.shutdown()
    exec('dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop')
end
function sys.logout()
    exec('gnome-session-quit')
end
myawesomemenu = {
  { "version " .. awesome.version , " " },
  { "&manual", editor .. " '+Man awesome'" },
  { "&edit config", editor .. " " .. awesome.conffile },
  { "&wallpaper", conf.WALLPAPER_CMD },
  { "----------", " "},
  { "&restart", awesome.restart },
  { "&quit", awesome.quit },
}
mysysmenu = {
   { "&log out",  sys.logout },
   { "&suspend",  sys.suspend },
   { "hibernate",  sys.hibernate},
   { "&reboot", sys.reboot ,  },
   { "sh&utdown", sys.shutdown ,  },
}
myappmenu = conf.MY_APP_MENU


local exmenu = {
    { "&Terminal"       , terminal                   , } ,
    { "&Browser"    , browser                  , } ,
    { "&Editor"      , editor , } ,
    { "&File Manager"  , file_manager , } ,
    { "----------", " "},
    { "&apps", myappmenu },
    { "a&weseome", myawesomemenu },
    { "&system",  mysysmenu },
}

mymainmenu = awful.menu({ items = exmenu })

mylauncher = awful.widget.launcher({ 
    image = beautiful.awesome_icon,
    menu = mymainmenu })

awful.menu.menu_keys = { up    = { "k", "Up" },
                         down  = { "j", "Down" },
                         exec  = { "l", "Return", "Right" },
                         -- the new item
                         enter = { "Right" },
                         --
                         back  = { "h", "Left" },
                         close = { "q", "Escape" },
                       }
-- }}}

---- {{{ Wibox widgets
--
function span(text,color,...) --{{{
    local color = color or "White"
    local fontsize = 13
    return "<span font='bold " .. fontsize .. 
        "' foreground='".. color .."'> " .. 
        text .. " </span>"
end --}}}
--
---- Bottom panel show/hide --{{{
----local my_bot_toggle = widget({type='textbox'})
--local my_bot_toggle = wibox.widget.textbox()
--my_bot_toggle:set_text(span('◈','White',18))
--my_bot_toggle:buttons(awful.util.table.join(
--    awful.button({ }, 1, 
--    function()
--        mybotwibox[mouse.screen].visible = 
--            not mybotwibox[mouse.screen].visible 
--    end)
--))
--local my_bot_toggle_t = awful.tooltip({
--    objects = { my_bot_toggle },
--    timer_function = 
--    function()
--        return "Toggle Bottom Panel "
--    end,
--})
----}}}
--
---- client killer --{{{
--local my_client_kill = wibox.widget.textbox()
--my_client_kill:set_text(span('X'))
--my_client_kill:buttons(awful.util.table.join(
--    awful.button({ }, 1, function()
--        client.focus:kill()
--    end)
--))
--local my_client_kill_t  = awful.tooltip({
--    objects = { my_client_kill },
--    timer_function = function()
--        return "Kill:" .. client.focus.name
--    end,
--}) --}}}
--
---- {{{ separator
--local spacer = wibox.widget.textbox({name='spacer'})
--local separator = wibox.widget.textbox({ name = "separator" })
--spacer:set_text( "  ")
--separator:set_text( span("•","Gray"))
---- }}}
-- {{{ Textclock
mytextclock = awful.widget.textclock(" %H:%M ")
--local calendar = nil
--local offset = 0
--
--function remove_calendar()
--    if calendar ~= nil then
--        naughty.destroy(calendar)
--        calendar = nil
--        offset = 0
--    end
--end
--
--function add_calendar(inc_offset)
--    local save_offset = offset
--    remove_calendar()
--    offset = save_offset + inc_offset
--    local datespec = os.date("*t")
--    datespec = datespec.year * 12 + datespec.month - 1 + offset
--    datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12)
--    local cal = awful.util.pread("cal -m " .. datespec)
--    cal = string.gsub(cal, "^%s*(.-)%s*$", "%1")
--    calendar = naughty.notify({
--        text = string.format('<span font_desc="%s">%s</span>', "monospace", os.date("%a, %d %B %Y") .. "\n" .. cal),
--        timeout = 0, hover_timeout = 0.5,
--        width = 180,
--    })
--end
---- change clockbox for your clock widget (e.g. mytextclock)
--mytextclock:connect_signal("mouse::enter", function()
--    add_calendar(0)
--end)
--mytextclock:connect_signal("mouse::leave", remove_calendar)
local mytextclock_t  = awful.tooltip({
objects = { mytextclock },
timer_function = 
    function()
        return string.format("%s", os.date("%a, %d %B %Y"))
    end,
})
--}}}
---- {{{ CPU load
--local cpuwidget =  wibox.widget.textbox()
--vicious.register(cpuwidget, vicious.widgets.cpu,
--function (widget ,args)
--    return string.format(span("❖") .. "%2d%%",args[1])
--end)
--
--local cpuwidget_t  = awful.tooltip({
--objects = { cpuwidget },
--timer_function = 
--    function()
--        local args = vicious.widgets.cpu()
--        return string.format("CPU Detail:\n1:\t%2d%%\n2:\t%2d%%\n3:\t%2d%%\n4:\t%2d%%",
--        args[2],args[3],args[4],args[5])
--    end,
--})
---- }}}
---- {{{ Mem load
--local memwidget = wibox.widget.textbox()
--vicious.register(memwidget, vicious.widgets.mem,
--function (widget ,args)
--    return string.format(span("▯") .. "%2d%% ",args[1])
--end)
--
--local memwidget_t  = awful.tooltip({
--objects = { memwidget },
--timer_function = function()
--    local args = vicious.widgets.mem()
--    return string.format("Memory Detail:\nTotal Mem:\t%s\nMem Used:\t%s\nFree Mem:\t%s\nSwap Used:\t%s", 
--        args[3],args[2],args[4],args[6])
--end,
--})
---- }}}
---- {{{ CPU temperature
----local thermalwidget = widget({ type = "textbox" })
----vicious.register(thermalwidget, vicious.widgets.thermal,  span("T:")  .. " $1°C", 20, "thermal_zone0")
---- }}}
-- {{{ Volume widget
-- local volwidget =  wibox.widget.textbox()
-- --vicious.register(volwidget, vicious.widgets.volume, " $1% ", 1,"Master")
-- 
-- volwidget:set_markup(span(""))
-- function voltext(vol,mute) --{{{
--     -- ' - ♩ ♪ ♫ ♬ '
--     if  mute =="true" then
--         return span("-")
--     else 
--         local v = tonumber(vol)
--         if v >= 100 then
--             return span("♬")
--         elseif v >= 60 then
--             return span("♫")
--         elseif v >= 30 then
--             return span("♪")
--         else
--             return  span("♩")
--         end
--     end
-- end --}}}
-- function getvol() --{{{
--     local f = io.popen("pamixer --get-mute" )
--     local mute = f:read("*all")
--     f:close()
--     local d = io.popen("pamixer --get-volume" )
--     local vol = d:read("*all")
--     d:close()
--     return vol, mute
-- end --}}}
-- local vol,mute = getvol()
-- volwidget:set_markup( voltext(vol,mute))
-- volwidget:buttons(awful.util.table.join(
--     awful.button({ }, 1, function()
--         local vol,mute = getvol()
--         if mute == "true" then
--             exes("pamixer --unmute")
--             m = "false"
--         else
--             exes("pamixer --mute")
--             m = "true"
--         end
--         volwidget:set_markup( voltext(vol, m))
--     end),
--     awful.button({ }, 4, function()
--         exes("pamixer --increase 4")
--         local vol,mute = getvol()
--         volwidget:set_markup( voltext(vol, mute))
--     end),
--     awful.button({ }, 5, function()
--         exes("pamixer --decrease 4")
--         local vol,mute = getvol()
--         volwidget:set_markup( voltext(vol, mute))
--     end)
-- ))
-- local volwidget_t  = awful.tooltip({
-- objects = { volwidget },
-- timer_function = function()
--     local vol,mute = getvol()
--     return "VOL:"..vol.."\nMUTE:"..mute.."\nVol Control:\nScroll Up:\tIncrease\nScroll Down:\tDecrease"
-- end,
-- })
-- }}}
---- {{{ Uptime
--uptimewidget =  wibox.widget.textbox()
--vicious.register(uptimewidget, vicious.widgets.uptime,
--        function (widget, args)
--            return string.format(span("⟳").."%2dh%2dm", 
--                args[2], args[3])
--        end, 61)
--uptime_t  = awful.tooltip({
--objects = { uptimewidget },
--timer_function = 
--    function()
--        local args = vicious.widgets.uptime()
--        return string.format("Uptime:\n%dd %2dh %2dm", 
--            args[1], args[2], args[3])
--    end,
--})
----}}}
---- {{{ Lyric
----local function lrc_worker(format, warg) --{{{
----    -- assume 'lrcdis -m echo > /tmp/lrc &' is executing
----    local f = io.popen("tail -1 /tmp/lrc ")
----    local c = f:read("*line")
----    f:close()
----    if c==nil or c=="" then
----        c = "---------------"
----    end
----    -- XXX wrong encoding in lyric will output invalid markup
----    return {vicious.helpers.escape(c)}
----    --return {c}
----end --}}}
----local lrcwidget = widget({ type = "textbox" })
----vicious.register(lrcwidget, lrc_worker,
----        function (widget, args)
----            return  span("#") .. args[1] .. span("#")
----        end,1)
--local lyric = nil
--
--function remove_lyric()
--    if lyric ~= nil then
--        naughty.destroy(lyric)
--        lyric = nil
--    end
--end
--
--function add_lyric()
--    remove_lyric()
--    run_background("mpdlyrics -n",function(txt)
--   lyric = naughty.notify({text=txt,
--        timeout = 0, hover_timeout = nil,
--        position="bottom_right",
--        width = 400,height=1000,font="monospace 11"})
--end)
--end
---- }}}
---- {{{ mpd
---- Initialize widget
--local mpdwidget =  wibox.widget.textbox()
--
---- Register widget
--vicious.register(mpdwidget, vicious.widgets.mpd,
--    function (widget, args)
--        if args["{state}"] == "Stop" then
--            return span("■ ") .. "Stopped"
--        else
--            local cmdf = io.popen("mpc")
--            local txt = ""
--
--            if cmdf == nil then
--                txt = span("▶ ") .. args["{Artist}"] .. 
--                    ' - '.. args["{Title}"]
--            else
--                local i = 1
--                for line in cmdf:lines() do
--                    if i == 2 then
--                        w = string.find(line, "%[paused%]")
--                        if w then
--                            txt = span("❚❚") .. args["{Artist}"] .. 
--                                ' - '.. args["{Title}"]
--                        end
--                        break
--                    end
--                    i = i + 1
--                end
--            end
--            cmdf:close()
--
--            if txt == "" then
--                return span("▶ ") .. args["{Artist}"] ..
--                    ' - '.. args["{Title}"]
--            else
--                return txt
--            end
--        end
--    end,
--10)
--
--mpdwidget:buttons(awful.util.table.join(
--    awful.button({ }, 1, function()
--        exes("mpc toggle")
--        vicious.force({ mpdwidget, })
--    end),
--    awful.button({ }, 2, add_lyric),
--    awful.button({ }, 3, function()
--        exes("mpc stop")
--        vicious.force({ mpdwidget, })
--    end),
--    awful.button({ }, 4, function()
--        exes("mpc prev")
--        vicious.force({ mpdwidget, })
--    end),
--    awful.button({ }, 5, function()
--        exes("mpc next")
--        vicious.force({ mpdwidget, })
--    end)
--))
--
--local mpdwidget_t  = awful.tooltip({
--    objects = { mpdwidget },
--    timer_function = function()
--        local cmdf = io.popen("mpc stats")
--        local txt = cmdf:read("*all")
--        cmdf:close()
--        local cmdf = io.popen("mpc status")
--        local txt2 = cmdf:read("*all")
--        cmdf:close()
--        txt3 = "\nWidget Control:\n\nLeft Click:\tToggle\nRight Click:\tStop\nScroll Up:\tPrev\nScroll Down:\tNext"
--        if txt =="" or txt == nil then
--            return txt3
--        else
--            return "Song Status:\n\n" .. txt2 .. "\nMPC Status:\n\n" .. txt .. txt3
--        end
--    end,
--})
----}}}
---- {{{ net
--function netspd (spd) --{{{
--    return "{" .. conf.NET_INTERFACE .. " ".. spd .. "_kb}"
--end --}}}
--local netwidget =  wibox.widget.textbox()
--
---- Register widget
--vicious.register(netwidget, vicious.widgets.net,
--    function (widget, args)
--        return span("▲")  .. string.format("%4.1f",args[netspd("up")]) .. span("▼")  .. string.format("%4.1f",args[netspd("down")])
--    end )
--
--local netwidget_t  = awful.tooltip({
--objects = { netwidget },
--timer_function = function()
--    local args = vicious.widgets.net()
--    return string.format("Net Details:\nUp:\t%5.1fKB\nDown:\t%5.1fKB",args[netspd("up")],args[netspd("down")])
--end,
--})
----}}}
---- battery --{{{
--local batwidget =  wibox.widget.textbox()
--
--vicious.register(batwidget, 
--    vicious.widgets.bat, 
--    function (wdiget, args)
--        return span("⊕")..args[2]
--    end, 
--61, "BAT0")
--battery_t = awful.tooltip({
--    objects = { batwidget },
--    timer_function = function()
--        local args = vicious.widgets.uptime()
--        return string.format(
--            "Battery:\n State:%s\nRemaining Time:%s",
--            args[1],args[3])
--    end,
--})
----}}}
--
---- dock
---- Create a systray
--mysystray =  wibox.widget.systray()
--
---- }}}
--
-- {{{ Wibox Layout
-- Create a wibox for each screen and add it
mywibox = {}
mybotwibox = {}
mypromptbox = {}
mylayoutbox = {}
--{{{ tag button
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
--}}}
--{{{ task bar button
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
    awful.button({ }, 3, function (c)
    if c == client.focus then
        c.minimized = true
    else
        if not c:isvisible() then
            awful.tag.viewonly(c:tags()[1])
        end
        -- This will also un-minimize
        -- the client, if needed
        client.focus = c
        c:raise()
    end
                        end),
    awful.button({ }, 1, function (c)
    if c == client.focus then
        c.maximized_horizontal = not c.maximized_horizontal
        c.maximized_vertical   = not c.maximized_vertical
    elseif not c:isvisible() then
        awful.tag.viewonly(c:tags()[1])
        -- This will also un-minimize
        -- the client, if needed
        client.focus = c
        c:raise()
    elseif c ~= client.focus then
        client.focus = c
        c:raise()
    end
                        end),
    awful.button({ }, 4, function ()
                            awful.client.focus.byidx(1)
                            if client.focus then client.focus:raise() end
                        end),
    awful.button({ }, 5, function ()
                            awful.client.focus.byidx(-1)
                            if client.focus then client.focus:raise() end
                        end))

--}}}
--{{{ Wibox
for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
        awful.button({ }, 1, 
        function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 3, 
        function () awful.layout.inc(layouts, -1) end),
        awful.button({ }, 4, 
        function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 5, 
        function () awful.layout.inc(layouts, -1) end)
    ))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, 
        awful.widget.taglist.filter.noempty, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons) 
    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "bottom", screen = s })

    ---- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mytextclock)
    --right_layout:add(volwidget)
    right_layout:add(mylayoutbox[s])

    ---- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
    ---- Add widgets to the wibox - order matters
    --mywibox[s].widgets = {
    --    {
    --        mylauncher,
    --        mytaglist[s],
    --        mypromptbox[s],
    --        layout = awful.widget.layout.horizontal.leftright
    --    },
    --    --my_bot_toggle,
    --    mylayoutbox[s],
    --    s == 1 and mysystray or nil,
    --    mytextclock,
    --    --volwidget,
    --    --my_client_kill,
    --    mytasklist[s],
    --    layout = awful.widget.layout.horizontal.rightleft
    --}

    ---- Create the wibox
    --mybotwibox[s] = awful.wibox({ position = "top", screen = s })
    ------ Add widgets to the wibox - order matters
    --mybotwibox[s].widgets = {
    --    {
    --        --cpuwidget,
    --        --memwidget,
    --        --uptimewidget,
    --        --spacer,
    --        --netwidget,
    --        --batwidget,
    --        layout = awful.widget.layout.horizontal.leftright,
    --    },
    --    spacer,
    --    --mpdwidget,
    --    layout = awful.widget.layout.horizontal.rightleft
    --}
    --mybotwibox[s].visible = false
end --}}}
--}}}
--
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join( --{{{
    awful.key({ modkey, }, "c",
        keydoc.display, "Display Document"),

    keydoc.group("Layout manipulation"),

    awful.key({ }, "Print", 
        function () 
            local date =os.date("%Y_%m_%d-%H_%M_%S") 
            local cmd =  "import -window root ~/Pictures/"..date..".png"
            awful.util.spawn_with_shell(cmd) 
            naughty.notify({text=cmd})
        end, "Print Screen"),
    awful.key({ modkey,           }, "Escape", 
        awful.tag.history.restore),
    awful.key({ modkey }, "Print", 
        function () 
            local date = os.date("%Y_%m_%d-%H_%M_%S")
            local cmd =  "import ~/Pictures/"..date..".png"
            awful.util.spawn_with_shell(cmd) 
            naughty.notify({text=cmd})
        end, "Capture Window"),

    awful.key({ modkey,           }, "h", 
        awful.tag.viewprev, "Prev Tag"       ),
    awful.key({ modkey,           }, "l", 
        awful.tag.viewnext, "Next Tag"       ),

    --awful.key({ modkey, "Shift"   }, "h",       
        --function () rel_movetag(-1) end, "Move to Prev Tag"),
    --awful.key({ modkey, "Shift"   }, "l",       
        --function () rel_movetag(1)  end, "Move to Next Tag"),

     --awful.key({ "modkey", "Shift" }, "h",  function () awful.tag.viewprev() end),
     --awful.key({ "Mod4" }, "Right",  function () awful.tag.viewnext() end),
     awful.key({ modkey, "Shift" }, "h",  function () movetonexttag(-1) end),
     awful.key({ modkey, "Shift" }, "l", function () movetonexttag( 1) end),

awful.key({ modkey, "Shift"   }, "o",
          function (c)
            c.screen = awful.util.cycle(screen.count(), mouse.screen + 1)
            awful.screen.focus(c.screen)
          end),

    awful.key({ modkey,           }, "Left",  
        awful.tag.viewprev, "Prev Tag"      ),
    awful.key({ modkey,           }, "Right", 
        awful.tag.viewnext, "Next Tag"       ),
    --awful.key({ modkey, "Shift"   }, "Left",  
        --function () rel_movetag(-1) end, "Move to Prev Tag"),
    --awful.key({ modkey, "Shift"   }, "Right",
        --function () rel_movetag(1)  end, "Move to Next Tag"),
     awful.key({ modkey, "Shift" }, "Left",  function () movetonexttag(-1) end),
     awful.key({ modkey, "Shift" }, "Right", function () movetonexttag( 1) end),

    keydoc.group("Moving Between Clients"),
--    awful.key({ modkey,           }, "Tab",
--        awful.tag.viewnext, "View Next"),
    awful.key({ modkey,           }, "Tab",
         function ()
             awful.client.focus.byidx( 1)
             if client.focus then client.focus:raise() end
        end),

   awful.key({ "Mod1",           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
   awful.key({ modkey,"Shift"           }, "Tab", 
       function ()
           awful.client.focus.byidx(-1)
           if client.focus then client.focus:raise() end
       end),
    awful.key({ modkey,           }, "j", 
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end, "Next Client"),
    awful.key({ modkey,           }, "k", 
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end, "Prev Client"),
    awful.key({ modkey,           }, "Up",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end, "Next Client"),
    awful.key({ modkey,           }, "Down", 
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end, "Prev Client"),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1) end, "Shift to Next"),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1) end, "Shift to Prev"),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey, "Shift"   }, "Up", function () awful.client.swap.byidx(  1) end, "Shift to Next"),
    awful.key({ modkey, "Shift"   }, "Down", function () awful.client.swap.byidx( -1) end, "Shift to Prev"),
    awful.key({ modkey, "Control" }, "n", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "p", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey }, "b", function () mybotwibox[mouse.screen].visible = not mybotwibox[mouse.screen].visible end, "Toggle Bottom Panel"),

    keydoc.group("Audio Control"),
    awful.key({ modkey,           }, "Page_Up",   function() exes("pamixer --increase 4") end, "Volume Up"),
    awful.key({ modkey,           }, "Page_Down", function() exes("pamixer --decrease 4") end, "Volume Down"),
    awful.key({ modkey,           }, "Home",   function() exes("mpc prev")
            vicious.force({ mpdwidget, }) end, "Prev Sone"),
    awful.key({ modkey,           }, "End",    function() exes("mpc next")
            vicious.force({ mpdwidget, }) end, "Next Song"),
    awful.key({ modkey,           }, "Insert", function() exes("mpc toggle") vicious.force({ mpdwidget, }) end, "Toggle Play"),
    awful.key({ modkey,           }, "Delete", 
    function() exes("pamixer --toggle-mute") end, "Mute Song"),

    awful.key({ modkey, "Control" }, "`", awful.client.restore),
    awful.key({ modkey, "Control" }, "q", awful.client.restore),

    -- Layout manipulation

    -- Standard program
    keydoc.group("Programs"),
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "w",  
    function () mymainmenu:show({keygrabber=true}) end , "Show App Menu"),
    awful.key({ modkey,           }, "F1", 
    function () awful.util.spawn(terminal)         end ),
    awful.key({ modkey,           }, "F2", 
    function () exec(editor)                       end ),
    awful.key({ modkey,           }, "F3", 
    function () exec(browser)                    end ),
    awful.key({ modkey,           }, "F4", 
    function () exec(file_manager)              end ),
    awful.key({ modkey, "Control" }, "r", awesome.restart),

    awful.key({ modkey,           }, "=",  
    function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "-",  
    function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "=",  
    function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "-",  
    function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "=",  
    function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "-",  
    function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "]",  
    function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey,           }, "[", 
    function () awful.layout.inc(layouts, -1) end),


     --Prompt
    awful.key({ modkey, "Shift" }, "r",
        function ()
            awful.prompt.run({ 
                prompt = "<span color='#BF7900'>Lua:</span>" ,
                font="Monaco bold 12"},
            mypromptbox[mouse.screen].widget,
            usefuleval, nil,
            awful.util.getdir("cache") .. "/history_eval")
        end, 
    "Run Lua Code"),

    awful.key({ modkey,    }, "r",   
        function () 
            --mypromptbox[mouse.screen]:run({prompt="R:"}) 
            awful.prompt.run({ 
                    prompt = "<span color='#00A5AB'>Run:</span>" , 
                    font="Monaco bold 12"},
            mypromptbox[mouse.screen].widget,
            function (...) 
                text = awful.util.spawn( ... ) 
                naughty.notify({ text = tostring(text),
                timeout = 10 ,position='top_left', 
                title='BASH:'})
            end,
            awful.completion.shell,
            awful.util.getdir("cache") .. "/history")
        end,
    "Run in Terminal")

-- Prompt
-- awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
-- awful.key({ modkey }, "r",
--           function ()
--              local f_reader = io.popen( "dmenu_path | dmenu -b -nb '".. beautiful.bg_normal .."' -nf '".. beautiful.fg_normal .."' -sb '#955'")
--              local command = assert(f_reader:read('*a'))
--              f_reader:close()
--              if command == "" then return end
-- 
--              -- Check throught the clients if the class match the command
--              local lower_command=string.lower(command)
--              for k, c in pairs(client.get()) do
--                 local class=string.lower(c.class)
--                 if string.match(class, lower_command) then
--                    for i, v in ipairs(c:tags()) do
--                       awful.tag.viewonly(v)
--                       c:raise()
--                       c.minimized = false
--                       return
--                    end
--                 end
--              end
--              awful.util.spawn(command)
--           end),
-- 
)
--}}}
clientkeys = awful.util.table.join( --{{{
    keydoc.group("Clients"),
    awful.key({ modkey,           }, "x",      function (c) c:kill()            end, "Kill Client"),
    awful.key({ "Mod1",           }, "F4",     function (c) c:kill()            end, "Kill Client"),
    awful.key({ modkey,           }, "q",      function (c) c.minimized = true  end, "Minimize Client"),
    awful.key({ modkey,           }, "`",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, "Minimize Client"),
    awful.key({ modkey,           }, "t",
        function (c)
            awful.titlebar.add(c)
        end, "Titlebar of Client"),
    awful.key({ modkey,     "Shift"      }, "t",
        function (c)
            awful.titlebar.remove(c)
        end, "Titlebar of Client"),

    awful.key({ modkey,           }, "f",      awful.client.floating.toggle                     ),
    awful.key({ modkey,           }, "Return", function (c) c:swap(awful.client.getmaster())   end, "Get Master"),
    awful.key({ modkey,           }, "KP_Enter", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "d",      function (c) c:redraw()                         end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop              end),
    awful.key({ modkey, "Control" }, "space",  function (c) c.fullscreen = not c.fullscreen    end, "Toggle Fullscreen"),
    awful.key({ modkey,           }, "space",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end, "Fullscreen")
)
--}}}
-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local screen = mouse.screen
                if tags[screen][i] then
                    awful.tag.viewonly(tags[screen][i])
                end
            end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = mouse.screen
                if tags[screen][i] then
                    awful.tag.viewtoggle(tags[screen][i])
                end
            end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus and tags[client.focus.screen][i] then
                    awful.client.movetotag(tags[client.focus.screen][i])
                end
            end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus and tags[client.focus.screen][i] then
                    awful.client.toggletag(tags[client.focus.screen][i])
                end
            end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, 
        function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false
                     } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { instance = "plugin-container" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { instance = "screenkey" },
      properties = { floating = true, x=100, y=800, width=900,height=80 } },
    { rule = { class = "goldendict" },
      properties = { floating = true } },
    { rule = { class = "cairo-dock" },
      properties = { floating = true } },
    { rule = { instance = "cairo-dock" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", 
    function (c, startup)
        -- Add a titlebar
        -- awful.titlebar.add(c, { modkey = modkey })

        -- Enable sloppy focus
        c:connect_signal("mouse::enter", 
            function(c)
                if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                    and awful.client.focus.filter(c) then
                    client.focus = c
                end
            end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position 
            and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.connect_signal("focus", 
    function(c)
        c.border_color = beautiful.border_focus
        c.opacity = 1
    end)
client.connect_signal("unfocus", 
    function(c)
        c.border_color = beautiful.border_normal
        c.opacity = transparency
    end)
-- }}}

-- {{{ autosart
background_timers = {}                                                             
                                                                                  
function run_background(cmd,funtocall) --{{{
   local r = io.popen("mktemp")                                                   
   local logfile = r:read("*line")                                                
   r:close()                                                                      
                                                                                  
   cmdstr = cmd .. " &> " .. logfile .. " & "                                     
   local cmdf = io.popen(cmdstr)                                                  
   cmdf:close()                                                                   
   background_timers[cmd] = {                                                     
       file  = logfile,                                                           
       timer = timer{timeout=1}                                                   
   }                                                                              
   background_timers[cmd].timer:connect_signal("timeout",function()                   
       local cmdf = io.popen("pgrep -f '" .. cmd .. "'")                          
       local s = cmdf:read("*all")                                                
       cmdf:close()                                                               
       if (s=="") then                                                            
           background_timers[cmd].timer:stop()                                    
           local lf = io.open(background_timers[cmd].file)                        
           funtocall(lf:read("*all"))                                             
           lf:close()
           io.popen("rm " .. background_timers[cmd].file)                                                            
       end                                                                        
   end)                                                                           
   background_timers[cmd].timer:start()                                           
end --}}}
function run_once(cmd) --{{{
    findme = cmd
    firstspace = cmd:find(" ")
    if firstspace then
        findme = cmd:sub(0, firstspace-1)
    end
    exes("pgrep -u $USER -x " .. findme ..
        " > /dev/null || (" .. cmd .. ")")
end --}}}
do
    local cmds = conf.STARTUP_PROGRAM

    for _,prg in pairs(cmds) do
        naughty.notify({text=prg})
        run_once(prg)
    end
end
-- }}}

exes(conf.WALLPAPER_CMD)
