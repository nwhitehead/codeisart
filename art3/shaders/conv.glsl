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
    p.z = u_time * 0.05;
    vec3 ps = p;
    float m = cos(u_time * 0.1) * 0.5 + 0.5;
    float z = 1.0 / (1.0 + (u_time * 0.03));
    float csz = 1.0 / u_resolution.x;
    vec4 col = vec4(0.0);
    vec2 toff = fbm3(vec3(p.xy, u_time), 8, 2.0, 0.5).xy * 0.01;
    vec3 p2 = fbm3(0.01 * fbm3(0.5 * fbm3(ps * 2.0, 8, 2.0, 0.5) * 0.5 + ps * 10.0, 8, 2.0, 0.5), 8, 2.0, 0.5);
    vec2 center = vec2(0.5, 0.3);
    for (int i = 0; i < C; i++) {
        for (int j = 0; j < C; j++) {
            vec2 sp = p.xy + p2.xy * 0.05 + vec2(float(i) * csz, float(j) * csz);
            vec2 zsp = (sp - center) * z + center;
            col += texture2D(u_tex0, zsp) * (1.0 / float(C) / float(C));
        }
    }
    gl_FragColor = col;
}
