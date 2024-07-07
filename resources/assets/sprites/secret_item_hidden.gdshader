shader_type canvas_item;

void fragment() {

	if (COLOR.a > 0.0) {
		COLOR.r = 1.0;
		COLOR.g = 1.0;
		COLOR.b = 1.0;
		COLOR.a = 0.8;
		// Retorna a cor final
		COLOR = vec4(COLOR.rgb, COLOR.a);
	}
}