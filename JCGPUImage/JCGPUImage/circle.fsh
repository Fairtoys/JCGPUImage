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

void main()
{
    highp vec2 uv = v_positionInPixels / u_resolution;
    uv -= 0.5;
    uv.y *= u_resolution.y / u_resolution.x;
    
    highp float d = length(uv);
    
    highp float c = smoothstep(0.3, 0.3 + 0.05, d);
    
    gl_FragColor = vec4(vec3(1. - c), 1.);
}
