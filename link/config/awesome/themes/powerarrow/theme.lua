s_blue = "#268bd2"

--unused colors
green = "#7fb219"
cyan  = "#7f4de6"
red   = "#e04613"
lgrey = "#d2d2d2"

lblue = "#6c9eab"
dblue = "#00ccff"
dgrey = "#313131"
f_black = "#262626"
black = "#1c1c1c"
f_white = "#ffffd7"
white = "#aaaaaa"

acc1 = "#777e76"
acc2 = "#cb4b16"
acc3 = "#859000"
acc4 = "#dc322f"
acc5 = "#6c71c4"
acc6 = "#2aa198"

theme = {}

theme.wallpaper_cmd = { "awsetbg -t ".. themes_dir .."/powerarrow/wallpapers/w.png" }

theme.acc1 = acc1
theme.acc2 = acc2
theme.acc3 = acc3
theme.acc4 = acc4
theme.acc5 = acc5
theme.acc6 = acc6

theme.dgrey = dgrey
theme.black = black

theme.font                                  = "Consolas 9"
theme.fg_normal                             =  white
theme.fg_focus                              =  f_white
-- theme.fg_urgent                             = "#CC9393"
theme.bg_normal                             =  black
theme.bg_systray                             = red
theme.bg_focus                              =  f_black
--theme.bg_urgent                             = "#3F3F3F"
theme.border_width                          = "0"
theme.border_normal                         = black
theme.border_focus                          = s_blue
-- theme.border_marked                         = "#CC9393"
theme.titlebar_bg_focus                     = black
theme.titlebar_bg_normal                    = s_blue
theme.taglist_bg_focus                      = s_blue
theme.taglist_fg_focus                      = f_white
theme.tasklist_bg_focus                     = s_blue
theme.tasklist_fg_focus                     = f_white
theme.textbox_widget_as_label_font_color    = white 
theme.textbox_widget_margin_top             = 1
theme.text_font_color_1                     = green
theme.text_font_color_2                     = dblue
theme.text_font_color_3                     = white
theme.notify_font_color_1                   = green
theme.notify_font_color_2                   = dblue
theme.notify_font_color_3                   = black
theme.notify_font_color_4                   = white
theme.notify_font                           = "Consolas 9"
theme.notify_fg                             = theme.fg_normal
theme.notify_bg                             = theme.bg_normal
theme.notify_border                         = theme.border_focus
theme.awful_widget_bckgrd_color             = dgrey
theme.awful_widget_border_color             = dgrey
theme.awful_widget_color                    = dblue
theme.awful_widget_gradien_color_1          = orange
theme.awful_widget_gradien_color_2          = orange
theme.awful_widget_gradien_color_3          = orange
theme.awful_widget_height                   = 14
theme.awful_widget_margin_top               = 2

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
-- theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- theme.fg_widget        = "#AECF96"
-- theme.fg_center_widget = "#88A175"
-- theme.fg_end_widget    = "#FF5656"
-- theme.bg_widget        = "#494B4F"
-- theme.border_widget    = "#3F3F3F"

theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]

-- theme.menu_bg_normal    = ""
-- theme.menu_bg_focus     = ""
-- theme.menu_fg_normal    = ""
-- theme.menu_fg_focus     = ""
-- theme.menu_border_color = ""
-- theme.menu_border_width = ""
theme.menu_height       = "16"
theme.menu_width        = "140"

