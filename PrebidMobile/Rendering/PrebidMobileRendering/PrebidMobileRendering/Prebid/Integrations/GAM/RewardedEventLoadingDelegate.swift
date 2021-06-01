//
//  RewardedEventLoadingDelegate.swift
//  PrebidMobileRendering
//
//  Copyright © 2021 Prebid. All rights reserved.
//

import Foundation

@objc public protocol RewardedEventLoadingDelegate : PBMInterstitialEventLoadingDelegate {

    /*!
     @abstract The reward to be given to the user. May be assigned on successful loading.
     */
    @objc weak var reward: NSObject? { get set }
}
