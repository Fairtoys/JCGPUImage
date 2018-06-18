//
//  JCGLContext.h
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGLDrawable.h>
#import <OpenGLES/ES2/gl.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JCGLFramebuffer;
@class JCNode;

@interface JCGLContext : NSObject

+ (instancetype)sharedContext;

@property (nonatomic, strong) EAGLContext *context;
- (void)setContextToCurrentContext;

@property (nonatomic, strong) JCGLFramebuffer *currentFramebuffer;
@property (nonatomic, strong) JCNode *rootNode;

@property (nonatomic, assign) GLKMatrix4 projectionMatrix;

- (void)setViewPort:(GLint)x y:(GLint)y width:(GLsizei)width height:(GLsizei)height;

- (void)drawFrame;

@end

NS_ASSUME_NONNULL_END
