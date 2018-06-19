//
// Vertex shader for procedural bricks
//
// Authors: Dave Baldwin, Steve Koren, Randi Rost
//          based on a shader by Darwyn Peachey
//
// Copyright (c) 2002-2006 3Dlabs Inc. Ltd. 
//
// See 3Dlabs-License.txt for license information
//

attribute highp vec4 a_position;
attribute highp vec4 a_color;

varying highp vec4 v_color;

void main()
{
    v_color = a_color;
    gl_Position = a_position;
}
