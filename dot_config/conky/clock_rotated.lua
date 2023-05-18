require 'cairo'

function conky_show_text(cr, text, char_x, char_y, default_color, colors_map, spacing_map)
    local extents = cairo_text_extents_t:create()

    cairo_text_extents(cr, text, extents)

    for i = 1, #text do
        if colors_map[i] ~= nil then
            cairo_set_source_rgb(cr, table.unpack(colors_map[i]))
        else
            cairo_set_source_rgb(cr, table.unpack(default_color))
        end

        cairo_move_to(cr, char_x, char_y)
        cairo_show_text(cr, text:sub(i, i))
        extents = cairo_text_extents_t:create()
        cairo_text_extents(cr, text:sub(i, i), extents)


        if spacing_map[i] ~= nil then
            char_x = char_x + extents.width + spacing_map[i]
        else
            char_x = char_x + extents.width
        end
    end
end

function conky_main()
    local font = "Earwig Factory"
    local rotation_angle = -35
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
        -150.0,        -- char_x
        250.0,         -- char_y
        snow_storm,    -- default_color
        {
            [4] = aurora_red
        }, -- colors map, meaning that the character in the 4th position will use the color aurora red
        {}
    )

    cairo_set_font_size(cr, full_date_font_size);
    conky_show_text(
        cr,
        os.date("%d %B"), -- text
        -150.0,           -- char_x
        320.0,            -- char_y
        snow_storm,       -- default_color
        {
            [3] = polar_night,
            [5] = aurora_red
        },
        {
            [3] = 20
        }
    )

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end
