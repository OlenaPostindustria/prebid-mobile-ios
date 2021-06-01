//
//  PBMAutoRefreshCountConfig.h
//  OpenXSDKCore
//
//  Copyright © 2020 OpenX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PBMAutoRefreshCountConfig <NSObject>
/**
 Delay (in seconds) for which to wait before performing an auto refresh.

 Note that this value is clamped between @c PBMAutoRefresh.AUTO_REFRESH_DELAY_MIN
 and @c PBMAutoRefresh.AUTO_REFRESH_DELAY_MAX.

 Also note that this will return @c nil if @c isInterstitial is set to @c YES.
 */
@property (nonatomic, copy, nullable) NSNumber *autoRefreshDelay;

/**
 Maximum number of times the BannerView should refresh.

 This value will be overwritten with any values received from the server.
 Using a value of 0 indicates there is no maximum.

 Default is 0.
 */
@property (nonatomic, copy, nullable) NSNumber *autoRefreshMax;

/**
 The number of times the BannerView has been refreshed.
 */
@property (nonatomic, assign) NSUInteger numRefreshes;

@end