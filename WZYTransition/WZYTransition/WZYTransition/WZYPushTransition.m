//
//  WZYPushTransition.m
//  WZYTransition
//
//  Created by isec on 2018/9/7.
//  Copyright © 2018年 isec. All rights reserved.
//

#import "WZYPushTransition.h"
#import "UIViewController+WZYTransition.h"
#import "UIView+Extension.h"

@implementation WZYPushTransition

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *sourceView = [fromVC WZYTransitionView];
    UIView *targetView = [toVC WZYTransitionView];
    
    UIView *containView = [transitionContext containerView];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    [containView addSubview:toView];

    if (([sourceView isKindOfClass:[UIView class]]&&[targetView isKindOfClass:[UIView class]])==NO) {
        [transitionContext completeTransition:YES];
        return;
    }
    
    UIColor *defaultColor = containView.backgroundColor;
    containView.backgroundColor = [UIColor whiteColor];
    
    
    UIView *snapView = [sourceView snapshotViewAfterScreenUpdates:NO];
    CGPoint snapOrigin = [sourceView convertPoint:CGPointZero toView:nil];
    snapView.origin = snapOrigin;
    [containView addSubview:snapView];

    
    CGPoint targetPosition = [targetView convertPoint:CGPointZero toView:nil];
    CGFloat scaleWidth = targetView.width/snapView.width;
    CGFloat scaleHeight = targetView.height/snapView.height;
    
    
    sourceView.hidden = YES;
    toView.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        snapView.transform = CGAffineTransformMakeScale(scaleWidth, scaleHeight);
        snapView.origin = targetPosition;
        fromView.alpha = 0;
    } completion:^(BOOL finished) {
        containView.backgroundColor = defaultColor;
        fromView.alpha = 1;
        toView.hidden = NO;
        [snapView removeFromSuperview];
        sourceView.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
