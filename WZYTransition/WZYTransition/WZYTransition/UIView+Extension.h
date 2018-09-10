
#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic,assign) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic,assign) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic,assign) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic,assign) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic,assign) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic,assign) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic,assign) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic,assign) CGFloat centerY;
/**
 * Shortcut for frame.origin
 */
@property (nonatomic,assign) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic,assign) CGSize size;

//找到自己的vc
- (UIViewController *)viewController;


- (UIViewController *)superviewcontroller;

#pragma mark - Border radius
/**
 *  @brief 设置圆角
 */
- (void)rounded:(CGFloat)cornerRadius;
- (void)roundedHalfHeight;
- (void)roudedRightAndHalfHeight;
/**
 *  @brief 设置圆角和边框
 */
- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**
 *  @brief 设置边框
 */
- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor;


/** 更新约束 */
-(void)updateViewContraint:(NSLayoutAttribute)attribute value:(CGFloat)value;

+ (UIView *)createLineWithFrame:(CGRect)frame color:(UIColor *)color;

@end

