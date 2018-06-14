//
//  JCRenderView.m
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import "JCRenderView.h"
#import "JCGLRenderbuffer.h"
#import "JCGLContext.h"
#import "JCGLFramebuffer.h"

@implementation JCRenderView

+ (Class)layerClass{
    return [CAEAGLLayer class];
}

- (CAEAGLLayer *)glLayer{
    return (CAEAGLLayer *)self.layer;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.glLayer.opaque = YES;
    self.glLayer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking : @(NO),kEAGLDrawablePropertyColorFormat : kEAGLColorFormatRGBA8};
}

- (void)setBounds:(CGRect)bounds{
    CGRect lastBounds = [self bounds];
    [super setBounds:bounds];
    if (!CGRectEqualToRect(lastBounds, bounds) && !CGRectEqualToRect(CGRectZero, bounds)) {
        [self setRenderbufferStorage];
    }
}

- (void)setRenderbufferStorage{
    [self.renderbuffer setRenderBufferStorageForDrawable:self.glLayer];
}

- (JCGLRenderbuffer *)renderbuffer{
    if (!_renderbuffer) {
        _renderbuffer = [[JCGLRenderbuffer alloc] init];
    }
    return _renderbuffer;
}

- (void)setFramebuffer:(JCGLFramebuffer *)framebuffer{
    [framebuffer bindToTarget:self.renderbuffer];
}

- (void)presentRenderbuffer{
    [self.renderbuffer presentRenderBuffer];
}

@end
