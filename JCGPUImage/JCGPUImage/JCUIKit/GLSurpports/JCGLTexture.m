//
//  JCGLTexture.m
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import "JCGLTexture.h"
#import <OpenGLES/ES2/glext.h>
#import "JCGLFramebuffer.h"

@implementation JCGLTexture

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        glGenTextures(1, &_texture);
    }
    return self;
}

- (void)dealloc{
    if (_texture) {
        glDeleteTextures(1, &_texture);
        _texture = 0;
    }
}


- (void)bind{
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _texture);
    
}

- (void)setTextureParameters{
    [self bind];
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    // This is necessary for non-power-of-two textures
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, self.width, self.height, 0, GL_BGRA, GL_UNSIGNED_BYTE, 0);
}



@end

