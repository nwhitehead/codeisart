const int W = 5;
const int H = 5;

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
    float csz = 30.0 / u_resolution.x;
    vec4 col = texture2D(u_tex0, p.xy) + texture2D(u_tex0, p.xy + vec2(csz, csz));
    p.z = u_time * 0.03;
    //vec3 p2 = fbm3(fbm3(p * 2.0, 8, 2.0, 0.5) * 0.5 + p * 10.0 + vec3(2.2, 0.0, 0.0) * u_time * 0.0, 8, 2.0, 0.5);
    vec3 p2 = fbm3(0.1 * fbm3(0.5 * fbm3(p * 2.0, 8, 2.0, 0.5) * 0.5 + p * 10.0, 8, 2.0, 0.5), 8, 2.0, 0.5);
    float n = p2.y;
    //color = vec4(1.0, 1.0, 1.0, 1.0) * p.x;
    color = col;
    gl_FragColor = color;
}
