
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



- (void)showAutoHintTips:(NSString *)string{
    static BOOL hasShowTips;
    if(hasShowTips) return;
    
    hasShowTips = YES;
    
    CGFloat posY = floor(CGRectGetHeight(self.bounds)/2)-100;
    
    UIFont *font = [UIFont boldSystemFontOfSize:16];
    
    UIView *tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 100)];
    tipView.layer.cornerRadius = 10;
    tipView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    tipView.userInteractionEnabled = NO;
    tipView.layer.opacity = 0;
    
    UILabel *stringLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(tipView.bounds)-20, 20)];
    stringLabel.textColor = [UIColor whiteColor];
    stringLabel.backgroundColor = [UIColor clearColor];
    stringLabel.adjustsFontSizeToFitWidth = YES;
    stringLabel.textAlignment =  NSTextAlignmentCenter;
    stringLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    stringLabel.font = font;
    //    stringLabel.numberOfLines = 2;
    stringLabel.numberOfLines = 0;
    stringLabel.text = string;
    [stringLabel sizeToFit];
    stringLabel.width = tipView.width-20;
    stringLabel.shadowColor = [UIColor blackColor];
    stringLabel.shadowOffset = CGSizeMake(0, -1);
    [tipView addSubview:stringLabel];
    
    tipView.height = stringLabel.height + 20;
    
    if(![tipView isDescendantOfView:self]) {
        tipView.layer.opacity = 0;
        [self addSubview:tipView];
    }
    
    if(tipView.layer.opacity != 1) {
        
        posY+=(CGRectGetHeight(tipView.bounds)/2);
        tipView.center = CGPointMake(CGRectGetWidth(tipView.superview.bounds)/2, posY);
        
        tipView.layer.transform = CATransform3DScale(CATransform3DMakeTranslation(0, 0, 0), 1.3, 1.3, 1);
        tipView.layer.opacity = 0.3;
        
        [UIView animateWithDuration:0.15
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut
                         animations:^{
                             tipView.layer.transform = CATransform3DScale(CATransform3DMakeTranslation(0, 0, 0), 1, 1, 1);
                             tipView.layer.opacity = 1;
                         }completion:NULL];
    }
    
    [UIView animateWithDuration:0.15
                          delay:2.5
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         tipView.layer.transform = CATransform3DScale(CATransform3DMakeTranslation(0, 0, 0), 0.8, 0.8, 1.0);
                         tipView.layer.opacity = 0;
                     }completion:^(BOOL finished){
                         if(tipView.layer.opacity == 0) [tipView removeFromSuperview];
                         hasShowTips = NO;
                     }];
}


@end

