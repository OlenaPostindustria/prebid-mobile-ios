//
//  PBMDisplayView+InternalState.h
//  OpenXSDKCore
//
//  Copyright © 2020 OpenX. All rights reserved.
//

#ifndef PBMDisplayView_InternalState_h
#define PBMDisplayView_InternalState_h

#import "PBMDisplayView.h"

@class AdUnitConfig;
@protocol PBMServerConnectionProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface PBMDisplayView ()

@property (nonatomic, strong, readonly, nullable) id<PBMServerConnectionProtocol> connection;

- (instancetype)initWithFrame:(CGRect)frame bid:(Bid *)bid adConfiguration:(AdUnitConfig *)adConfiguration;

@end

NS_ASSUME_NONNULL_END

#endif /* PBMDisplayView_InternalState_h */