--{{--- Theme icons ------------------------------------------------------------------------------------------

theme.awesome_icon                              = themes_dir .. "/powerarrow/icons/powerarrow/awesome-icon.png"
theme.clear_icon                                = themes_dir .. "/powerarrow/icons/powerarrow/clear.png"
theme.menu_icon                                = themes_dir .. "/powerarrow/icons/powerarrow/menu.png"
-- theme.clear_icon                                = themes_dir .. "/powerarrow/icons/powerarrow/llauncher.png"
theme.menu_submenu_icon                         = themes_dir .. "/powerarrow/icons/powerarrow/submenu.png"
theme.tasklist_floating_icon                    = themes_dir .. "/powerarrow/icons/powerarrow/floatingm.png"
theme.titlebar_close_button_focus               = themes_dir .. "/powerarrow/icons/powerarrow/close_focus.png"
theme.titlebar_close_button_normal              = themes_dir .. "/powerarrow/icons/powerarrow/close_normal.png"
theme.titlebar_ontop_button_focus_active        = themes_dir .. "/powerarrow/icons/powerarrow/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = themes_dir .. "/powerarrow/icons/powerarrow/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = themes_dir .. "/powerarrow/icons/powerarrow/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = themes_dir .. "/powerarrow/icons/powerarrow/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = themes_dir .. "/powerarrow/icons/powerarrow/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = themes_dir .. "/powerarrow/icons/powerarrow/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = themes_dir .. "/powerarrow/icons/powerarrow/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = themes_dir .. "/powerarrow/icons/powerarrow/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = themes_dir .. "/powerarrow/icons/powerarrow/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = themes_dir .. "/powerarrow/icons/powerarrow/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = themes_dir .. "/powerarrow/icons/powerarrow/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = themes_dir .. "/powerarrow/icons/powerarrow/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = themes_dir .. "/powerarrow/icons/powerarrow/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = themes_dir .. "/powerarrow/icons/powerarrow/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themes_dir .. "/powerarrow/icons/powerarrow/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_dir .. "/powerarrow/icons/powerarrow/maximized_normal_inactive.png"
theme.taglist_squares_sel                       = themes_dir .. "/powerarrow/icons/powerarrow/square_sel.png"
theme.taglist_squares_unsel                     = themes_dir .. "/powerarrow/icons/powerarrow/square_unsel.png"
theme.layout_floating                           = themes_dir .. "/powerarrow/icons/powerarrow/floating.png"
theme.layout_tile                               = themes_dir .. "/powerarrow/icons/powerarrow/tile.png"
theme.layout_desktile                               = themes_dir .. "/powerarrow/icons/powerarrow/tile.png"
theme.layout_tileleft                           = themes_dir .. "/powerarrow/icons/powerarrow/tileleft.png"
theme.layout_tilebottom                         = themes_dir .. "/powerarrow/icons/powerarrow/tilebottom.png"
theme.layout_tiletop                            = themes_dir .. "/powerarrow/icons/powerarrow/tiletop.png"
theme.layout_max                                = themes_dir .. "/powerarrow/icons/powerarrow/max.png"
theme.layout_spiral                                = themes_dir .. "/powerarrow/icons/powerarrow/spiral.png"
theme.layout_dwindle                                = themes_dir .. "/powerarrow/icons/powerarrow/dwindle.png"
theme.layout_magnifier                                = themes_dir .. "/powerarrow/icons/powerarrow/magnifier.png"
theme.layout_fairh                                = themes_dir .. "/powerarrow/icons/powerarrow/fairh.png"
theme.layout_fairv                                = themes_dir .. "/powerarrow/icons/powerarrow/fairv.png"
theme.widget_battery                            = themes_dir .. "/powerarrow/icons/powerarrow/battery.png"
theme.widget_mem                                = themes_dir .. "/powerarrow/icons/powerarrow/mem.png"
theme.widget_cpu                                = themes_dir .. "/powerarrow/icons/powerarrow/cpu.png"
theme.widget_temp                               = themes_dir .. "/powerarrow/icons/powerarrow/temp.png"
theme.widget_net                                = themes_dir .. "/powerarrow/icons/powerarrow/net.png"
theme.widget_hdd                                = themes_dir .. "/powerarrow/icons/powerarrow/hdd.png"
theme.widget_music                              = themes_dir .. "/powerarrow/icons/powerarrow/music.png"
theme.widget_task                               = themes_dir .. "/powerarrow/icons/powerarrow/task.png"
theme.widget_mail                               = themes_dir .. "/powerarrow/icons/powerarrow/mail.png"
theme.widget_cal                                = themes_dir ..  "/powerarrow/icons/powerarrow/cal.png"
theme.widget_browser                            = themes_dir ..  "/powerarrow/icons/powerarrow/html.png"
theme.widget_terminal                            = themes_dir ..  "/powerarrow/icons/powerarrow/window.png"
theme.widget_editor                            = themes_dir ..  "/powerarrow/icons/powerarrow/edit.png"
theme.widget_chat                            = themes_dir ..  "/powerarrow/icons/powerarrow/chat.png"
theme.widget_home                            = themes_dir ..  "/powerarrow/icons/powerarrow/home.png"
theme.arr1                                      = themes_dir .. "/powerarrow/icons/powerarrow/arr1.png"
theme.arr2                                      = themes_dir .. "/powerarrow/icons/powerarrow/arr2.png"
theme.arr3                                      = themes_dir .. "/powerarrow/icons/powerarrow/arr3.png"
theme.arr4                                      = themes_dir .. "/powerarrow/icons/powerarrow/arr4.png"
theme.arr5                                      = themes_dir .. "/powerarrow/icons/powerarrow/arr5.png"
theme.arr6                                      = themes_dir .. "/powerarrow/icons/powerarrow/arr6.png"
theme.arr7                                      = themes_dir .. "/powerarrow/icons/powerarrow/arr7.png"
theme.arr8                                      = themes_dir .. "/powerarrow/icons/powerarrow/arr8.png"
theme.arr8b                                      = themes_dir .. "/powerarrow/icons/powerarrow/arr8b.png"
theme.arr9                                      = themes_dir .. "/powerarrow/icons/powerarrow/arr9.png"
theme.arr0                                      = themes_dir .. "/powerarrow/icons/powerarrow/arr0.png"

theme.reboot                                      = themes_dir .. "/powerarrow/icons/reboot.png"
theme.shutdown                                      = themes_dir .. "/powerarrow/icons/shutdown.png"
theme.accept                                      = themes_dir .. "/powerarrow/icons/accept.png"
theme.cancel                                      = themes_dir .. "/powerarrow/icons/cancel.png"

--{{--- User icons ------------------------------------------------------------------------------------------
--
local i = 0
local directory = themes_dir .. "/powerarrow/icons/apps"
for filename in io.popen('ls -a "'..directory..'"'):lines() do
    f = string.gsub(string.lower(filename), "-", "_")
    if string.sub(f, -string.len(".png")) == ".png" then
        i = i + 1
        name = "app_"..string.sub(f, 1, -5)
        theme[name] = directory .. "/" .. filename
    end
end


return theme

