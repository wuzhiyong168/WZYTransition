//
//  FirstViewController.m
//  WZYTransition
//
//  Created by isec on 2018/9/7.
//  Copyright © 2018年 isec. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstDetailViewController.h"
#import "WZYPushTransition.h"

@interface FirstViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"FirstVC";
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(20, 200, 80, 80)];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    [self.view addSubview:self.imageView];
    
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageViewAction)];
    [self.imageView addGestureRecognizer:tap];
}

#pragma mark ---click action
- (void)clickImageViewAction {
    FirstDetailViewController *firstDetailVC = [[FirstDetailViewController alloc] init];
    firstDetailVC.image = self.imageView.image;
    self.navigationController.delegate = self;
    [self.navigationController pushViewController:firstDetailVC animated:YES];
}
#pragma mark ----UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation==UINavigationControllerOperationPush) {
        return [[WZYPushTransition alloc] init];
    }
    return nil;
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
