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


@interface JCDrawNode ()
@property (nonatomic, strong) JCGLProgramBase *program;
@end

@implementation JCDrawNode

- (JCGLProgramBase *)program{
    if (!_program) {
        _program = [[JCGLProgramBase alloc] init];
    }
    return _program;
}

- (void)draw{
    JCGLRenderbuffer *renderbuffer = [[JCGLContext sharedContext].currentFramebuffer renderBufferForColor0];
    GLuint width = renderbuffer.widthInPixel;
    GLuint height = renderbuffer.heightInPixel;
    JCQuad quad;
    quad.bl.position = GLKVector4Make(0, 0, 0, 1);
    quad.br.position = GLKVector4Make(width, 0, 0, 1);
    quad.tl.position = GLKVector4Make(0, height, 0, 1);
    quad.tr.position = GLKVector4Make(width, height, 0, 1);
    
    [self.program use];
    
    
    glVertexAttribPointer(self.program.aPosition, 4, GL_FLOAT, GL_FALSE, 0, 0);
    
}

@end
