//
//  FirstDetailViewController.m
//  WZYTransition
//
//  Created by isec on 2018/9/7.
//  Copyright © 2018年 isec. All rights reserved.
//

#import "FirstDetailViewController.h"
#import "WZYPopTransition.h"

@interface FirstDetailViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;
@end

@implementation FirstDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.title  =@"FirstDetailVC";
    [self.view addSubview:self.imageView];
    
    self.navigationController.delegate = self;
    
    UIScreenEdgePanGestureRecognizer *ges = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(popGestureAction:)];
    ges.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:ges];
}

- (void)popGestureAction:(UIScreenEdgePanGestureRecognizer *)gesture {
    CGFloat rate = [gesture translationInView:[[UIApplication sharedApplication] keyWindow]].x / [UIScreen mainScreen].bounds.size.width;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.interactiveTransition updateInteractiveTransition:rate];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        if (rate>0.4) {
            [self.interactiveTransition finishInteractiveTransition];
        } else {
            [self.interactiveTransition cancelInteractiveTransition];
        }
        self.interactiveTransition = nil;
    } else {
        [self.interactiveTransition cancelInteractiveTransition];
        self.interactiveTransition = nil;
    }
}
#pragma mark ----UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation==UINavigationControllerOperationPop) {
        return [[WZYPopTransition alloc] init];
    }
    return nil;
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[WZYPopTransition class]]) {
        return self.interactiveTransition;
    }
    return nil;
}

#pragma mark ----transitionView
- (UIView *)WZYTransitionView {
    return self.imageView;
}

#pragma mark ---lazy load
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 160)];
        _imageView.image = _image;
    }
    return _imageView;
}

@end
