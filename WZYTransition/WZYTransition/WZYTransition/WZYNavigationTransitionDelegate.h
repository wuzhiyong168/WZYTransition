//
//  WZYNavigationTransitionDelegate.h
//  WZYTransition
//
//  Created by isec on 2018/9/10.
//  Copyright © 2018年 isec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZYNavigationTransitionDelegate : NSObject<UINavigationControllerDelegate>

@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, weak) id <UINavigationControllerDelegate> delegate;

+ (instancetype)shareInstance;
- (void)edgeGestureAction:(UIScreenEdgePanGestureRecognizer *)gesture;

@end
