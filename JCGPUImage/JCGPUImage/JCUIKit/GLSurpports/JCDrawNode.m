//
//  JCDrawNode.m
//  JCGPUImage
//
//  Created by huajiao on 2018/6/15.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import "JCDrawNode.h"
#import "JCGLProgram.h"


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

@interface JCDrawNode ()
@property (nonatomic, strong) JCGLProgram *program;
@end

@implementation JCDrawNode

- (JCGLProgram *)program{
    if (!_program) {
        _program = [[JCGLProgram alloc] initWithVertexShaderString:@"CH06-brick" fragmentShaderString:@"CH06-brick"];
    }
    return _program;
}

@end
