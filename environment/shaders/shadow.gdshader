shader_type canvas_item;

void fragment() {
	// Verifica se a cor é 24, 20, 37 em RGB
	if (COLOR.a > 0.0) {
	if (vec3(COLOR.rgb) == vec3(24.0/255.0, 20.0/255.0, 37.0/255.0)) {
		// Se for essa cor, ajusta a transparência para 0.5
		COLOR.a = 0.5;
	}
	// Retorna a cor final
	COLOR = vec4(COLOR.rgb, COLOR.a);
	}
}