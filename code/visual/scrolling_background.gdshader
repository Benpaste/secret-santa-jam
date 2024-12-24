shader_type canvas_item;

uniform float speed = 1.0;

void fragment() {
	
	
	vec2 uv = UV;
	uv.x += 0.02 * sin(uv.y * TAU);
	uv.y += 0.01 * cos((uv.x * TAU) + (TIME * 10.0));
	vec2 scroll_uv = uv + vec2(0, speed * TIME);
	
	COLOR = texture(TEXTURE, scroll_uv);
}
