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

varying highp vec4 v_color;

void main()
{
    gl_FragColor = v_color;
//    gl_FragColor = vec4(0.0,1.0,0.0,1.0);
}
