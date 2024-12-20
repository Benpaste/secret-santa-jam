shader_type canvas_item;

uniform float speed = 1.0;

void fragment() {
	
	vec2 scroll_uv = UV + vec2(0, speed * TIME);
	
	COLOR = texture(TEXTURE, scroll_uv);
}
