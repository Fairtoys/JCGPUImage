//
//  JCGLRenderbuffer.m
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import "JCGLRenderbuffer.h"
#import "JCGLFramebuffer.h"

@implementation JCGLRenderbuffer

- (instancetype)init
{
    self = [super init];
    if (self) {
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


@end


@implementation JCGLRenderbuffer (JCFramebufferAttachProtocol)

- (void)bindFrameBuffer:(JCGLFramebuffer *)framebuffer{
    [framebuffer bind];
    [self bind];
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderbuffer);
    
}

@end
