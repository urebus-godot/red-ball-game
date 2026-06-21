shader_type canvas_item;

instance uniform float frequency = 4.0;
instance uniform float speed = 0.5;
instance uniform float amplitude = 0.025;
instance uniform float blur = 0.001;

void fragment() {
	float wave_x = sin(UV.x * frequency + TIME * speed) * amplitude - amplitude;
	float wave_x_2 = sin(UV.x * frequency * 2.0 + TIME * -2.0) * 0.01 - 0.01;

	float mask = smoothstep(0.0, blur, UV.y + wave_x + wave_x_2 - 0.1);

	COLOR = texture(TEXTURE, UV);
	COLOR.a *= mask;
}
