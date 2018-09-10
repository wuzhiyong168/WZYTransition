

#import "UIView+Extension.h"


@implementation UIView (Extension)



- (CGFloat)left {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (UIViewController *)viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (UIViewController *)superviewcontroller
{
    UIViewController * controller = nil;
    
    id next = [self nextResponder];
    
    while (![next isKindOfClass:[UIViewController class]])
    {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[UIViewController class]])
    {
        controller = (UIViewController *)next;
    }
    return controller;
}


#pragma mark - Border radius

/**
 *  @brief 设置圆角
 *
 *  @param cornerRadius 圆角半径
 */
- (void)rounded:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;

}
- (void)roundedHalfHeight {
    [self rounded:self.height/2.0];
}
- (void)roudedRightAndHalfHeight {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds      byRoundingCorners:UIRectCornerTopRight| UIRectCornerBottomRight  cornerRadii:CGSizeMake(self.height/2.0, self.height/2.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/**
 *  @brief 设置圆角和边框
 *
 *  @param cornerRadius 圆角半径
 *  @param borderWidth  边框宽度
 *  @param borderColor  边框颜色
 */
- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.masksToBounds = YES;
}

/**
 *  @brief 设置边框
 *
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor
{
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.masksToBounds = YES;
}

#pragma mark - 更新约束
-(void)updateViewContraint:(NSLayoutAttribute)attribute value:(CGFloat)value{
    NSArray* constrains = self.constraints;
    for (NSLayoutConstraint* constraint in constrains) {
        if (constraint.firstAttribute == attribute) {
            constraint.constant = value;
        }
    }
}

+ (UIView *)createLineWithFrame:(CGRect)frame color:(UIColor *)color {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

@end
