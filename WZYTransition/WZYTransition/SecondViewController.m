//
//  SecondViewController.m
//  WZYTransition
//
//  Created by isec on 2018/9/7.
//  Copyright © 2018年 isec. All rights reserved.
//

#import "SecondViewController.h"
#import "UIViewController+WZYTransition.h"
#import "SecondDetailViewController.h"

@interface SecondViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"SecondVC";
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(120, 140, 40, 60)];
    blueView.backgroundColor = [UIColor redColor];
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
    [self.navigationController WZY_PushViewController:firstDetailVC popGesture:YES];
}


#pragma mark ----get
- (UIView *)WZYTransitionView {
    return self.imageView;
}

#pragma mark ---lazy load
- (UIImageView *)imageView {
    if (!_imageView) {
        CGFloat width = self.view.frame.size.width/2;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2, 20, width, 100)];
        _imageView.image = [UIImage imageNamed:@"123"];
    }
    return _imageView;
}


@end
