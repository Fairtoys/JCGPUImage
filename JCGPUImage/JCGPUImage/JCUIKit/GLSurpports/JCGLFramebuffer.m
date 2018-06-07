//
//  JCGLFramebuffer.m
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import "JCGLFramebuffer.h"
#import "JCFramebufferAttachProtocol.h"

@implementation JCGLFramebuffer

- (instancetype)init
{
    self = [super init];
    if (self) {
        glGenFramebuffers(1, &_framebuffer);
    }
    return self;
}

- (void)bind{
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
}

- (void)bindToTarget:(id <JCFramebufferAttachProtocol>)target{
    if ([target respondsToSelector:@selector(bindFrameBuffer:)]) {
        [target bindFrameBuffer:self];
    }
}


- (void)dealloc{
    if (_framebuffer) {
        glDeleteFramebuffers(1, &_framebuffer);
        _framebuffer = 0;
    }
}

@end
