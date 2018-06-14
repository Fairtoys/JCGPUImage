//
//  JCNode.h
//  JCGPUImage
//
//  Created by huajiao on 2018/6/14.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCNode : NSObject

@property (nonatomic, strong) NSMutableArray <JCNode *> *childNodes;

- (void)draw;

@end

NS_ASSUME_NONNULL_END
