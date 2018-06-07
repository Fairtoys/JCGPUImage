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

@interface JCGLFramebuffer : NSObject

@property (nonatomic, assign)  GLuint framebuffer;

- (void)bindToTarget:(id <JCFramebufferAttachProtocol>)target;

- (void)bind;


@end

NS_ASSUME_NONNULL_END
