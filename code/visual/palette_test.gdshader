shader_type canvas_item;

uniform sampler2D palette;
uniform float darken: hint_range(0, 1);

void fragment() {
	float pal_size = 4.0;
	float snap_darken = floor(pal_size * darken) / pal_size;
	vec4 color = texture(TEXTURE, UV);
	float x = (floor((color.r - snap_darken) * pal_size) + 0.5)/ pal_size;
	COLOR = vec4(texture(palette, vec2(x, 0.5)).rgb, color.a);
}
