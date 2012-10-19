//
//  LoadingView.h
//  devinsantos
//
//  Created by Fernando Ribeiro on 10/19/12.
//  Copyright (c) 2012 Fernando Bass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

- (void)showOnView:(UIView *)view animated:(BOOL)animated;
- (void)showOnView:(UIView *)view frame:(CGRect)frame animated:(BOOL)animated;
- (void)showOnView:(UIView *)view frame:(CGRect)frame belowSubview:(UIView *)subview animated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated;

@end
