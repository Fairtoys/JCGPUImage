//
//  JCGLTexture.h
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
NS_ASSUME_NONNULL_BEGIN

@interface JCGLTexture : NSObject

@property (nonatomic, assign) GLuint texture;

@property (nonatomic, assign) GLsizei width;
@property (nonatomic, assign) GLsizei height;


- (void)bind;

@end


NS_ASSUME_NONNULL_END
