//
//  JCGLRenderbuffer.h
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import "JCFramebufferAttachProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface JCGLRenderbuffer : NSObject

@property (nonatomic, assign) GLuint renderbuffer;

- (void)bind;

@end

@interface JCGLRenderbuffer (JCFramebufferAttachProtocol) <JCFramebufferAttachProtocol>

@end

NS_ASSUME_NONNULL_END
