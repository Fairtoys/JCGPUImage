//
//  JCGLFramebuffer.h
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JCFramebufferAttachProtocol;
@class JCGLRenderbuffer;
@class JCGLTexture;


@interface JCGLFramebuffer : NSObject

@property (nonatomic, assign)  GLuint framebuffer;

- (void)bind;

- (void)clear;

- (void)render;

- (nullable JCGLRenderbuffer *)renderBufferForColor0;
- (nullable JCGLRenderbuffer *)renderBufferForAttachment:(GLenum)attachment;
- (void)bindRenderbufferToColor0:(JCGLRenderbuffer *)renderbuffer;
- (void)bindRenderbuffer:(JCGLRenderbuffer *)renderbuffer attachment:(GLenum)attachment;
- (void)bindTexture:(JCGLTexture *)texture attachment:(GLenum)attachment;
- (void)bindTexture:(JCGLTexture *)texture attachment:(GLenum)attachment level:(GLint)level;

@end

NS_ASSUME_NONNULL_END
