//
//  WZYNavigationTransitionDelegate.m
//  WZYTransition
//
//  Created by isec on 2018/9/10.
//  Copyright © 2018年 isec. All rights reserved.
//

#import "WZYNavigationTransitionDelegate.h"
#import "UIViewController+WZYTransition.h"
#import "WZYPushTransition.h"
#import "WZYPopTransition.h"

@interface WZYNavigationTransitionDelegate () {
    BOOL _isPop;
}

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentTransition;

@end

@implementation WZYNavigationTransitionDelegate

+ (instancetype)shareInstance {
    static WZYNavigationTransitionDelegate *_transitionDelegate = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _transitionDelegate = [[WZYNavigationTransitionDelegate alloc] init];
    });
    
    return _transitionDelegate;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    _isPop = NO;
    if (operation==UINavigationControllerOperationPush) {
        if (!toVC.haveTransitionAnimation) {
            return nil;
        }
        return [WZYPushTransition new];
    } else if (operation==UINavigationControllerOperationPop) {
        if (!fromVC.haveTransitionAnimation) {
            return nil;
        }
        _isPop = YES;
        return [WZYPopTransition new];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return _isPop?self.percentTransition:nil;
}

- (void)edgeGestureAction:(UIScreenEdgePanGestureRecognizer *)gesture {
    CGFloat rate = [gesture translationInView:[[UIApplication sharedApplication] keyWindow]].x / [UIScreen mainScreen].bounds.size.width;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.percentTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.percentTransition updateInteractiveTransition:rate];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        if (rate>0.4) {
            [self.percentTransition finishInteractiveTransition];
        } else {
            [self.percentTransition cancelInteractiveTransition];
        }
        self.percentTransition = nil;
    } else {
        [self.percentTransition cancelInteractiveTransition];
        self.percentTransition = nil;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.delegate && self.delegate !=self && [self.delegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        [self.delegate navigationController:navigationController willShowViewController:viewController animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.delegate && self.delegate !=self && [self.delegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [self.delegate navigationController:navigationController didShowViewController:viewController animated:animated];
    }
}

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController
{
    if (self.delegate && self.delegate !=self && [self.delegate respondsToSelector:@selector(navigationControllerSupportedInterfaceOrientations:)]) {
        return [self.delegate navigationControllerSupportedInterfaceOrientations:navigationController];
    }
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController
{
    if (self.delegate && self.delegate !=self && [self.delegate respondsToSelector:@selector(navigationControllerPreferredInterfaceOrientationForPresentation:)]) {
        return [self.delegate navigationControllerPreferredInterfaceOrientationForPresentation:navigationController];
    }
    return UIInterfaceOrientationUnknown;
}

@end
