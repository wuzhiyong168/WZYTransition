//
//  WZYPopTransition.m
//  WZYTransition
//
//  Created by isec on 2018/9/7.
//  Copyright © 2018年 isec. All rights reserved.
//

#import "WZYPopTransition.h"
#import "UIViewController+WZYTransition.h"
#import "UIView+Extension.h"

@implementation WZYPopTransition

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *sourceView = [fromVC WZYTransitionView];
    UIView *targetView = [toVC WZYTransitionView];

    if (([sourceView isKindOfClass:[UIView class]]&&[targetView isKindOfClass:[UIView class]])==NO) {
        [transitionContext completeTransition:YES];
        return;
    }
    UIView *containView = [transitionContext containerView];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    [containView addSubview:toView];

    UIColor *defaultColor = containView.backgroundColor;
    containView.backgroundColor = [UIColor whiteColor];


    UIView *snapView = [sourceView snapshotViewAfterScreenUpdates:NO];
    CGPoint snapOrigin = [sourceView convertPoint:CGPointZero toView:nil];
    snapView.origin = snapOrigin;
    [containView addSubview:snapView];


    CGRect targetRect = [targetView convertRect:CGRectZero toView:nil];
    CGFloat widthScale = targetView.width/snapView.width;
    CGFloat heightScale = targetView.height/snapView.height;
    
    targetView.hidden = YES;
    toView.alpha = 0;
    fromView.hidden = YES;

    [UIView animateWithDuration:0.3 animations:^{
        snapView.transform = CGAffineTransformMakeScale(widthScale, heightScale);
        snapView.origin = targetRect.origin;
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        fromView.hidden = NO;
        [transitionContext containerView].backgroundColor = defaultColor;
        [snapView removeFromSuperview];
        targetView.hidden = NO;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}


@end
