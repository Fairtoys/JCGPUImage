//
//  JCDrawNode.m
//  JCGPUImage
//
//  Created by huajiao on 2018/6/15.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import "JCDrawNode.h"
#import "JCGLProgram.h"
#import "JCGLContext.h"
#import "JCGLFramebuffer.h"
#import "JCGLRenderbuffer.h"


/**
 顶点结构体
 */
typedef struct JCVertex {
    GLKVector4 position;
    GLKVector4 color;
}JCVertex;


/**
 四边形
 */
typedef struct JCQuad{
    JCVertex bl, br,tl, tr;
}JCQuad;

@interface JCGLProgramBrick : JCGLProgram

@property (nonatomic, assign) GLuint uLightPosition;

@property (nonatomic, assign) GLuint uBrickColor;
@property (nonatomic, assign) GLuint uMortarColor;
@property (nonatomic, assign) GLuint uBrickSize;
@property (nonatomic, assign) GLuint uBrickPct;

@end

@implementation JCGLProgramBrick

- (instancetype)initWithVertexShaderString:(NSString *)vShaderString fragmentShaderString:(NSString *)fShaderString{
    if (self = [super initWithVertexShaderString:vShaderString fragmentShaderString:fShaderString]) {
        BOOL linked = [self link];
        if (!linked) {
            NSLog(@"link error");
        }
        _uLightPosition = [self uniformIndex:@"LightPosition"];
        
        _uBrickColor = [self uniformIndex:@"BrickColor"];
        _uMortarColor = [self uniformIndex:@"MortarColor"];
        _uBrickSize = [self uniformIndex:@"BrickSize"];
        _uBrickPct = [self uniformIndex:@"BrickPct"];
        
    }
    return self;
}

@end

@interface JCGLProgramBase : JCGLProgram

@property (nonatomic, assign) GLuint aPosition;
@property (nonatomic, assign) GLuint aColor;

@end

@implementation JCGLProgramBase

- (instancetype)init{
    if (self = [super initWithVertexShaderFilename:@"base" fragmentShaderFilename:@"base"]) {
        [self addAttribute:@"a_position"];
        [self addAttribute:@"a_color"];
        
        BOOL linked = [self link];
        
        if (!linked) {
            NSLog(@"link error");
        }
        
        _aPosition = [self attributeIndex:@"a_position"];
        _aColor = [self attributeIndex:@"a_color"];
        
        [self use];
        
        [self enableVertexAttribArray:_aPosition];
        [self enableVertexAttribArray:_aColor];
    }
    return self;
}

@end

@interface JCGLProgramDrawCircle : JCGLProgram

@property (nonatomic, assign) GLuint aPosition;
@property (nonatomic, assign) GLuint aPositionInPixels;

@property (nonatomic, assign) GLuint uResolution;


@end

@implementation JCGLProgramDrawCircle
- (instancetype)init{
    if (self = [super initWithVertexShaderFilename:@"circle" fragmentShaderFilename:@"circle"]) {
        [self addAttribute:@"a_position"];
        [self addAttribute:@"a_positionInPixels"];
        
        BOOL linked = [self link];
        
        if (!linked) {
            NSLog(@"link error");
        }
        
        _aPosition = [self attributeIndex:@"a_position"];
        _aPositionInPixels = [self attributeIndex:@"a_positionInPixels"];
        
        [self use];
        
        [self enableVertexAttribArray:_aPosition];
        [self enableVertexAttribArray:_aPositionInPixels];
        
        _uResolution = [self uniformIndex:@"u_resolution"];
    }
    return self;
}
@end

#define ProgramClass JCGLProgramDrawCircle

@interface JCDrawNode ()
@property (nonatomic, strong) ProgramClass *program;
@end

@implementation JCDrawNode

- (ProgramClass *)program{
    if (!_program) {
        _program = [[ProgramClass alloc] init];
    }
    return _program;
}

- (void)draw{
    JCGLRenderbuffer *renderbuffer = [[JCGLContext sharedContext].currentFramebuffer renderBufferForColor0];
    JCGLContext *context = [JCGLContext sharedContext];
    GLKMatrix4 transform = context.projectionMatrix;
    
    GLuint width = renderbuffer.widthInPixel;
    GLuint height = renderbuffer.heightInPixel;
    JCQuad quad;
    CGFloat edge = 0;
    quad.bl.position = GLKMatrix4MultiplyVector4(transform, GLKVector4Make(edge, edge, 0, 1));
    quad.br.position = GLKMatrix4MultiplyVector4(transform, GLKVector4Make(width - edge, edge, 0, 1));
    quad.tl.position = GLKMatrix4MultiplyVector4(transform, GLKVector4Make(edge, height - edge, 0, 1));
    quad.tr.position = GLKMatrix4MultiplyVector4(transform, GLKVector4Make(width - edge, height - edge, 0, 1));
    
    quad.bl.color = GLKVector4Make(0.5, 0.0, 0.0, 1.0);
    quad.br.color = GLKVector4Make(0.0, 1.0, 0.0, 1.0);
    quad.tl.color = GLKVector4Make(0.0, 0.0, 1.0, 1.0);
    quad.tr.color = GLKVector4Make(0.0, 1.0, 1.0, 1.0);
    
    GLfloat positionInPixels[2 * 4] = {
        0, 0,
        width, 0,
        0,  height,
        width, height
    };
    
//    GLfloat color[ 4 * 4] = {
//        0.5, 0, 0, 1,
//        0, 1, 0, 1,
//        0, 0, 1, 1,
//        0, 1, 1, 1
//    };
    
    [self.program use];
//    int offset = offsetof(JCVertex, color);
    [self.program setVertexAttribPointer:self.program.aPosition size:4 type:GL_FLOAT normalized:GL_FALSE stride:sizeof(JCVertex) ptr:(GLvoid*)(&quad) + offsetof(JCVertex, position)];
//    [self.program setVertexAttribPointer:self.program.aPositionInPixels size:4 type:GL_FLOAT normalized:GL_FALSE stride:sizeof(JCVertex) ptr:(GLvoid*)(&quad) + offset];
//    [self.program setVertexAttribPointer:self.program.aColor size:4 type:GL_FLOAT normalized:GL_FALSE stride:0 ptr:color];
    [self.program setVertexAttribPointer:self.program.aPositionInPixels size:2 type:GL_FLOAT normalized:GL_FALSE stride:0 ptr:positionInPixels];
    [self.program setUniformf:self.program.uResolution x:width y:height];
    [renderbuffer drawQuad];
}

@end
