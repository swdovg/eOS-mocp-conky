require 'cairo'
require 'string'

	function conky_main()
	if conky_window == nil then return end
	local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
	cr = cairo_create(cs)
	local updates=tonumber(conky_parse('${updates}'))
	if updates>2 then
--#########################################################################################################
--SETTINGS FOR INDICATOR BAR
		tmin,tsec,cmin,csec = conky_parse('${exec mocp -Q "%tt %ct"}'):match("(%d+):(%d+) (%d+):(%d+)")
		if tmin~=nil then
		bar_value=((cmin*60+csec)/(tmin*60+tsec))*100
		bar_bottom_left_x = 538
		bar_bottom_left_y = 535
		bar_width = 300
		bar_height = 1
		bar_max_value = 100
--set bar background colors
		bar_bg_r = 1
		bar_bg_g = 1
		bar_bg_b = 1
		bar_bg_a = 0.3
--set bar indicator colors
		bar_fg_r = 1
		bar_fg_g = 1
		bar_fg_b = 1
		bar_fg_a = 1
--set border thickness
		border_width = 0
--draw background
		cairo_set_source_rgba (cr, bar_bg_r, bar_bg_g, bar_bg_b, bar_bg_a)
		cairo_rectangle (cr, bar_bottom_left_x, bar_bottom_left_y, bar_width, -bar_height)
		cairo_fill (cr)
--draw indicator
		cairo_set_source_rgba (cr, bar_fg_r, bar_fg_g, bar_fg_b, bar_fg_a)
		scale = bar_width/bar_max_value
		indicator_width = scale*bar_value
		cairo_rectangle (cr, bar_bottom_left_x, bar_bottom_left_y-bar_height, indicator_width, bar_height)
		cairo_fill (cr)
		end
--#########################################################################################################
	end-- if updates>5
	cairo_destroy(cr)
	cairo_surface_destroy(cs)
	cr=nil
end-- end main function