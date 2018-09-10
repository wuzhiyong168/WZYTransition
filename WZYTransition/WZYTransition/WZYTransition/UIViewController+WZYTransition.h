//
//  UIViewController+WZYTransition.h
//  WZYTransition
//
//  Created by isec on 2018/9/7.
//  Copyright © 2018年 isec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WZYTransition)

@property (nonatomic, assign) BOOL haveTransitionAnimation;

- (UIView *)WZYTransitionView;

@end

@interface UINavigationController (WZYPush)
- (void)WZY_PushViewController:(UIViewController *)viewController popGesture:(BOOL)popGesture;
@end
