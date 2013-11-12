	@interface Utility : NSObject

+ (void)showAutoHintTips:(NSString *)string;
+(void)showBlackInView:(UIView *)view;
+(void)dismissBlackInView:(UIView *)view;
+(void)showIndicatorForView:(UIView *)view;
+(void)showIndicatorForView:(UIView *)view indicatorStyle:(UIActivityIndicatorViewStyle)style;
+(void)hideIndicatorForView:(UIView *)view;


- (void) showAutoHintTips:(NSString *)string;
@end