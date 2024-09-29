shader_type canvas_item;

uniform float time_scale: hint_range(0.0, 3.0) = 1.0;

// How jagged each band of melting pixels are
// This is also the amplitude of the wave
uniform float meltness: hint_range(0.0, 3.0) = 1.0;

// If it should affect only lower parts of the shader, it also increases the meltness
uniform float how_low: hint_range(0.0, 5.0) = 1.0;

// How wavy. 
uniform float wave_frequency: hint_range(0.0, 30.0) = 20.0;

uniform bool bounce = false;

float wave(float x) {
	float progress = TIME * time_scale;
	return x - 2.5 + cos(2.0 * PI * progress + wave_frequency * x);
}

void fragment() {
	vec2 uv = UV;
	float off = 0.0;
	if(bounce){
		off = sin(TIME)*.1;
	}
	uv.y -= pow( uv.y,how_low ) * 0.02 * meltness * wave( UV.x - mod( UV.x, TEXTURE_PIXEL_SIZE.x ));
	uv.y += off;
	
	COLOR = texture(TEXTURE, uv);
	
	// "delete" pixels out of range
	if (uv.y <= 0.0 || uv.y >= 1.0) {
		COLOR.a = 0.0;
	}
}