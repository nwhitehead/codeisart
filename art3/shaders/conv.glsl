const int C = 5;
const float PI = 3.14159265;

vec3 fbm3(vec3 x, int iters, float fratio, float wratio) {
   vec3 y = vec3(0.0);
   float w = 1.0;
   float s = 1.0;
   float m = 0.0;
   for (int i = 0; i < 32; i++) {
      if (i >= iters) break;
      y += w * gnoise3(x * s);
      m += w;
      s *= fratio;
      w *= wratio;
   }
   return y / m;
}

void main()
{
    vec3 p = gl_FragCoord.xyz / u_resolution.x;
    p.z = u_time * 0.005;
    float csz = 8.0 / u_resolution.x;
    vec4 col = vec4(0.0);
    vec2 toff = fbm3(vec3(p.xy, u_time), 8, 2.0, 0.5).xy * 0.01;
    vec3 p2 = fbm3(0.1 * fbm3(0.5 * fbm3(p * 2.0, 8, 2.0, 0.5) * 0.5 + p * 10.0, 8, 2.0, 0.5), 8, 2.0, 0.5);
    col += texture2D(u_tex0, p.xy + p2.xy * 0.05);
    gl_FragColor = col;
}
