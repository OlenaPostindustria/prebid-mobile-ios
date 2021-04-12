//
//  OXMAdViewButtonDecorator.m
//  OpenXSDKCore
//
//  Copyright © 2018 OpenX. All rights reserved.
//

#import "OXMAdViewButtonDecorator.h"
#import "OXMFunctions+Private.h"
#import "OXMMacros.h"

#pragma mark - Private Interface

@interface OXMAdViewButtonDecorator()

@property (nonatomic, weak) UIView *displayView;
@property (nonatomic, strong) UIImage *buttonImage;
@property (nonatomic, strong) NSArray *activeConstraints;

@end

#pragma mark - Implementation

@implementation OXMAdViewButtonDecorator

- (instancetype)init {
    self = [super init];
    if (self) {
        self.button = [[UIButton alloc] init];
        self.customButtonPosition = CGRectZero;
        self.buttonPosition = OXMPositionTopRight;
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    self.buttonImage = image;
    [self.button setImage:self.buttonImage forState:UIControlStateNormal];
}

- (void)addButtonToView:(UIView *)view displayView:(UIView *)displayView {
    self.displayView = displayView;
    
    if (!view || !self.displayView) {
        OXMLogError(@"Attempted to display a nil view");
        return;
    }
    
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.button addTarget:self action:@selector(buttonTappedAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.button];
    [self updateButtonConstraints];
}

- (void)removeButtonFromSuperview {
    [self.button removeFromSuperview];
}

- (void)bringButtonToFront {
    [self.button.superview bringSubviewToFront:self.button];
}

- (void)sendSubviewToBack {
    [self.button.superview sendSubviewToBack:self.button];
}

- (void)updateButtonConstraints {
    [self.button.superview removeConstraints:self.activeConstraints];
    self.activeConstraints = [self createButtonConstraints];
    [self.button.superview addConstraints:self.activeConstraints];
}

#pragma mark - Internal Methods

- (NSArray *)createButtonConstraints {
    
    NSArray *constraints;
    
    NSInteger constant = [self getButtonConstraintConstant];
    CGSize size = [self getButtonSize];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:size.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:size.height];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.displayView attribute:NSLayoutAttributeTop multiplier:1.0 constant:constant];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.displayView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-constant];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.displayView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.displayView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-constant];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.displayView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:constant];
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.displayView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    
    switch (self.buttonPosition) {
        case OXMPositionTopLeft:
            constraints = [NSArray arrayWithObjects:width, height, top, left, nil];
            break;
            
        case OXMPositionTopRight:
            constraints = [NSArray arrayWithObjects:width, height, top, right, nil];
            break;
            
        case OXMPositionTopCenter:
            constraints = [NSArray arrayWithObjects:width, height, top, centerX, nil];
            break;
            
        case OXMPositionCenter:
            constraints = [NSArray arrayWithObjects:width, height, centerY, centerX, nil];
            break;
            
        case OXMPositionBottomLeft:
            constraints = [NSArray arrayWithObjects:width, height, bottom, left, nil];
            break;
            
        case OXMPositionBottomRight:
            constraints = [NSArray arrayWithObjects:width, height, bottom, right, nil];
            break;
            
        case OXMPositionBottomCenter:
            constraints = [NSArray arrayWithObjects:width, height, bottom, centerX, nil];
            break;
            
        case OXMPositionCustom: {
            
            NSLayoutConstraint *customWidth     = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.customButtonPosition.size.width];
            NSLayoutConstraint *customHeight    = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.customButtonPosition.size.height];
            NSLayoutConstraint *customTop       = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.displayView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.customButtonPosition.origin.y];
            NSLayoutConstraint *customLeft      = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.displayView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.customButtonPosition.origin.x];
            
            constraints = [NSArray arrayWithObjects:customWidth, customHeight, customTop, customLeft, nil];
        } break;
            
        default: break;
    }
    
    return constraints;
}

- (NSInteger)getButtonConstraintConstant {
    // Override button padding
    return 10;
}

- (CGSize)getButtonSize {
    // Override button size, if needed
    return self.buttonImage ? self.buttonImage.size : CGSizeMake(10, 10);
}

- (void)buttonTappedAction {
    // Override button action, if needed
    if (self.buttonTouchUpInsideBlock) {
        self.buttonTouchUpInsideBlock();
    }
}

@end
