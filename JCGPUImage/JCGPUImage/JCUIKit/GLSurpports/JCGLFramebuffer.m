//
//  JCGLFramebuffer.m
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import "JCGLFramebuffer.h"
#import "JCGLRenderbuffer.h"
#import "JCGLTexture.h"
#import "JCGLContext.h"

@interface JCGLFramebuffer ()

@property (nonatomic, strong) NSMutableDictionary <NSNumber *, JCGLRenderbuffer *> *renderbuffers;
@end

@implementation JCGLFramebuffer

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[JCGLContext sharedContext] setContextToCurrentContext];
        glGenFramebuffers(1, &_framebuffer);
    }
    return self;
}

- (void)bind{
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
}

- (void)clear{
    [self bind];
    glClearColor(1, 0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    
}

- (void)render{
    [self bind];
    [self.renderbuffers.allValues makeObjectsPerformSelector:@selector(presentRenderBuffer)];
}

- (NSMutableDictionary<NSNumber *,JCGLRenderbuffer *> *)renderbuffers{
    if (!_renderbuffers) {
        _renderbuffers = [NSMutableDictionary dictionary];
    }
    return _renderbuffers;
}

- (nullable JCGLRenderbuffer *)renderBufferForColor0{
    return [self renderBufferForAttachment:GL_COLOR_ATTACHMENT0];
}
- (JCGLRenderbuffer *)renderBufferForAttachment:(GLenum)attachment{
    return self.renderbuffers[@(attachment)];
}

- (void)bindRenderbufferToColor0:(JCGLRenderbuffer *)renderbuffer{
    [self bindRenderbuffer:renderbuffer attachment:GL_COLOR_ATTACHMENT0];
    
}

- (void)bindRenderbuffer:(JCGLRenderbuffer *)renderbuffer attachment:(GLenum)attachment{
    if ([self renderBufferForAttachment:attachment] == renderbuffer) {
        return ;
    }
    
    [self bind];
    [renderbuffer bind];
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, attachment, GL_RENDERBUFFER, renderbuffer.renderbuffer);
    self.renderbuffers[@(attachment)] = renderbuffer;
}

- (void)bindTexture:(JCGLTexture *)texture attachment:(GLenum)attachment{
    [self bindTexture:texture attachment:attachment level:0];
}

- (void)bindTexture:(JCGLTexture *)texture attachment:(GLenum)attachment level:(GLint)level{
    [self bind];
    [texture bind];
    glFramebufferTexture2D(GL_FRAMEBUFFER, attachment, GL_TEXTURE_2D, texture.texture, level);
}

- (void)dealloc{
    if (_framebuffer) {
        glDeleteFramebuffers(1, &_framebuffer);
        _framebuffer = 0;
    }
}

@end
