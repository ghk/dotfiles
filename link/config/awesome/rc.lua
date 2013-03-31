require("awful")
require("awful.rules")
require("awful.autofocus")
require("awful.client")
require("beautiful")
require("naughty")
require("vicious")
require('couth.couth')
require('couth.alsa')
require("blingbling")
require("ejos.tile")
require "minigtk"
require "keybinder"

os.execute("fishd")

local capi = { key = key }

--{{---| functions |--------------------------------------------------------

super_on = false
function toggle_on_super()
    if super_on then
        return
    end
    super_on = true
    for s=1, #mytoggable do
        for i=1, #mytoggable[s] do
            mytoggable[s][i].visible = false
        end
    end
    for s = 1, screen.count() do
        for i=1, #tags[s] do
            tags[s][i].name = i .. ":" .. tags.names[i]
        end
    end
end

function toggle_off_super()
    if not super_on then
        return
    end
    super_on = false
    for s=1, #mytoggable do
        for i=1, #mytoggable[s] do
            mytoggable[s][i].visible = true
        end
    end
    for s = 1, screen.count() do
        for i=1, #tags[s] do
            tags[s][i].name = i
        end
    end
end


function run_once(prg)
    awful.util.spawn_with_shell("pgrep -x " .. prg .. "; or " .. prg .. " &") 
end

function run_once_differ(search, prg)
    awful.util.spawn_with_shell("pgrep -x " .. search .. "; or " .. prg .. " &") 
end

--{{---| run_once with args |----------------------------------------------

function run_oncewa(prg) 
    if not prg then do return nil end end
    awful.util.spawn_with_shell('ps ux | grep -v grep | grep -F ' .. prg .. '; or ' .. prg .. ' &') 
end


--{{---| Java GUI's fix |--------------------------------------------------

awful.util.spawn_with_shell("wmname LG3D")


--{{---| Error handling |--------------------------------------------------

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                   title = "Oops, there were errors during startup!",
                   text = awesome.startup_errors })
end
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        if in_error then return end
        in_error = true
        naughty.notify({ preset = naughty.config.presets.critical,
                      title = "Oops, an error happened!",
                      text = err })
        in_error = false
    end)
end

--{{---| Theme |-----------------------------------------------------------

config_dir = ("/home/ghk/.config/awesome/")
themes_dir = (config_dir .. "/themes")
beautiful.init(themes_dir .. "/powerarrow/theme.lua")

--{{---| Variables |-------------------------------------------------------

modkey        = "Mod4"
terminal      = "urxvt "
terminalr     = "sudo urxvt --default-working-directory=/root/"
rttmux        = "sudo terminal --geometry=220x59+20+36 --default-working-directory=/root/ -x tmux -2"
ttmux         = "urxvt -T tmux -g 221x60+20+36 -e tmux -2"
lilyterm      = "urxvt -g 221x60+20+36"
musicplr      = "urxvt -T Music -g 130x34-320+16 -e ncmpcpp"
iptraf        = "urxvt -T 'IP traffic monitor' -g 180x54-20+34 -e sudo iptraf-ng -i all"
mailmutt      = "urxvt -T 'Mutt' -g 140x44-20+34 -e mutt"
chat          = "TERM=screen-256color lilyterm -T 'Chat' -g 228x62+0+16 -x ~/.gem/ruby/1.9.1/bin/mux start chat"
editor        = os.getenv("EDITOR") or "vim"
editor_cmd    = terminal .. " -e " .. editor
browser       = "firefox"
fm            = "sunflower"

--{{---| Couth Alsa volume applet |----------------------------------------

couth.CONFIG.ALSA_CONTROLS = { 'Master', 'PCM' }

--{{---| Table of layouts |------------------------------------------------

layouts =
{
    awful.layout.suit.floating,
    ejos.tile,
    awful.layout.suit.tile,
    awful.layout.suit.fair,
}

--{{---| Naughty theme |---------------------------------------------------

naughty.config.default_preset.font         = beautiful.notify_font
naughty.config.default_preset.fg           = beautiful.notify_fg
naughty.config.default_preset.bg           = beautiful.notify_bg
naughty.config.presets.normal.border_color = beautiful.notify_border
naughty.config.presets.normal.opacity      = 0.9
naughty.config.presets.low.opacity         = 0.8
naughty.config.presets.critical.opacity    = 0.9

--{{---| Tags |------------------------------------------------------------

tags = {
    names  = { "desk", "term", "mail", "im", "", "", "", "", "media" },
    layouts = { layouts[2], layouts[3], layouts[2], 
    layouts[3], layouts[1], layouts[3], layouts[3], layouts[3], layouts[1]},
}   

for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layouts)
    for i=1, #tags.names do
        tags[s][i].name = i
        if(awful.layout.getname(tags.layouts[i])) == "desktile" then
            awful.tag.incmwfact(0.15, tags[s][i])
        elseif(awful.layout.getname(tags.layouts[i])) == "tile" then
            awful.tag.incmwfact(0.15, tags[s][i])
        end
    end
end


--{{---| Menu |------------------------------------------------------------

myawesomemenu = {
    {"edit config",           "urxvt -e vim ~/.config/awesome/rc.lua"},
    {"edit theme",            "urxvt -e vim ~/.config/awesome/themes/powerarrow/theme.lua"},
    {"suspend",             "sudo pm-suspend"},
    {"restart",               awesome.restart },
    {"reboot",                "sudo reboot"},
    {"poweroff",              "sudo poweroff"},
    {"quit",                  awesome.quit }
}


myedumenu = {
    --{" Anki",                 "anki", beautiful.anki_icon},
    -- {" Celestia",             "celestia", beautiful.celestia_icon},
    {" Geogebra",             "geogebra", beautiful.app_geogebra},
    --{" Free42dec",            "/home/rom/Tools/Free42Linux/gtk/free42dec", beautiful.free42_icon},
    --{" GoldenDict",           "goldendict", beautiful.goldendict_icon},
    {" Stellarium",           "stellarium", beautiful.app_stellarium},
    --{" Vym",                  "vym", beautiful.vym_icon},
    {" XMind",                "xmind", beautiful.app_xmind},
    {" Google Earth",                "google-earth", beautiful.app_google_earth},
}

mydevmenu = {
    {" Eclipse ADT",              "eclipse-adt", beautiful.app_eclipse},
    {" ADB Shell",  "android", beautiful.app_android},
    {" GHex",                 "ghex", beautiful.app_ghex},	
    {" pycharm",         "pycharm", beautiful.app_pycharm},
    {" phpstorm",             "phpstorm", beautiful.app_webide},
    {" Meld",                 "meld", beautiful.app_meld},
    {" pgAdmin",              "pgadmin3", beautiful.app_pgadmin3},
    --{" Qt Creator",           "qtcreator", beautiful.app},
    --{" SublimeText",          "sublime_text", beautiful.sublime_icon},
    {" MonoDevelop",          "monodevelop %F", beautiful.app_monodevelop}
}

mygraphicsmenu = {
    {" Character Map",        "gucharmap", beautiful.app_gucharmap},
    {" Fonty Python",         "fontypython", beautiful.app_fontypython},
    {" gcolor2 - Color Picker",              "gcolor2", beautiful.app_gcolor2},
    {" Gimp",                 "gimp", beautiful.app_gimp},
    {" Inkscape",             "inkscape", beautiful.app_inscape},
    {" Screengrab",           "screengrab", beautiful.app_screengrab},
    {" Pencil",           "pencil", beautiful.app_pencil},
    --{" Xmag",                 "xmag", beautiful.xmag_icon},
    --{" XnView",               "/home/rom/Tools/XnView/xnview.sh", beautiful.xnview_icon}
}

mymultimediamenu = {
    {" Banshee",            "banshee", beautiful.app_banshee},
    {" MPlayer",            "gnome-mplayer", beautiful.app_gnome_mplayer},
    {" Sound Recorder",            "gnome-sound-recorder", beautiful.app_gnome_sound_recorder},
    --{" DeadBeef",             "deadbeef", beautiful.deadbeef_icon},
    --{" UMPlayer",             "umplayer", beautiful.umplayer_icon},
    {" VLC",                  "vlc", beautiful.app_vlc},
    {" Totem",                  "totem", beautiful.app_totem},
}

myofficemenu = {
    {" evince",       "evince", beautiful.app_evince},
    {" DjView",               "djview", beautiful.app_djview},
    --{" KChmViewer",           "kchmviewer", beautiful.kchmviewer_icon},
    --{" Leafpad",              "leafpad", beautiful.leafpad_icon},
    {" Microsoft Excel",     "excel", beautiful.app_libreoffice_calc},
    {" Microsoft Word",     "word", beautiful.app_libreoffice_draw},
    {" Microsoft PowerPoint",  "powerpoint", beautiful.app_libreoffice_impress},
    {" Microsoft Onenote",     "onenote", beautiful.app_libreoffice_math},	
    --{" ScanTailor",           "scantailor", beautiful.scantailor_icon},
    --{" Sigil",                "sigil", beautiful.sigil_icon}, 
    {" TeXworks",             "texworks", beautiful.texworks_icon}
}

mywebmenu = {
    {" Chromium",             "chromium-browser", beautiful.app_chromium},
    {" Droppox",              "dropbox", beautiful.app_dropbox},
    {" Filezilla",            "filezilla", beautiful.app_filezilla},
    {" Firefox",              "firefox", beautiful.app_firefox},
    {" Pidgin",                "pidgin", beautiful.app_pidgin}, 
    --{" Luakit",               "luakit", beautiful.luakit_icon},
    {" Opera",                "opera", beautiful.app_opera},
    {" Qbittorrent",          "qbittorrent", beautiful.app_qbittorrent},
    {" Skype",                "skype", beautiful.app_skype},
    {" Thunderbird",          "thunderbird", beautiful.app_thunderbird},
    {" XChat",          "xchat", beautiful.app_xchat},
    --{" Weechat",              "lilyterm -x weechat-curses", beautiful.weechat_icon}
}

mysettingsmenu = {
    {" CUPS Settings",        "sudo system-config-printer", beautiful.app_cups},
    {" Sypnatic",     "gksu sypnatic", beautiful.app_synaptic},    
    {" APT Settings",     "gksudo software-properties-gtk", beautiful.app_software_properties},    
    {" MDM Settings",     "gksudo mdmsetup", beautiful.app_mdmsetup},    
    {" Grub Settings",     "gksudo startupmanager", beautiful.app_startupmanager},    
    {" rc Settings",     "gksudo bum", beautiful.app_bum},    
    {" Network Connection",     "gksudo nm-connection-editor", beautiful.app_network_connection},    
    {" WICD",                 "gksudo wicd-gtk", beautiful.app_wicd},
    {" Monitor Settings",     "arandr", beautiful.app_arandr},    
    {" Appearance",     "lxappearance", beautiful.app_lxappearance},    
    {" VNC Server Preferences",     "vino-preferences", beautiful.vino_preferences},    
}

mytoolsmenu = {
    {" Seahorse - PGP",              "seahorse", beautiful.app_seahorse},
    {" Gparted",              "gksudo gparted", beautiful.app_gparted},
    {" Keepass X",            "keepassx %f", beautiful.app_keepassx},
    {" Quick Synergy",            "quicksynergy", beautiful.app_quicksynergy},
    {" xarchiver",               "xarchiver", beautiful.app_xarchiver},
    {" TeamViewer",           "/home/rom/Tools/teamviewer7/teamviewer", beautiful.app_teamviewer},
    {" VirtualBox",           "VirtualBox", beautiful.app_virtualbox},
    {" HardInfo",             'hardinfo', beautiful.app_windows}, --todo icon
    {" Power Statistics",             'gnome-power-statistics', beautiful.app_gnome_power_statistics},
    {" System Monitor",             'gnome-system-monitor', beautiful.app_gnome_system_monitor},
    -- {" Vmware Workstation",   "vmware", beautiful.vmware_icon},
    --{" UNetbootin",           "sudo unetbootin", beautiful.app_windows},
    {" Wireshark",           "wireshark %f", beautiful.app_windows}, --todo icon
    {" ImageWriter",               "imagewriter", beautiful.app_imagewriter},
    {" Xfburn",               "xfburn", beautiful.app_xfburn},
}

mymainmenu = awful.menu(
    { items = { 
        { " @wesome",             myawesomemenu, beautiful.awesome_icon },
        {" development",          mydevmenu, beautiful.app_development},
        {" education",            myedumenu, beautiful.app_education},
        {" graphics",             mygraphicsmenu, beautiful.app_graphics},
        {" multimedia",           mymultimediamenu, beautiful.app_multimedia},	    
        {" office",               myofficemenu, beautiful.app_office},
        {" tools",                mytoolsmenu, beautiful.app_tools},
        {" net",                  mywebmenu, beautiful.app_net},
        {" settings",             mysettingsmenu, beautiful.app_settings},
        {" calc",                 "/usr/bin/gcalctool", beautiful.app_calculator},
        {" htop",                 terminal .. " -x htop", beautiful.app_htop},
        --{" sound",                "qasmixer", beautiful.wmsmixer_icon},
        {" file manager",         "sunflower", beautiful.app_file_manager},
        {" root terminal",        "sudo " .. terminal, beautiful.app_terminal},
        {" terminal",             terminal, beautiful.app_terminal} 
    }
})

mylauncher = awful.widget.launcher({ image = image(beautiful.menu_icon), menu = mymainmenu })
--{{---| Wibox |-----------------------------------------------------------

mysystray = widget({ type = "systray", bg_normal="#00FF0000" })
mysystray.bg = "#FF0000"
mywibox = {}
mytoggable= {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({ }, 1, awful.tag.viewonly),
    awful.button({ modkey }, 1, awful.client.movetotag),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, awful.client.toggletag),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
    awful.button({ }, 1, function (c)
                 if c == client.focus then
                     c.minimized = true
                 else
                     if not c:isvisible() then
                         awful.tag.viewonly(c:tags()[1])
                     end
                     client.focus = c
                     c:raise()
                 end
             end),
awful.button({ }, 3, function ()
             if instance then
                 instance:hide()
                 instance = nil
             else
                 instance = awful.menu.clients({ width=450 })
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



for s = 1, screen.count() do
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright }) mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s].width = "14px"
    mylayoutbox[s]:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
        awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
    mytasklist[s] = awful.widget.tasklist(function(c)
                                          return awful.widget.tasklist.label.currenttags(c, s)
                                      end, mytasklist.buttons)


    --{{---| MEM widget |--------------------------------------------------

    memwidget = widget({ type = "textbox" })
    vicious.register(memwidget, vicious.widgets.mem, '$2MB')
    memwidget.bg = "#313131"
    memicon = widget ({type = "imagebox" })
    memicon.image = image(beautiful.widget_mem)

    --{{---| CPU / sensors widget |----------------------------------------

    cpuwidget = widget({ type = "textbox" })
    vicious.register(cpuwidget, vicious.widgets.cpu,' $2%  $3%' )
    cpuwidget.bg = "#313131"
    cpuicon = widget ({type = "imagebox" })
    cpuicon.image = image(beautiful.widget_cpu)
    sensors = widget({ type = "textbox" })
    vicious.register(sensors, vicious.widgets.sensors)
    tempicon = widget ({type = "imagebox" })
    tempicon.image = image(beautiful.widget_temp)
    blingbling.popups.htop(cpuwidget,
                           { title_color = beautiful.notify_font_color_1, 
                           user_color = beautiful.notify_font_color_2, 
                           root_color = beautiful.notify_font_color_3, 
                           terminal   = "terminal --geometry=130x56-10+26"})

    --{{---| FS's widget / udisks-glue menu |------------------------------

    udisks_glue = blingbling.udisks_glue.new(beautiful.widget_hdd)
    udisks_glue:set_mount_icon(beautiful.accept)
    udisks_glue:set_umount_icon(beautiful.cancel)
    udisks_glue:set_detach_icon(beautiful.cancel)
    udisks_glue:set_Usb_icon(beautiful.usb)
    udisks_glue:set_Cdrom_icon(beautiful.cdrom)

    --{{---| Battery widget |----------------------------------------------

    baticon = widget ({type = "imagebox" })
    baticon.image = image(beautiful.widget_battery)
    batwidget = widget({ type = "textbox" })
    vicious.register( batwidget, vicious.widgets.bat, '<span background="'..beautiful.black..'"> $1$2% </span>', 1, "BAT0" )
    --{{---| Net widget |--------------------------------------------------


    --{{---| Calendar widget |---------------------------------------------
    my_cal = awful.widget.textclock({ align = "right"}, '%a, %d %b %Y,%H:%M:%S')
    my_cal.bg = "#313131"

    -- Calendar widget to attach to the textclock
    require('calendar2')
    calendar2.addCalendarToWidget(my_cal)


    --{{---| Separators widgets |------------------------------------------

    spr = widget({ type = "textbox" })
    spr.text = ' '
    sprd = widget({ type = "textbox" })
    sprd.text = '<span background="#313131" > </span>'
    sprd2 = widget({ type = "textbox" })
    sprd2.text = '<span background="#313131" > </span>'
    spr3f = widget({ type = "textbox" })
    spr3f.text = '<span background="#1c1c1c" > </span>'
    arr1 = widget ({type = "imagebox" })
    arr1.image = image(beautiful.arr1)
    arr2 = widget ({type = "imagebox" })
    arr2.image = image(beautiful.arr2)
    arr3 = widget ({type = "imagebox" })
    arr3.image = image(beautiful.arr3)
    arr4 = widget ({type = "imagebox" })
    arr4.image = image(beautiful.arr4)
    arr5 = widget ({type = "imagebox" })
    arr5.image = image(beautiful.arr5)
    arr6 = widget ({type = "imagebox" })
    arr6.image = image(beautiful.arr6)
    arr7 = widget ({type = "imagebox" })
    arr7.image = image(beautiful.arr7)
    arr8 = widget ({type = "imagebox" })
    arr8.image = image(beautiful.arr8)
    arr8b = widget ({type = "imagebox" })
    arr8b.image = image(beautiful.arr8b)
    arr9 = widget ({type = "imagebox" })
    arr9.image = image(beautiful.arr9)
    arr0 = widget ({type = "imagebox" })
    arr0.image = image(beautiful.arr0)
    arr9b = widget ({type = "imagebox" })
    arr9b.image = image(beautiful.arr9)


    --{{---| Panel |-------------------------------------------------------

    mywibox[s] = awful.wibox({ position = "top", screen = s})
    mywibox[s].widgets = {
        {
            -- top row left
            mylauncher, 
            mytaglist[s], 
            spr,
            mypromptbox[s], 
            layout = awful.widget.layout.horizontal.leftright 
        },
        -- top row right
        mylayoutbox[s],
        my_cal,
        arr9,
        batwidget,
        baticon,
        arr0, 
        udisks_glue.widget,
        memwidget,
        memicon,
        arr9,
        sensors,
        tempicon,
        arr0,
        cpuwidget,
        cpuicon,
        arr9b,
        s == 1 and mysystray,
        spr,
        mytasklist[s], 
        layout = awful.widget.layout.horizontal.rightleft 
    }
    mytoggable[s]= {
        my_cal,
        arr9,
        batwidget,
        baticon,
        arr0, 
        udisks_glue.widget,
        memwidget,
        memicon,
        arr9,
        sensors,
        tempicon,
        arr0,
        cpuwidget,
        cpuicon,
    }
    awful.screen.padding(screen[s],{top = 4})

end


--{{---| Mouse bindings |--------------------------------------------------

root.buttons(awful.util.table.join(awful.button({ }, 3, function () mymainmenu:toggle() end)))

touchpad_on = false

--{{---| Key bindings |----------------------------------------------------

globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/Screenshots/ 2>/dev/null'") end),

    -- Movement

    awful.key({ modkey,           }, "j",
              function ()
                  awful.client.focus.bydirection("down")
                  if client.focus then client.focus:raise() end
              end),
    awful.key({ modkey,           }, "k",
              function ()
                  awful.client.focus.bydirection("up")
                  if client.focus then client.focus:raise() end
              end),
    awful.key({ modkey,           }, "h",
              function ()
                  awful.client.focus.bydirection("left")
                  if client.focus then client.focus:raise() end
              end),
    awful.key({ modkey,           }, "l",
              function ()
                  awful.client.focus.bydirection("right")
                  if client.focus then client.focus:raise() end
              end),
    awful.key({ modkey,           }, "o",
              function ()
                  awful.client.focus.byidx(1)
                  if client.focus then client.focus:raise() end
              end),
    awful.key({ modkey,           }, "i",
              function ()
                  awful.client.focus.byidx(-1)
                  if client.focus then client.focus:raise() end
              end),

    -- Swaps
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.bydirection("down")    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.bydirection("up")    end),
    awful.key({ modkey, "Shift"   }, "h", function () awful.client.swap.bydirection("left")    end),
    awful.key({ modkey, "Shift"   }, "l", function () awful.client.swap.bydirection("right")    end),
    awful.key({ modkey, "Shift"   }, "o", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "i", function () awful.client.swap.byidx( -1)    end),

    -- Screen Movement
    awful.key({ modkey, "Control" }, "h", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "l", function () awful.screen.focus_relative(-1) end),


    -- Resize
    awful.key({ modkey,           }, ".",        function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, ",",        function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",        function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",        function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",        function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",        function () awful.tag.incncol(-1)         end),

    --Other awesome
    awful.key({ modkey, "Control" }, "r",        awesome.restart),
    awful.key({ modkey, "Shift",     "Control"}, "r", awesome.quit),
    awful.key({ modkey, "Control" }, "n",        awful.client.restore),
    awful.key({ modkey,           }, "space",    function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space",    function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab", function () awful.client.focus.history.previous()
              if client.focus then client.focus:raise() end end),

    --Applications

    --{{---| Terminals, shells und multiplexors |--------------------------
    awful.key({ modkey,           }, "Return",   function () 
              if awful.layout.getname(awful.layout.get()) == "desktile" then
                  awful.util.spawn(terminal.." -name deskrxvt") 
              else
                  awful.util.spawn(terminal) 
              end
          end),                
    awful.key({ modkey },            "r",        function () awful.util.spawn_with_shell("gmrun") end),
    awful.key({ modkey },            "v",        function () awful.util.spawn_with_shell("gvim -geometry 92x58+710+24") end),    
    awful.key({ modkey },            "g",        function () awful.util.spawn_with_shell("gcolor2") end),
    awful.key({ modkey },            "Print",    function () awful.util.spawn_with_shell("screengrab") end),
    awful.key({ modkey, "Control"},  "Print",    function () awful.util.spawn_with_shell("screengrab --region") end),
    awful.key({ modkey, "Shift"},    "Print",    function () awful.util.spawn_with_shell("screengrab --active") end),
    awful.key({ modkey, "Control" }, "m",        function () awful.util.spawn_with_shell(musicplr) end),

    ---- Audio
    awful.key({ }, "XF86AudioPlay",              function () awful.util.spawn_with_shell("ncmpcpp toggle") end),
    awful.key({ }, "XF86AudioStop",              function () awful.util.spawn_with_shell("ncmpcpp stop") end),
    awful.key({ }, "XF86AudioLowerVolume",       function () couth.notifier:notify(couth.alsa:setVolume('Master','3dB-')) end),
    awful.key({ }, "XF86AudioRaiseVolume",       function () couth.notifier:notify(couth.alsa:setVolume('Master','3dB+')) end),
    awful.key({ }, "XF86AudioMute",              function () couth.notifier:notify(couth.alsa:setVolume('Master','toggle')) end),
    awful.key({ },"XF86AudioPrev",              function () awful.util.spawn_with_shell("qdbus org.bansheeproject.Banshee /org/bansheeproject/Banshee/PlaybackController org.bansheeproject.Banshee.PlaybackController.Previous false") end),
    awful.key({ },"XF86AudioNext",              function () awful.util.spawn_with_shell("qdbus org.bansheeproject.Banshee /org/bansheeproject/Banshee/PlaybackController org.bansheeproject.Banshee.PlaybackController.Next false") end),
    awful.key({ },            "XF86AudioPlay",        function () awful.util.spawn_with_shell("qdbus org.bansheeproject.Banshee /org/bansheeproject/Banshee/PlayerEngine org.bansheeproject.Banshee.PlayerEngine.TogglePlaying") end),


    -- Other misc
    --
    awful.key({ }, "XF86Calculator",             function () awful.util.spawn_with_shell("gcalctool") end),
    awful.key({ }, "XF86Sleep",                  function () awful.util.spawn_with_shell("sudo pm-hibernate") end),
    awful.key({ modkey,           }, "p",
              function ()
                if touchpad_on then
                    os.execute("synclient TouchpadOff=1");
                else
                    os.execute("synclient TouchpadOff=0");
                end
                touchpad_on = not touchpad_on

              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",        function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "c",        function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey }, "\\",   function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "p",        awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",        function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",        function (c) c.minimized = true end),
    awful.key({ modkey,           }, "m",        function (c) c.maximized_horizontal = not c.maximized_horizontal
              c.maximized_vertical   = not c.maximized_vertical end)
)

keynumber = 0
for s = 1, screen.count() do keynumber = math.min(9, math.max(#tags[s], keynumber)); end
for i = 1, keynumber do 
    globalkeys = awful.util.table.join(
        globalkeys,
        awful.key({ modkey }, "#" .. i + 9, function () local screen = mouse.screen
                  if tags[screen][i] then awful.tag.viewonly(tags[screen][i]) end end),
        awful.key({ modkey, "Control" }, "#" .. i + 9, function () local screen = mouse.screen
                  if tags[screen][i] then awful.tag.viewtoggle(tags[screen][i]) end end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function () if client.focus and 
                  tags[client.focus.screen][i] then awful.client.movetotag(tags[client.focus.screen][i]) end end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function () if client.focus and
              tags[client.focus.screen][i] then awful.client.toggletag(tags[client.focus.screen][i]) end end)) 
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey, "Shift" }, 1, awful.mouse.client.resize))

root.keys(globalkeys)

--{{---| Rules |-----------------------------------------------------------

awful.rules.rules = {
    { 
        rule = { },
        properties = { 
            size_hints_honor = false,
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = true,
            keys = clientkeys,
            maximized_vertical   = false,
            maximized_horizontal = false,
            buttons = clientbuttons 
        } 
    },
    { 
        rule = { class = "goldendict" },
        properties = { floating = true } 
    },
    { 
        rule = { class = "audacious" },
        properties = { floating = true } 
    },
    { 
        rule = { class = "xwinmosaic" },
        properties = { floating = true } 
    },
    { 
        rule = { class = "gimp" },
        properties = { floating = true } 
    },
    { 
        rule = { class = "Thunderbird" },
        properties = { tag=tags[1][3] } 
    },
    { 
        rule = { class = "Pidgin" },
        properties = { tag=tags[1][4] },
        callback = function(c)
            if c.role ~= "conversation" then
                awful.client.setslave(c)
            end
        end
    },
    { 
        rule = { class = "Skype" },
        properties = { tag=tags[1][4] }, 
        callback = function(c)
            if c.role ~= "ConversationsWindow" then
                awful.client.setslave(c)
            end
        end
    },
    { 
        rule = { class = "banshee" },
        properties = { tag=tags[1][9] } 
    },
    { 
        rule = { instance = "trello.com" },
        properties = { tag=tags[1][3] },
        callback = awful.client.setslave,
    },
    { 
        rule = { instance = "deskrxvt"},
        callback = awful.client.setslave,
    },
    { 
        rule = { class = "URxvt"},
        properties = { 
            size_hints_honor = true,
        },
    },
    { 
        rule = { class = "Firefox", role="Manager" },
        callback = awful.client.setslave,
    },
    { 
        rule = { class = "Firefox", role="Organizer" },
        properties = { floating=true },
        callback = awful.client.setslave,
    },
    { 
        rule = { class = "Firefox", role="Preferences" },
        properties = { floating=true },
        callback = awful.client.setslave,
    },
}

--{{---| Signals |---------------------------------------------------------
    
client.add_signal("manage", function (c, startup)

    if not startup then

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

minigtk.init()

function binder_callback(keystring, xte_seq)
    if xte_seq ~= nil then
        xte_cmd = "xdotool key --clearmodifiers "..xte_seq
        awful.util.spawn_with_shell(xte_cmd)
    end
end

skype_binded = false


client.add_signal("focus", function(c) 
  c.border_color = beautiful.border_focus 
  if c.class == "Skype" then
      if not skype_binded then
        keybinder.bind("<Control>W", binder_callback, nil)
        skype_binded = true
       end
  else
      if skype_binded then
        keybinder.unbind("<Control>W")
        skype_binded = false
      end
  end
end)

client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

--{{--| Autostart |--------------------------------------------------------

run_once("compton")
run_once("focused")
run_once_differ("conky", 'conky -c "/home/ghk/.config/conky/conkyrc"')

run_once_differ("nm-applet", "dbus-launch nm-applet --sm-disable")
run_once_differ("evrouter", "evrouter /dev/input/event0 -c /home/ghk/.config/evrouter.conf")
os.execute("/home/ghk/.local/pyenv/bin/single.py -c /home/ghk/.local/bin/awesome-mod-hint &")

run_once("udisks-glue")
-- os.execute("sudo /etc/init.d/dcron start &")
--run_once("kbdd")
run_once("glipper")

run_oncewa("dropbox start")

--{{--|Gnome autostart

os.execute("setxkbmap -option terminate:ctrl_alt_bksp &")
os.execute("xmodmap ~/.config/xmodmaprc")
os.execute("synclient TouchpadOff=1")

