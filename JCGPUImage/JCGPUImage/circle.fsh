//
// Fragment shader for procedural bricks
//
// Authors: Dave Baldwin, Steve Koren, Randi Rost
//          based on a shader by Darwyn Peachey
//
// Copyright (c) 2002-2006 3Dlabs Inc. Ltd. 
//
// See 3Dlabs-License.txt for license information
//


uniform highp vec2 u_resolution;

varying highp vec2 v_positionInPixels;

highp float circle(highp vec2 uv,highp vec2 p,highp float r,highp float blur){
    highp float d = length(uv - p);
    
    highp float c = smoothstep(r, r - blur, d);

    return c;
}

highp float smileface(highp vec2 uv, highp vec2 p,highp float size){
    uv -= p;//translating coordinate system
    uv /= size;
    
    highp float mask = circle(uv, vec2(.0), 0.3, 0.01);
    mask -= circle(uv, vec2(-.13,.1), .07,.01);
    mask -= circle(uv, vec2(.13,.1), .07,.01);
    
    
    highp float mouth = circle(uv,vec2(.0) , 0.2, 0.01);
    mouth -= circle(uv,vec2(.0, 0.1) , 0.2, 0.01);
    mask -= mouth;
    return mask;
}

highp float band(highp float t, highp float start, highp float end, highp float blur){
    highp float step1 = smoothstep(start - blur, start + blur, t);
    highp float step2 = smoothstep(end + blur, end - blur, t);
    return step1 * step2;
}

highp float rect(highp vec2 uv, highp float left, highp float right, highp float top, highp float bottom, highp float blur){
    highp float band1 = band(uv.x, left, right, blur);
    highp float band2 = band(uv.y, top, bottom, blur);
    return band1 * band2;
}

void main()
{
    highp vec2 uv = v_positionInPixels / u_resolution;
    uv -= 0.5;
    uv.y *= u_resolution.y / u_resolution.x;
//    highp float mask = smileface(uv, vec2(0.),2.);
    highp float mask = 0.;
//    mask = smoothstep(-.2,.2, uv.x);
//    mask = band(uv.x, -.2, .2, 0.01);
    highp float x = uv.x;
    highp float y = uv.y;
//    x += .2;
    mask = rect(vec2(x, y) , -.2, .2, -.3, .3, .01);
    highp vec3 color = vec3(1., 1., 1.);

    gl_FragColor = vec4(color * mask, 1.);
}
