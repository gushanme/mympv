// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

//!DESC [ravu_zoom_r3_chroma] (chroma, r3, compute)
//!HOOK CHROMA
//!BIND HOOKED
//!BIND ravu_zoom_lut3
//!BIND LUMA
//!WIDTH LUMA.w
//!HEIGHT LUMA.h
//!OFFSET ALIGN
//!WHEN HOOKED.w LUMA.w < HOOKED.h LUMA.h < *
//!COMPUTE 32 8
#define LUTPOS(x, lut_size) mix(0.5 / (lut_size), 1.0 - 0.5 / (lut_size), (x))
shared vec3 samples[532];
void hook() {
ivec2 group_begin = ivec2(gl_WorkGroupID) * ivec2(gl_WorkGroupSize);
ivec2 group_end = group_begin + ivec2(gl_WorkGroupSize) - ivec2(1);
ivec2 rectl = ivec2(floor(HOOKED_size * HOOKED_map(group_begin) - 0.5)) - 2;
ivec2 rectr = ivec2(floor(HOOKED_size * HOOKED_map(group_end) - 0.5)) + 3;
ivec2 rect = rectr - rectl + 1;
for (int id = int(gl_LocalInvocationIndex); id < rect.x * rect.y; id += int(gl_WorkGroupSize.x * gl_WorkGroupSize.y)) {
int y = id / rect.x, x = id % rect.x;
samples[x + y * 38] = vec3(HOOKED_tex(HOOKED_pt * (vec2(rectl + ivec2(x, y)) + vec2(0.5,0.5) + HOOKED_off)).xy, LUMA_tex(HOOKED_pt * (vec2(rectl + ivec2(x, y)) + vec2(0.5,0.5)) + LUMA_pt * tex_offset).x);
}
groupMemoryBarrier();
barrier();
vec2 pos = HOOKED_size * HOOKED_map(ivec2(gl_GlobalInvocationID));
vec2 subpix = fract(pos - 0.5);
pos -= subpix;
subpix = LUTPOS(subpix, vec2(9.0));
vec2 subpix_inv = 1.0 - subpix;
subpix /= vec2(5.0, 288.0);
subpix_inv /= vec2(5.0, 288.0);
ivec2 ipos = ivec2(floor(pos)) - rectl;
int lpos = ipos.x + ipos.y * 38;
vec3 sample0 = samples[-78 + lpos];
vec3 sample1 = samples[-40 + lpos];
vec3 sample2 = samples[-2 + lpos];
vec3 sample3 = samples[36 + lpos];
vec3 sample4 = samples[74 + lpos];
vec3 sample5 = samples[112 + lpos];
vec3 sample6 = samples[-77 + lpos];
vec3 sample7 = samples[-39 + lpos];
vec3 sample8 = samples[-1 + lpos];
vec3 sample9 = samples[37 + lpos];
vec3 sample10 = samples[75 + lpos];
vec3 sample11 = samples[113 + lpos];
vec3 sample12 = samples[-76 + lpos];
vec3 sample13 = samples[-38 + lpos];
vec3 sample14 = samples[0 + lpos];
vec3 sample15 = samples[38 + lpos];
vec3 sample16 = samples[76 + lpos];
vec3 sample17 = samples[114 + lpos];
vec3 sample18 = samples[-75 + lpos];
vec3 sample19 = samples[-37 + lpos];
vec3 sample20 = samples[1 + lpos];
vec3 sample21 = samples[39 + lpos];
vec3 sample22 = samples[77 + lpos];
vec3 sample23 = samples[115 + lpos];
vec3 sample24 = samples[-74 + lpos];
vec3 sample25 = samples[-36 + lpos];
vec3 sample26 = samples[2 + lpos];
vec3 sample27 = samples[40 + lpos];
vec3 sample28 = samples[78 + lpos];
vec3 sample29 = samples[116 + lpos];
vec3 sample30 = samples[-73 + lpos];
vec3 sample31 = samples[-35 + lpos];
vec3 sample32 = samples[3 + lpos];
vec3 sample33 = samples[41 + lpos];
vec3 sample34 = samples[79 + lpos];
vec3 sample35 = samples[117 + lpos];
vec3 abd = vec3(0.0);
float gx, gy;
gx = (sample13.z-sample1.z)/2.0;
gy = (sample8.z-sample6.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (sample14.z-sample2.z)/2.0;
gy = (-sample10.z+8.0*sample9.z-8.0*sample7.z+sample6.z)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample15.z-sample3.z)/2.0;
gy = (-sample11.z+8.0*sample10.z-8.0*sample8.z+sample7.z)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample16.z-sample4.z)/2.0;
gy = (sample11.z-sample9.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (-sample25.z+8.0*sample19.z-8.0*sample7.z+sample1.z)/12.0;
gy = (sample14.z-sample12.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (-sample26.z+8.0*sample20.z-8.0*sample8.z+sample2.z)/12.0;
gy = (-sample16.z+8.0*sample15.z-8.0*sample13.z+sample12.z)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (-sample27.z+8.0*sample21.z-8.0*sample9.z+sample3.z)/12.0;
gy = (-sample17.z+8.0*sample16.z-8.0*sample14.z+sample13.z)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (-sample28.z+8.0*sample22.z-8.0*sample10.z+sample4.z)/12.0;
gy = (sample17.z-sample15.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (-sample31.z+8.0*sample25.z-8.0*sample13.z+sample7.z)/12.0;
gy = (sample20.z-sample18.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (-sample32.z+8.0*sample26.z-8.0*sample14.z+sample8.z)/12.0;
gy = (-sample22.z+8.0*sample21.z-8.0*sample19.z+sample18.z)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (-sample33.z+8.0*sample27.z-8.0*sample15.z+sample9.z)/12.0;
gy = (-sample23.z+8.0*sample22.z-8.0*sample20.z+sample19.z)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (-sample34.z+8.0*sample28.z-8.0*sample16.z+sample10.z)/12.0;
gy = (sample23.z-sample21.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample31.z-sample19.z)/2.0;
gy = (sample26.z-sample24.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (sample32.z-sample20.z)/2.0;
gy = (-sample28.z+8.0*sample27.z-8.0*sample25.z+sample24.z)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample33.z-sample21.z)/2.0;
gy = (-sample29.z+8.0*sample28.z-8.0*sample26.z+sample25.z)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample34.z-sample22.z)/2.0;
gy = (sample29.z-sample27.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
float a = abd.x, b = abd.y, d = abd.z;
float T = a + d, D = a * d - b * b;
float delta = sqrt(max(T * T / 4.0 - D, 0.0));
float L1 = T / 2.0 + delta, L2 = T / 2.0 - delta;
float sqrtL1 = sqrt(L1), sqrtL2 = sqrt(L2);
float theta = mix(mod(atan(L1 - a, b) + 3.141592653589793, 3.141592653589793), 0.0, abs(b) < 1.192092896e-7);
float lambda = sqrtL1;
float mu = mix((sqrtL1 - sqrtL2) / (sqrtL1 + sqrtL2), 0.0, sqrtL1 + sqrtL2 < 1.192092896e-7);
float angle = floor(theta * 24.0 / 3.141592653589793);
float strength = mix(mix(0.0, 1.0, lambda >= 0.004), mix(2.0, 3.0, lambda >= 0.05), lambda >= 0.016);
float coherence = mix(mix(0.0, 1.0, mu >= 0.25), 2.0, mu >= 0.5);
float coord_y = ((angle * 4.0 + strength) * 3.0 + coherence) / 288.0;
vec2 res = vec2(0.0);
vec4 w;
w = texture(ravu_zoom_lut3, vec2(0.0, coord_y) + subpix);
res += sample0.xy * w[0];
res += sample1.xy * w[1];
res += sample2.xy * w[2];
res += sample3.xy * w[3];
w = texture(ravu_zoom_lut3, vec2(0.2, coord_y) + subpix);
res += sample4.xy * w[0];
res += sample5.xy * w[1];
res += sample6.xy * w[2];
res += sample7.xy * w[3];
w = texture(ravu_zoom_lut3, vec2(0.4, coord_y) + subpix);
res += sample8.xy * w[0];
res += sample9.xy * w[1];
res += sample10.xy * w[2];
res += sample11.xy * w[3];
w = texture(ravu_zoom_lut3, vec2(0.6, coord_y) + subpix);
res += sample12.xy * w[0];
res += sample13.xy * w[1];
res += sample14.xy * w[2];
res += sample15.xy * w[3];
w = texture(ravu_zoom_lut3, vec2(0.8, coord_y) + subpix);
res += sample16.xy * w[0];
res += sample17.xy * w[1];
w = texture(ravu_zoom_lut3, vec2(0.0, coord_y) + subpix_inv);
res += sample35.xy * w[0];
res += sample34.xy * w[1];
res += sample33.xy * w[2];
res += sample32.xy * w[3];
w = texture(ravu_zoom_lut3, vec2(0.2, coord_y) + subpix_inv);
res += sample31.xy * w[0];
res += sample30.xy * w[1];
res += sample29.xy * w[2];
res += sample28.xy * w[3];
w = texture(ravu_zoom_lut3, vec2(0.4, coord_y) + subpix_inv);
res += sample27.xy * w[0];
res += sample26.xy * w[1];
res += sample25.xy * w[2];
res += sample24.xy * w[3];
w = texture(ravu_zoom_lut3, vec2(0.6, coord_y) + subpix_inv);
res += sample23.xy * w[0];
res += sample22.xy * w[1];
res += sample21.xy * w[2];
res += sample20.xy * w[3];
w = texture(ravu_zoom_lut3, vec2(0.8, coord_y) + subpix_inv);
res += sample19.xy * w[0];
res += sample18.xy * w[1];
res = clamp(res, 0.0, 1.0);
imageStore(out_image, ivec2(gl_GlobalInvocationID), vec4(res, 0.0, 0.0));
}
//!TEXTURE ravu_zoom_lut3
//!SIZE 45 2592
//!FORMAT rgba16f
//!FILTER LINEAR