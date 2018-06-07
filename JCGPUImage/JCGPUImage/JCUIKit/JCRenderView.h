//
//  JCRenderView.h
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JCGLRenderbuffer;
@class JCGLFramebuffer;

@interface JCRenderView : UIView

@property (nonatomic, strong) JCGLRenderbuffer *renderbuffer;

@property (nonatomic, readonly) CAEAGLLayer *glLayer;

- (void)setFramebuffer:(JCGLFramebuffer *)framebuffer;

- (void)presentRenderbuffer;

@end

NS_ASSUME_NONNULL_END
