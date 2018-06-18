//
//  JCGLRenderbuffer.m
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import "JCGLRenderbuffer.h"
#import "JCGLFramebuffer.h"
#import "JCGLContext.h"

@implementation JCGLRenderbuffer

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[JCGLContext sharedContext] setContextToCurrentContext];
        glGenRenderbuffers(1, &_renderbuffer);
    }
    return self;
}

- (void)dealloc{
    if (_renderbuffer) {
        glDeleteRenderbuffers(1, &_renderbuffer);
        _renderbuffer = 0;
    }
}

- (void)bind{
    glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
}

- (void)setRenderBufferStorageForDrawable:(id <EAGLDrawable>)drawable{
    [self bind];
    [[JCGLContext sharedContext].context renderbufferStorage:GL_RENDERBUFFER fromDrawable:drawable];
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_widthInPixel);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_heightInPixel);
    [[JCGLContext sharedContext] setViewPort:0 y:0 width:_widthInPixel height:_heightInPixel];
    
}

- (void)presentRenderBuffer{
    [self bind];
    [[JCGLContext sharedContext].context presentRenderbuffer:GL_RENDERBUFFER];
}

- (void)drawTriangles{
    
    glGenBuffers(1, NULL);
    
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, NULL);
}

@end

