//
//  LoadingView.m
//  devinsantos
//
//  Created by Fernando Ribeiro on 10/19/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import "LoadingView.h"
#import <QuartzCore/QuartzCore.h>

@interface LoadingView ()

@end

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *border = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        border.image = [UIImage imageNamed:@"border"];
        UIImageView *center = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        center.image = [UIImage imageNamed:@"center"];
        
        [self addSubview:border];
        [self addSubview:center];
        
        CABasicAnimation *fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        fullRotation.fromValue = [NSNumber numberWithFloat:0];
        fullRotation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
        fullRotation.duration = 1.5;
        fullRotation.repeatCount = 1e100f;
        [center.layer addAnimation:fullRotation forKey:@"360"];
    }
    return self;
}

- (void)showOnView:(UIView *)view animated:(BOOL)animated
{
    [self showOnView:view frame:CGRectMake(140, 200, view.bounds.size.width, view.bounds.size.height) animated:animated];
}

- (void)showOnView:(UIView *)view frame:(CGRect)frame animated:(BOOL)animated
{
    [self showOnView:view frame:frame belowSubview:nil animated:animated];
}

- (void)showOnView:(UIView *)view frame:(CGRect)frame belowSubview:(UIView *)subview animated:(BOOL)animated
{
    self.frame = frame;
    self.alpha = 0;
    
    if (subview == nil) {
        [view addSubview:self];
    }
    else {
        [view insertSubview:self belowSubview:subview];
    }
    
    void (^animations)(void) = ^{ 
        self.alpha = 1;
    };
    
    if (animated) {
        [UIView animateWithDuration:0.3 animations:animations];
    }
    else {
        animations();
    }
}

- (void)hideAnimated:(BOOL)animated
{
    void (^animations)(void) = ^{ 
        self.alpha = 0;
    };
    
    void (^completion)(BOOL) = ^(BOOL finished) {
        [self removeFromSuperview];
    };
    
    if (animated) {
        [UIView animateWithDuration:0.3 animations:animations completion:completion];
    }
    else {
        animations();
        completion(YES);
    }
}

@end
