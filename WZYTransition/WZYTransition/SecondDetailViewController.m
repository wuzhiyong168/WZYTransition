//
//  SecondDetailViewController.m
//  WZYTransition
//
//  Created by isec on 2018/9/7.
//  Copyright © 2018年 isec. All rights reserved.
//

#import "SecondDetailViewController.h"
#import "UIViewController+WZYTransition.h"

@interface SecondDetailViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SecondDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"SecondDetailVC";
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(50, 170, 180, 180)];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    [self.view addSubview:self.imageView];
    
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageViewAction)];
    [self.imageView addGestureRecognizer:tap];
}

#pragma mark ---click action
- (void)clickImageViewAction {
    SecondDetailViewController *firstDetailVC = [[SecondDetailViewController alloc] init];
    firstDetailVC.image = self.imageView.image;
    [self.navigationController pushViewController:firstDetailVC animated:YES];
}
#pragma mark ----get
- (UIView *)WZYTransitionView {
    return self.imageView;
}

#pragma mark ---lazy load
- (UIImageView *)imageView {
    if (!_imageView) {
        CGFloat width = self.view.frame.size.width/4;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2, 60, width, 100)];
        _imageView.image = _image;
    }
    return _imageView;
}

@end
