shader_type spatial;

uniform float time_scale = 1.0;
uniform float side_to_side = 1.0;
uniform float pivot = 5.0;
uniform float len = 0.8;
uniform float twist = 1.0;
uniform float wave = 1.0;
uniform float time_offset = 0.0;

uniform float mask_black  = 0.0;
uniform float mask_white  = 1.0;

uniform sampler2D tex;

void vertex() {
	float time = (TIME + time_offset) * time_scale;
	float body = (VERTEX.z + len/2.0) / len;
	float pivot_angle = cos(time) * 0.1 * pivot;
	mat2 rotation_matrix = mat2(vec2(cos(pivot_angle), -sin(pivot_angle)), vec2(sin(pivot_angle), cos(pivot_angle)));

	VERTEX.yz = rotation_matrix * VERTEX.yz;

	float twist_angle = cos(time + body) * 0.3 * twist;
	mat2 twist_matrix = mat2(vec2(cos(twist_angle), -sin(twist_angle)), vec2(sin(twist_angle), cos(twist_angle)));

	VERTEX.xz = twist_matrix * VERTEX.xz;

	float mask = smoothstep(mask_black, mask_white, 1.0 - body);

	VERTEX.z += cos(time + body) * mask * wave;
	VERTEX.yz = mix(VERTEX.yz, twist_matrix * VERTEX.yz, mask);
}


void fragment() {
	ALBEDO = texture(tex, UV).rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
