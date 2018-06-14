//
//  ViewController.m
//  JCGPUImage
//
//  Created by huajiao on 2018/6/7.
//  Copyright © 2018年 HuaJiao. All rights reserved.
//

#import "ViewController.h"
#import "JCGPUImageHeader.h"
#import <Masonry/Masonry.h>

@interface ViewController ()
@property (nonatomic, strong) JCRenderView *renderView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.renderView atIndex:0];
    [self.renderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (JCRenderView *)renderView{
    if (!_renderView) {
        _renderView = [[JCRenderView alloc] init];
    }
    return _renderView;
}

- (IBAction)onClickRenderButton:(id)sender {
    [[JCGLContext sharedContext] update];
    [[JCGLContext sharedContext] draw];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
