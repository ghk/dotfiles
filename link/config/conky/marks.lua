--==============================================================================
--                            multi_rings.lua
--
--  author  : SLK
--  version : v2011011601
--  license : Distributed under the terms of GNU GPL version 2 or later
--
--==============================================================================

require 'cairo'

--------------------------------------------------------------------------------
--                                                                    clock DATA
-- HOURS
clock_h = {
    {
    name='time',                   arg='%H',                    max_value=12,
    x=175,                           y=175,
    graph_radius=140,
    graph_thickness=3,
    graph_unit_angle=30,           graph_unit_thickness=5,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.0,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.0,
    txt_radius=100,
    txt_weight=1,                  txt_size=10.0,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.0,
    graduation_radius=68,
    graduation_thickness=5,        graduation_mark_thickness=2,
    graduation_unit_angle=30,
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.6,
    },
}

-------------------------------------------------------------------------------
--                                                                 rgb_to_r_g_b
-- converts color in hexa to decimal
--
function rgb_to_r_g_b(colour, alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

-------------------------------------------------------------------------------
--                                                            angle_to_position
-- convert degree to rad and rotate (0 degree is top/north)
--
function angle_to_position(start_angle, current_angle)
    local pos = current_angle + start_angle
    return ( ( pos * (2 * math.pi / 360) ) - (math.pi / 2) )
end

-------------------------------------------------------------------------------
--                                                              draw_clock_ring
-- displays clock
--
function draw_clock_ring(display, data)
    local max_value = data['max_value']
    local x, y = data['x'], data['y']
    local graph_radius = data['graph_radius']
    local graph_thickness, graph_unit_thickness = data['graph_thickness'], data['graph_unit_thickness']
    local graph_unit_angle = data['graph_unit_angle']
    local graph_bg_colour, graph_bg_alpha = data['graph_bg_colour'], data['graph_bg_alpha']
    local graph_fg_colour, graph_fg_alpha = data['graph_fg_colour'], data['graph_fg_alpha']


    -- graduations marks
    local graduation_radius = data['graduation_radius']
    local graduation_thickness, graduation_mark_thickness = data['graduation_thickness'], data['graduation_mark_thickness']
    local graduation_unit_angle = data['graduation_unit_angle']
    local graduation_fg_colour, graduation_fg_alpha = data['graduation_fg_colour'], data['graduation_fg_alpha']
    if graduation_radius > 0 and graduation_thickness > 0 and graduation_unit_angle > 0 then
        local nb_graduation = 360 / graduation_unit_angle
        local i = 1
        while i <= nb_graduation do
            cairo_set_line_width(display, graduation_thickness)
            cairo_arc(display, x, y, graduation_radius, (((graduation_unit_angle * i)-(graduation_mark_thickness/2))*(2*math.pi/360))-(math.pi/2),(((graduation_unit_angle * i)+(graduation_mark_thickness/2))*(2*math.pi/360))-(math.pi/2))

            if (i - math.floor(i/3)*3 == 0 )then
                cairo_set_source_rgba(display,rgb_to_r_g_b(0xaaaaaa,graduation_fg_alpha))
            else
                cairo_set_source_rgba(display,rgb_to_r_g_b(graduation_fg_colour,graduation_fg_alpha))
            end
            cairo_stroke(display)
            cairo_set_line_width(display, graph_thickness)
            i = i + 1
        end
    end

    -- text
end

-------------------------------------------------------------------------------
--                                                               go_clock_rings
-- loads data and displays clock
--
function go_clock_rings(display)
    for i in pairs(clock_h) do
        draw_clock_ring(display, clock_h[i])
    end
end

-------------------------------------------------------------------------------
--                                                               go_gauge_rings
-- loads data and displays gauges
--

-------------------------------------------------------------------------------
--                                                                         MAIN
--
function conky_main()
    if conky_window == nil then 
        return
    end

    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local display = cairo_create(cs)
    
    local updates = conky_parse('${updates}')
    update_num = tonumber(updates)
    
    if update_num > 5 then
        go_clock_rings(display)
    end

end

