//
//  PBMNativeAdUIDelegate.h
//  OpenXSDKCore
//
//  Copyright © 2021 OpenX. All rights reserved.
//

@import UIKit;

@class NativeAd;

NS_ASSUME_NONNULL_BEGIN

@protocol PBMNativeAdUIDelegate <NSObject>

@required
/*!
 @abstract Asks the delegate for a view controller instance to use for presenting modal views
 as a result of user interaction on an ad. Usual implementation may simply return self,
 if it is view controller class.
 */
- (nullable UIViewController *)viewPresentationControllerForNativeAd:(NativeAd *)nativeAd;

@optional

/*!
 @abstract Notifies the delegate whenever current app goes in the background due to user click.
 @param nativeAd The PBMNativeAd instance sending the message.
 */
- (void)nativeAdWillLeaveApplication:(NativeAd *)nativeAd;

/*!
 @abstract Notifies delegate that the native ad will launch a modal
 on top of the current view controller, as a result of user interaction.
 @param nativeAd The PBMNativeAd instance sending the message.
 */
- (void)nativeAdWillPresentModal:(NativeAd *)nativeAd;

/*!
 @abstract Notifies delegate that the native ad has dismissed the modal on top of
 the current view controller.
 @param nativeAd The PBMNativeAd instance sending the message.
 */
- (void)nativeAdDidDismissModal:(NativeAd *)nativeAd;

@end

NS_ASSUME_NONNULL_END