//
//  JCGLProgram.h
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
NS_ASSUME_NONNULL_BEGIN

@interface JCGLProgram : NSObject

- (instancetype)initWithVertexShaderString:(NSString *)vShaderString
            fragmentShaderString:(NSString *)fShaderString;
- (instancetype)initWithVertexShaderString:(NSString *)vShaderString
          fragmentShaderFilename:(NSString *)fShaderFilename;
- (instancetype)initWithVertexShaderFilename:(NSString *)vShaderFilename
            fragmentShaderFilename:(NSString *)fShaderFilename;

@property (nonatomic, assign) GLuint program;
@property (nonatomic, assign) GLuint vertShader;
@property (nonatomic, assign) GLuint fragShader;

@property(strong, nonatomic) NSString *vertexShaderLog;
@property(strong, nonatomic) NSString *fragmentShaderLog;
@property(strong, nonatomic) NSString *programLog;


- (BOOL)link;
- (void)use;
- (void)validate;

@property (nonatomic, strong) NSMutableArray <NSString *> *attributes;
@property (nonatomic, strong) NSMutableArray <NSString *> *uniforms;
- (void)addAttribute:(NSString *)attributeName;
- (GLuint)attributeIndex:(NSString *)attributeName;
- (GLuint)uniformIndex:(NSString *)uniformName;

@end

NS_ASSUME_NONNULL_END
