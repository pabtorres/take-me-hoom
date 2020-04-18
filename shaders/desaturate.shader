shader_type canvas_item;

uniform float amount : hint_range(0.0, 1.0);
uniform float radius : hint_range(0.0, 3.0);
uniform float pos_x : hint_range(-2.0, 2.0);
uniform float pos_y : hint_range(-1.0, 1.0);

// All components are in the range [0…1], including hue.
vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

// All components are in the range [0…1], including hue.
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment(){
	vec3 st = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	vec3 new_st = rgb2hsv(st);
	new_st.y = 0.0;
	COLOR.rgb = mix(st, hsv2rgb(new_st), amount);
	
	vec2 uv =  UV;
	uv = uv * 2.0 - 1.0;
	uv.x *=	 16.0 / 9.0;
	
	uv.x -= pos_x;
	uv.y -= pos_y;
	float l = length(uv);
	// Smooth
	l = smoothstep(0, l, radius);
	// Sharp
//	l = step(l, radius);
	COLOR.rgb *= l;
}