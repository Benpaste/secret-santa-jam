shader_type canvas_item;

uniform vec4 output_light: source_color;
uniform vec4 output_dark: source_color;


float get_value(vec4 color){
	return (color.r + color.g + color.b);
}


void fragment() {
	if (get_value(abs(output_light - COLOR)) < get_value(abs(output_dark - COLOR))) {
		COLOR = output_light;
	}
	else {
		COLOR = output_dark;
	}
}