
#import "Utility.h"


#define kBlackViewTag 3333
+(void)showBlackInView:(UIView *)view{
    UIView *blackView = [[UIView alloc] initWithFrame:view.bounds];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.5;
    blackView.tag = kBlackViewTag;
    [view addSubview:blackView];
    [[self class] showIndicatorForView:view];
}

+(void)dismissBlackInView:(UIView *)view{
    [[view subviewWithTag:kBlackViewTag] removeFromSuperview];
    [[self class] hideIndicatorForView:view];
}

#define kTagIndicator 30
+(void)showIndicatorForView:(UIView *)view{
    [Utility showIndicatorForView:view point:CGPointMake((view.width-20)/2, (view.height-20)/2)];
}

+(void)showIndicatorForView:(UIView *)view point:(CGPoint)point{
    if(!view) return;
    
    UIActivityIndicatorViewStyle style = UIActivityIndicatorViewStyleGray;
    [Utility showIndicatorForView:view point:point indicatorStyle:style];
}

+(void)showIndicatorForView:(UIView *)view indicatorStyle:(UIActivityIndicatorViewStyle)style{
    [Utility showIndicatorForView:view point:CGPointMake((view.width-20)/2, (view.height-20)/2) indicatorStyle:style];
}

+(void)showIndicatorForView:(UIView *)view point:(CGPoint)point indicatorStyle:(UIActivityIndicatorViewStyle)style{
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[view subviewWithTag:kTagIndicator];
    
    if (!indicator) {
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        indicator.frame = CGRectMake(point.x, point.y, 20, 20);
        indicator.tag = kTagIndicator;
        indicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        [view addSubview:indicator];
        [indicator startAnimating];
    }
    
    [indicator startAnimating];
}

+(void)hideIndicatorForView:(UIView *)view{
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[view subviewWithTag:kTagIndicator];
    
    if(indicator){
        if ([indicator isKindOfClass:[UIActivityIndicatorView class]]) {
            [indicator stopAnimating];
            [indicator removeFromSuperview]; indicator = nil;
            return;
        }
        
        NSAssert([indicator isMemberOfClass:[UIActivityIndicatorView class]], @"indicator view错误,重复tag 2");
    }
}

@end

