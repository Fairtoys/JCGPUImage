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
@property (nonatomic, strong) JCGLFramebuffer *framebuffer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.renderView atIndex:0];
    [self.renderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self setup];
}

- (void)setup{
    [JCGLContext sharedContext].currentFramebuffer = self.framebuffer;
    [self.framebuffer bindRenderbufferToColor0:self.renderView.renderbuffer];
}

- (JCRenderView *)renderView{
    if (!_renderView) {
        _renderView = [[JCRenderView alloc] init];
    }
    return _renderView;
}

- (JCGLFramebuffer *)framebuffer{
    if (!_framebuffer) {
        _framebuffer = [[JCGLFramebuffer alloc] init];
    }
    return _framebuffer;
}

- (IBAction)onClickRenderButton:(id)sender {
 
    [[JCGLContext sharedContext] drawFrame];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
