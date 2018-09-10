//
//  UIViewController+WZYTransition.m
//  WZYTransition
//
//  Created by isec on 2018/9/7.
//  Copyright © 2018年 isec. All rights reserved.
//

#import "UIViewController+WZYTransition.h"
#import "WZYNavigationTransitionDelegate.h"
#import <objc/runtime.h>

static char * const transitionAnimationKey = "WZYTransitionAnimationKey";

@implementation UIViewController (WZYTransition)

- (void)setHaveTransitionAnimation:(BOOL)haveTransitionAnimation {
    objc_setAssociatedObject(self, transitionAnimationKey, @(haveTransitionAnimation), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)haveTransitionAnimation {
    return [objc_getAssociatedObject(self, transitionAnimationKey) boolValue];
}

- (UIView *)WZYTransitionView {
    return nil;
}

@end

@implementation UINavigationController (WZYPush)

- (void)WZY_PushViewController:(UIViewController *)viewController popGesture:(BOOL)popGesture {
    [WZYNavigationTransitionDelegate shareInstance].navigationController = self;

    viewController.haveTransitionAnimation = YES;
    if (self.delegate!=[WZYNavigationTransitionDelegate shareInstance]) {
        [WZYNavigationTransitionDelegate shareInstance].delegate = self.delegate;
        self.delegate = [WZYNavigationTransitionDelegate shareInstance];
    }
    if (popGesture) {
        UIScreenEdgePanGestureRecognizer *ges = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:[WZYNavigationTransitionDelegate shareInstance] action:@selector(edgeGestureAction:)];
        ges.edges = UIRectEdgeLeft;
        [viewController.view addGestureRecognizer:ges];
    }
    [self pushViewController:viewController animated:YES];
}

@end
