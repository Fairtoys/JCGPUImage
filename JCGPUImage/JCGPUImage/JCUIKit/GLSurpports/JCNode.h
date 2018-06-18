//
//  JCNode.h
//  JCGPUImage
//
//  Created by huajiao on 2018/6/14.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCNode : NSObject

@property (nonatomic, weak) JCNode *superNode;

@property (nonatomic, assign) GLKVector2 size;

@property (nonatomic, assign) GLKVector4 center;
@property (nonatomic, assign) GLKMatrix4 matrix;

@property (nonatomic, strong) NSMutableArray <JCNode *> *childNodes;
- (void)addSubNode:(JCNode *)subNode;
- (void)visit;
- (void)update;
- (void)draw;

@end

NS_ASSUME_NONNULL_END
