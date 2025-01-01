shader_type canvas_item;

uniform float progress_: hint_range(-1, 1);
uniform vec2 SCREEN_SIZE = vec2(140, 190);
uniform float BOX_SIZE = 16.0;

void fragment() {
	
	vec2 uv_coord = UV * SCREEN_SIZE;
	
	float progress = (2.0 * progress_ - UV.y);
	
	if (progress_ < 0.0) {
		progress = -(2.0 * progress_ - UV.y) - 1.0;
		}
		
		
	if (mod(uv_coord.y / BOX_SIZE, 2.0) >= 1.0) {
		uv_coord.x += BOX_SIZE / 2.0;
	}
	float x_adjust = abs(mod(uv_coord.x, BOX_SIZE) - BOX_SIZE / 2.0) * 2.0;
	if (x_adjust < BOX_SIZE * progress) {
		COLOR.a = 0.0;
	}
	
}