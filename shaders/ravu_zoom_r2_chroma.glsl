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

//!DESC [ravu_zoom_r2_chroma] (chroma, r2, compute)
//!HOOK CHROMA
//!BIND HOOKED
//!BIND ravu_zoom_lut2
//!BIND LUMA
//!WIDTH LUMA.w
//!HEIGHT LUMA.h
//!OFFSET ALIGN
//!WHEN HOOKED.w LUMA.w < HOOKED.h LUMA.h < *
//!COMPUTE 32 8
#define LUTPOS(x, lut_size) mix(0.5 / (lut_size), 1.0 - 0.5 / (lut_size), (x))
shared vec3 samples[432];
void hook() {
ivec2 group_begin = ivec2(gl_WorkGroupID) * ivec2(gl_WorkGroupSize);
ivec2 group_end = group_begin + ivec2(gl_WorkGroupSize) - ivec2(1);
ivec2 rectl = ivec2(floor(HOOKED_size * HOOKED_map(group_begin) - 0.5)) - 1;
ivec2 rectr = ivec2(floor(HOOKED_size * HOOKED_map(group_end) - 0.5)) + 2;
ivec2 rect = rectr - rectl + 1;
for (int id = int(gl_LocalInvocationIndex); id < rect.x * rect.y; id += int(gl_WorkGroupSize.x * gl_WorkGroupSize.y)) {
int y = id / rect.x, x = id % rect.x;
samples[x + y * 36] = vec3(HOOKED_tex(HOOKED_pt * (vec2(rectl + ivec2(x, y)) + vec2(0.5,0.5) + HOOKED_off)).xy, LUMA_tex(HOOKED_pt * (vec2(rectl + ivec2(x, y)) + vec2(0.5,0.5)) + LUMA_pt * tex_offset).x);
}
groupMemoryBarrier();
barrier();
vec2 pos = HOOKED_size * HOOKED_map(ivec2(gl_GlobalInvocationID));
vec2 subpix = fract(pos - 0.5);
pos -= subpix;
subpix = LUTPOS(subpix, vec2(9.0));
vec2 subpix_inv = 1.0 - subpix;
subpix /= vec2(2.0, 288.0);
subpix_inv /= vec2(2.0, 288.0);
ivec2 ipos = ivec2(floor(pos)) - rectl;
int lpos = ipos.x + ipos.y * 36;
vec3 sample0 = samples[-37 + lpos];
vec3 sample1 = samples[-1 + lpos];
vec3 sample2 = samples[35 + lpos];
vec3 sample3 = samples[71 + lpos];
vec3 sample4 = samples[-36 + lpos];
vec3 sample5 = samples[0 + lpos];
vec3 sample6 = samples[36 + lpos];
vec3 sample7 = samples[72 + lpos];
vec3 sample8 = samples[-35 + lpos];
vec3 sample9 = samples[1 + lpos];
vec3 sample10 = samples[37 + lpos];
vec3 sample11 = samples[73 + lpos];
vec3 sample12 = samples[-34 + lpos];
vec3 sample13 = samples[2 + lpos];
vec3 sample14 = samples[38 + lpos];
vec3 sample15 = samples[74 + lpos];
vec3 abd = vec3(0.0);
float gx, gy;
gx = (sample4.z-sample0.z);
gy = (sample1.z-sample0.z);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (sample5.z-sample1.z);
gy = (sample2.z-sample0.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample6.z-sample2.z);
gy = (sample3.z-sample1.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample7.z-sample3.z);
gy = (sample3.z-sample2.z);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (sample8.z-sample0.z)/2.0;
gy = (sample5.z-sample4.z);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample9.z-sample1.z)/2.0;
gy = (sample6.z-sample4.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (sample10.z-sample2.z)/2.0;
gy = (sample7.z-sample5.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (sample11.z-sample3.z)/2.0;
gy = (sample7.z-sample6.z);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample12.z-sample4.z)/2.0;
gy = (sample9.z-sample8.z);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample13.z-sample5.z)/2.0;
gy = (sample10.z-sample8.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (sample14.z-sample6.z)/2.0;
gy = (sample11.z-sample9.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (sample15.z-sample7.z)/2.0;
gy = (sample11.z-sample10.z);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample12.z-sample8.z);
gy = (sample13.z-sample12.z);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (sample13.z-sample9.z);
gy = (sample14.z-sample12.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample14.z-sample10.z);
gy = (sample15.z-sample13.z)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample15.z-sample11.z);
gy = (sample15.z-sample14.z);
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
w = texture(ravu_zoom_lut2, vec2(0.0, coord_y) + subpix);
res += sample0.xy * w[0];
res += sample1.xy * w[1];
res += sample2.xy * w[2];
res += sample3.xy * w[3];
w = texture(ravu_zoom_lut2, vec2(0.5, coord_y) + subpix);
res += sample4.xy * w[0];
res += sample5.xy * w[1];
res += sample6.xy * w[2];
res += sample7.xy * w[3];
w = texture(ravu_zoom_lut2, vec2(0.0, coord_y) + subpix_inv);
res += sample15.xy * w[0];
res += sample14.xy * w[1];
res += sample13.xy * w[2];
res += sample12.xy * w[3];
w = texture(ravu_zoom_lut2, vec2(0.5, coord_y) + subpix_inv);
res += sample11.xy * w[0];
res += sample10.xy * w[1];
res += sample9.xy * w[2];
res += sample8.xy * w[3];
res = clamp(res, 0.0, 1.0);
imageStore(out_image, ivec2(gl_GlobalInvocationID), vec4(res, 0.0, 0.0));
}
//!TEXTURE ravu_zoom_lut2
//!SIZE 18 2592
//!FORMAT rgba16f
//!FILTER LINEAR