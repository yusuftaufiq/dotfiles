require 'cairo'

function conky_show_text(cr, text, char_x, char_y, default_color, colors_map)
    local extents = cairo_text_extents_t:create()

    cairo_text_extents(cr, text, extents)

    for i = 1, #text do
        if colors_map[i] ~= nil then
            cairo_set_source_rgb(cr, table.unpack(colors_map[i]))
            cairo_move_to(cr, char_x, char_y)
            cairo_show_text(cr, text:sub(i, i))
            extents = cairo_text_extents_t:create()
            cairo_text_extents(cr, text:sub(i, i), extents)
            char_x = char_x + extents.width
        else
            cairo_set_source_rgb(cr, table.unpack(default_color))
            cairo_move_to(cr, char_x, char_y)
            cairo_show_text(cr, text:sub(i, i))
            extents = cairo_text_extents_t:create()
            cairo_text_extents(cr, text:sub(i, i), extents)
            char_x = char_x + extents.width
        end
    end
end

function conky_main()
    local font = "Earwig Factory"
    local rotation_angle = -65
    local day_of_week_font_size = 52.0
    local full_date_font_size = 84.0
    local snow_storm = { 0.93, 0.94, 0.96 }
    local polar_night = { 0.18, 0.21, 0.25 }
    local aurora_red = { 0.75, 0.38, 0.42, 1.0 }

    if conky_window == nil then
        return
    end

    local cs = cairo_xlib_surface_create(conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        conky_window.width,
        conky_window.height)
    local cr = cairo_create(cs)

    cairo_select_font_face(cr, font);

    cairo_rotate(cr, rotation_angle * math.pi / 180);

    cairo_set_font_size(cr, day_of_week_font_size);
    conky_show_text(
        cr,
        os.date("%A"), -- text
        -250.0,        -- char_x
        300.0,         -- char_y
        snow_storm,    -- default_color
        {
            [4] = polar_night
        }
    )

    cairo_set_font_size(cr, full_date_font_size);
    conky_show_text(
        cr,
        os.date("%d_%B"), -- text
        -250.0,           -- char_x
        370.0,            -- char_y
        snow_storm,       -- default_color
        {
            [3] = aurora_red,
            [5] = polar_night
        }
    )

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end
