//
//  JCNode.m
//  JCGPUImage
//
//  Created by huajiao on 2018/6/14.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import "JCNode.h"




@implementation JCNode

- (NSMutableArray<JCNode *> *)childNodes{
    if (!_childNodes) {
        _childNodes = [NSMutableArray array];
    }
    return _childNodes;
}

- (void)visit{
    [self update];
    [self draw];
    
    for (JCNode *node in self.childNodes) {
        [node visit];
    }
}

- (void)update{
    
}

- (void)draw{

}




@end
