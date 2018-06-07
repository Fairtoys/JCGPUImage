//
//  JCGLContext.h
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGLDrawable.h>
NS_ASSUME_NONNULL_BEGIN

@interface JCGLContext : NSObject

+ (instancetype)sharedContext;

@property (nonatomic, strong) EAGLContext *context;
- (void)setContextToCurrentContext;

@end

NS_ASSUME_NONNULL_END
