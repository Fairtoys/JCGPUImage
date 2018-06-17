//
//  JCGLRenderbuffer.h
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface JCGLRenderbuffer : NSObject

@property (nonatomic,assign, readonly) GLint widthInPixel;
@property (nonatomic,assign, readonly) GLint heightInPixel;

@property (nonatomic, assign) GLuint renderbuffer;

- (void)bind;

- (void)setRenderBufferStorageForDrawable:(id <EAGLDrawable>)drawable;
- (void)presentRenderBuffer;

@end


NS_ASSUME_NONNULL_END
