const int C = 7;
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
    vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
    vec3 p = gl_FragCoord.xyz / u_resolution.x;
    float csz = 8.0 / u_resolution.x;
    vec4 col = vec4(0.0);
    float a = 2.0 + (cos(u_time * 2.0) * 0.5 + 0.5) * 20.0;
    float norma = sqrt(a / PI / float(C));
    for (int i = -C/2; i <= C/2; i++) {
        for (int j = -C/2; j <= C/2; j++) {
            vec2 uvo = vec2(float(i), float(j)) / float(C/2);
            float d = length(uvo);
            float coeff = norma * norma * exp(-a * d*d);
            col += coeff * texture2D(u_tex0, p.xy + uvo * csz);
        }
    }
    p.z = u_time * 0.03;
    //vec3 p2 = fbm3(fbm3(p * 2.0, 8, 2.0, 0.5) * 0.5 + p * 10.0 + vec3(2.2, 0.0, 0.0) * u_time * 0.0, 8, 2.0, 0.5);
    vec3 p2 = fbm3(0.1 * fbm3(0.5 * fbm3(p * 2.0, 8, 2.0, 0.5) * 0.5 + p * 10.0, 8, 2.0, 0.5), 8, 2.0, 0.5);
    float n = p2.y;
    //color = vec4(1.0, 1.0, 1.0, 1.0) * p.x;
    color = col;
    gl_FragColor = color;
}
