//
//  JCGLProgram.m
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import "JCGLProgram.h"
#import "JCGLContext.h"

@implementation JCGLProgram

- (instancetype)initWithVertexShaderString:(NSString *)vShaderString fragmentShaderString:(NSString *)fShaderString{
    if ((self = [super init]))
    {
//        _initialized = NO;
        [[JCGLContext sharedContext] setContextToCurrentContext];
        _program = glCreateProgram();
        
        if (![self compileShader:&_vertShader
                            type:GL_VERTEX_SHADER
                          string:vShaderString
                          logStr:&_vertexShaderLog])
        {
            NSLog(@"Failed to compile vertex shader");
        }
        
        // Create and compile fragment shader
        if (![self compileShader:&_fragShader
                            type:GL_FRAGMENT_SHADER
                          string:fShaderString
                          logStr:&_fragmentShaderLog])
        {
            NSLog(@"Failed to compile fragment shader");
        }
        
        glAttachShader(_program, _vertShader);
        glAttachShader(_program, _fragShader);
    }
    
    return self;
}

- (instancetype)initWithVertexShaderString:(NSString *)vShaderString fragmentShaderFilename:(NSString *)fShaderFilename{
    NSString *fragShaderPathname = [[NSBundle mainBundle] pathForResource:fShaderFilename ofType:@"fsh"];
    NSString *fragmentShaderString = [NSString stringWithContentsOfFile:fragShaderPathname encoding:NSUTF8StringEncoding error:nil];
    return [self initWithVertexShaderString:vShaderString fragmentShaderString:fragmentShaderString];
}

- (instancetype)initWithVertexShaderFilename:(NSString *)vShaderFilename fragmentShaderFilename:(NSString *)fShaderFilename{
    NSString *vertShaderPathname = [[NSBundle mainBundle] pathForResource:vShaderFilename ofType:@"vsh"];
    NSString *vertexShaderString = [NSString stringWithContentsOfFile:vertShaderPathname encoding:NSUTF8StringEncoding error:nil];
    
    NSString *fragShaderPathname = [[NSBundle mainBundle] pathForResource:fShaderFilename ofType:@"fsh"];
    NSString *fragmentShaderString = [NSString stringWithContentsOfFile:fragShaderPathname encoding:NSUTF8StringEncoding error:nil];
    return [self initWithVertexShaderString:vertexShaderString fragmentShaderString:fragmentShaderString];
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type string:(NSString *)shaderString logStr:(NSString * __strong *)logStr{
    GLint status;
    const GLchar *source;
    
    source =
    (GLchar *)[shaderString UTF8String];
    if (!source)
    {
        NSLog(@"Failed to load vertex shader");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    
    if (status != GL_TRUE)
    {
        GLint logLength;
        glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
        if (logLength > 0)
        {
            GLchar *log = (GLchar *)malloc(logLength);
            glGetShaderInfoLog(*shader, logLength, &logLength, log);
            *logStr = [NSString stringWithFormat:@"%s", log];
            free(log);
        }
    }
    return status == GL_TRUE;
}

- (BOOL)link{
    //    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    GLint status;
    
    glLinkProgram(_program);
    
    glGetProgramiv(_program, GL_LINK_STATUS, &status);
    if (status == GL_FALSE)
        return NO;
    
    if (_vertShader)
    {
        glDeleteShader(_vertShader);
        _vertShader = 0;
    }
    if (_fragShader)
    {
        glDeleteShader(_fragShader);
        _fragShader = 0;
    }
    
//    self.initialized = YES;
    
    //    CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
    //    NSLog(@"Linked in %f ms", linkTime * 1000.0);
    
    return YES;

}

- (void)use{
    glUseProgram(_program);
}

- (NSMutableArray<NSString *> *)attributes{
    if (!_attributes) {
        _attributes = [NSMutableArray array];
    }
    return _attributes;
}

- (void)addAttribute:(NSString *)attributeName
{
    if (![self.attributes containsObject:attributeName])
    {
        [self.attributes addObject:attributeName];
        glBindAttribLocation(_program,
                             (GLuint)[self.attributes indexOfObject:attributeName],
                             [attributeName UTF8String]);
    }
}

- (GLuint)attributeIndex:(NSString *)attributeName
{
    return (GLuint)[self.attributes indexOfObject:attributeName];
}

- (GLuint)uniformIndex:(NSString *)uniformName
{
    return glGetUniformLocation(_program, [uniformName UTF8String]);
}

- (void)validate;
{
    GLint logLength;
    
    glValidateProgram(_program);
    glGetProgramiv(_program, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(_program, logLength, &logLength, log);
        self.programLog = [NSString stringWithFormat:@"%s", log];
        free(log);
    }
}

- (void)dealloc
{
    if (_vertShader)
        glDeleteShader(_vertShader);
    
    if (_fragShader)
        glDeleteShader(_fragShader);
    
    if (_program)
        glDeleteProgram(_program);
    
}

- (void)setUniformf:(GLuint)location x:(GLfloat)x {
    glUniform1f(location, x);
}
- (void)setUniformf:(GLuint)location x:(GLfloat)x y:(GLfloat)y{
    glUniform2f(location, x, y);
}
- (void)setUniformf:(GLuint)location x:(GLfloat)x y:(GLfloat)y z:(GLfloat)z{
    glUniform3f(location, x, y, z);
}


@end
