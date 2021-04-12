//
//  UIView+OxmExtensions.m
//  OpenXSDKCore
//
//  Copyright © 2018 OpenX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+OxmExtensions.h"

#import "OXMLog.h"

@implementation UIView (OxmExtensions)


#pragma mark - OxmExtensions

- (void)OXMAddFillSuperviewConstraints {
    if (!self.superview) {
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    NSArray* constraints = @[width, height, centerX, centerY];
    [self activateConstraints:constraints];
    [self.superview addConstraints:constraints];
}

- (void)OXMAddConstraintsFromCGRect:(CGRect)rect {
    if (!self.superview) {
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:rect.size.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:rect.size.height];
    NSLayoutConstraint *x = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:rect.origin.x];
    NSLayoutConstraint *y = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:rect.origin.y];
    
    NSArray *constraints = @[width, height, x, y];
    [self activateConstraints:constraints];
    [self.superview addConstraints:constraints];
}

- (void)OXMAddCropAndCenterConstraintsWithInitialWidth:(CGFloat)initialWidth initialHeight:(CGFloat)initialHeight {
    if (!self.superview) {
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = false;

    //Required Priority: Centering
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    //Required Priority: "Be smaller than superView dimensions"
    NSLayoutConstraint *smallerThanSuperviewWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.superview attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    NSLayoutConstraint *smallerThanSuperviewHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.superview attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    
    //High Priority: "Be no greater than initial dimensions"
    NSLayoutConstraint *noLargerThanInitialWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:initialWidth];
    noLargerThanInitialWidth.priority = 750;
    
    NSLayoutConstraint *noLargerThanInitialHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:initialHeight];
    noLargerThanInitialHeight.priority = 750;

    NSArray *constraints = @[centerX, centerY, smallerThanSuperviewWidth, smallerThanSuperviewHeight, noLargerThanInitialWidth, noLargerThanInitialHeight];
    [self activateConstraints:constraints];
    [self.superview addConstraints:constraints];
}

- (void)OXMAddBottomRightConstraintsWithMarginSize:(CGSize)marginSize {
    if (!self.superview) {
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:marginSize.width];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:marginSize.height];

    NSArray *constraints = @[right, bottom];
    [self activateConstraints:constraints];
    [self.superview addConstraints:constraints];
}

- (void)OXMAddBottomRightConstraintsWithViewSize:(CGSize)viewSize marginSize:(CGSize)marginSize {
    if (!self.superview) {
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:viewSize.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:viewSize.height];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:marginSize.width];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:marginSize.height];
    
    NSArray *constraints = @[width, height, right, bottom];
    [self activateConstraints:constraints];
    [self.superview addConstraints:constraints];
}

- (void)OXMAddBottomLeftConstraintsWithViewSize:(CGSize)viewSize marginSize:(CGSize)marginSize{
    if (!self.superview) {
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:viewSize.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:viewSize.height];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:marginSize.width];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:marginSize.height];
    
    NSArray *constraints = @[width, height, left, bottom];
    [self activateConstraints:constraints];
    [self.superview addConstraints:constraints];
}

- (void)OXMAddTopRightConstraintsWithViewSize:(CGSize)viewSize marginSize:(CGSize)marginSize {
    if (!self.superview) {
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = false;

    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:viewSize.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:viewSize.height];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:marginSize.width];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:marginSize.height];
    
    NSArray *constraints = @[width, height, right, top];
    [self activateConstraints:constraints];
    [self.superview addConstraints:constraints];
}

- (void)OXMAddTopLeftConstraintsWithViewSize:(CGSize)viewSize marginSize:(CGSize)marginSize {
    if (!self.superview) {
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:viewSize.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:viewSize.height];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:marginSize.width];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:marginSize.height];
    
    NSArray * constraints = @[width, height, left, top];
    [self activateConstraints:constraints];
    [self.superview addConstraints:constraints];
}
- (void)OXMLogViewHierarchy {
    OXMLogInfo(@"**********LOGGING VIEW HIERARCHY**********");
    [self logViewHierarchyForView:self depth:0];
}

#pragma mark - Internal Methods

- (void)logViewHierarchyForView:(UIView *)view depth:(NSInteger) depth {
    NSString *prefix = [NSString new];
    for (int i = 0; i < depth; ++i) {
        prefix = [prefix stringByAppendingString:@"-"];
    }
    
    OXMLogInfo(@"%@view = %@ view.constraints: %@", prefix, view, view.constraints);
    
    for (UIView *subview in view.subviews) {
        [self logViewHierarchyForView:subview depth:(depth + 1)];
    }
}

- (void)activateConstraints: (NSArray*)constraints {
    for (id item in constraints) {
        NSLayoutConstraint *constraint = (NSLayoutConstraint *)item;
        [constraint setActive:YES];
    }
}

- (BOOL)oxaIsVisible {
    if (self.hidden || self.alpha == 0 || self.window == nil) {
        return NO;
    }
    return [self oxmIsVisibleInViewLegacy:self.superview];
}

- (BOOL)oxmIsVisibleInView:(UIView *)inView {
    return self.viewExposure.exposureFactor > 0;
}

- (BOOL)oxmIsVisibleInViewLegacy:(UIView *)inView {
    if (!inView) {
        return YES;
    }
    
    if (inView.superview == inView.window && inView.superview.subviews.count > 1) {
        /*
         We've reached the top of our view hierarchy
          
         We need to check that there is no any other visible hierarchy above the tested one
         UIWindow
           |   |
           |   |-- UIView
           |           |-> ... -> inView <-- the tested view
           |-------UIView
                       |-> ... -> UIView <- an hierarhy above the tested one (f.e. modal view)
         
         Walk through views in the reverse order while a visible not found or the tested reached
         */
        for(UIView *view in inView.superview.subviews.reverseObjectEnumerator) {
            if (view == inView) {
                //There are no visible view hierarhies above the tested one
                break;
            }
            if ([view isSubTreeViewVisible]) {
                return false;
            }
        }
    }
    
    CGRect viewFrame = [inView convertRect:self.bounds fromView:self];
    if (CGRectIntersectsRect(viewFrame, inView.bounds)) {
        return [self oxmIsVisibleInViewLegacy:inView.superview];
    }
    
    return NO;
}

- (BOOL)isSubTreeViewVisible {
    if (!self.isHidden && self.alpha > 0 && !CGSizeEqualToSize(self.bounds.size, CGSizeZero)) {
        return YES;
    }
    
    for(UIView *view in self.subviews) {
        if ([view isSubTreeViewVisible]) {
            return YES;
        }
    }
    
    return NO;
}


@end
