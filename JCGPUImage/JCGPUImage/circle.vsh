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
attribute highp vec2 a_positionInPixels;

varying highp vec2 v_positionInPixels;

void main()
{
    v_positionInPixels = a_positionInPixels;
    gl_Position = a_position;
}
