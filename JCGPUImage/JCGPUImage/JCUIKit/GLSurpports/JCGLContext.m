//
//  JCGLContext.m
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import "JCGLContext.h"
#import "JCGLRenderbuffer.h"
#import "JCGLFramebuffer.h"
#import "JCNode.h"

@implementation JCGLContext

+ (instancetype)sharedContext{
    static JCGLContext *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JCGLContext alloc] init];
    });
    return instance;
}

- (EAGLContext *)context{
    if (!_context) {
        _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    return _context;
}

- (void)setContextToCurrentContext{
    if ([EAGLContext currentContext] != self.context) {
        [EAGLContext setCurrentContext:self.context];
    }
}

- (void)setViewPort:(GLint)x y:(GLint)y width:(GLsizei)width height:(GLsizei)height{
    glViewport(x, y, width, height);
}



- (void)update{
    
}

- (void)draw{
    [self.currentFramebuffer bind];
    [self.currentFramebuffer clear];
    
    [self.rootNode visit];
    
    [self.currentFramebuffer bind];
    [self.currentRenderbuffer presentRenderBuffer];
}

@end
