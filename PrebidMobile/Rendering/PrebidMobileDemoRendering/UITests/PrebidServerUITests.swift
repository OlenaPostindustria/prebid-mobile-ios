//
//  PrebidServerUITests.swift
//  OpenXInternalTestAppUITests
//
//  Copyright © 2020 OpenX. All rights reserved.
//

import XCTest

class PrebidServerUITests: AdsLoaderUITestCase {
    
    override func setUp() {
        useMockServerOnSetup = false
        super.setUp()
        
        switchToPrebidXServerIfNeeded()
    }

    // MARK: - Banner
    
    func testBanner() {
        checkBannerLoadResult(exampleName: "Banner 320x50 (PPM)")
    }
    
    func testPPMBanner_noBids() {
        checkBannerLoadResult(exampleName: "Banner 320x50 (PPM) [noBids]",
                              expectFailure: true)
    }
    
    func testGAMBanner() {
        checkBannerLoadResult(exampleName: "Banner 320x50 (GAM) [OK, AppEvent]")
    }
    
    func testGAMBanner_noBids_gamAd() {
        checkBannerLoadResult(exampleName: "Banner 320x50 (GAM) [noBids, GAM Ad]")
    }
    
    func testGAMBanner_VanillaPrebidOrder() {
        checkBannerLoadResult(exampleName: "Banner 320x50 (GAM) [Vanilla Prebid Order]")
    }
    
    func testMoPubBanner() {
        checkBannerLoadResult(exampleName: "Banner 320x50 (MoPub) [OK, OXB Adapter]",
                              adapterBased: true,
                              callbacks: mopubBannerCallbacks)
    }
    
    func testMoPubBanner_NoBids() {
        checkBannerLoadResult(exampleName: "Banner 320x50 (MoPub) [noBids, MoPub Ad]",
                              adapterBased: true,
                              callbacks: mopubBannerCallbacks)
    }
    
    func testMoPubBanner_VanillaPrebidOrder() {
           checkBannerLoadResult(exampleName: "Banner 320x50 (MoPub) [Vanilla Prebid Order]",
                                 adapterBased: true,
                                 callbacks: mopubBannerCallbacks)
    }
    
    // MARK: - MRAID
    
    func testBannerMRAID() {
        checkBannerLoadResult(exampleName: "MRAID 2.0: Resize (PPM)")
    }
    
    func testMRAID_Resize_GAM() {
        checkBannerLoadResult(exampleName: "MRAID 2.0: Resize (GAM)")
    }
    
    func testMRAID_Resize_MoPub() {
        checkBannerLoadResult(exampleName: "MRAID 2.0: Resize (MoPub)",
                                     adapterBased: true,
                                     callbacks: mopubBannerCallbacks)
    }
    
    // MARK: - Interstitials
    
    func testInterstitial_Display_320x480() {
        checkInterstitialLoadResult(exampleName: "Display Interstitial 320x480 (PPM)")
    }
    
    func testPPMInterstitial_Display_320x480_noBids() {
        checkInterstitialLoadResult(exampleName: "Display Interstitial 320x480 (PPM) [noBids]",
                                    expectFailure: true)
    }
    
    func testGAMInterstitial_Display() {
        checkInterstitialLoadResult(exampleName: "Display Interstitial 320x480 (GAM) [OK, AppEvent]")
    }
    
    func testGAMInterstitial_Display_320x480_noBids() {
        checkInterstitialLoadResult(exampleName: "Display Interstitial 320x480 (GAM) [noBids, GAM Ad]")
    }
    
    func testGAMInterstitial_Display_VanillaPrebidOrder() {
           checkInterstitialLoadResult(exampleName: "Display Interstitial 320x480 (GAM) [Vanilla Prebid Order]")
    }
    
    func testMoPubInterstitial_Display_320x480() {
        checkInterstitialLoadResult(exampleName: "Display Interstitial 320x480 (MoPub) [OK, OXB Adapter]",
                                    callbacks: mopubInterstitialCallbacks)
    }
    
    func testMoPubInterstitial_Display_320x480_NoBids() {
        checkInterstitialLoadResult(exampleName: "Display Interstitial 320x480 (MoPub) [noBids, MoPub Ad]",
                                    callbacks: mopubInterstitialCallbacks)
    }
    
    func testMoPubInterstitial_Display_VanillaPrebidOrder() {
        checkInterstitialLoadResult(exampleName: "Display Interstitial 320x480 (MoPub) [Vanilla Prebid Order]",
                                    callbacks: mopubInterstitialCallbacks)
    }
    
    // MARK: - Video
    
    func testVideo() {
        checkBannerLoadResult(exampleName: "Video Outstream with End Card (PPM)", video: true)
    }
    
    func testPPMVideo_noBids() {
        checkBannerLoadResult(exampleName: "Video Outstream (PPM) [noBids]",
                              video: true,
                              expectFailure: true)
    }
    
    func testGAMVideo_OK_AppEvent() {
        checkBannerLoadResult(exampleName: "Video Outstream with End Card (GAM) [OK, AppEvent]", video: true)
    }
    
    func testGAMVideo_noBids_gamAd() {
        checkBannerLoadResult(exampleName: "Video Outstream (GAM) [noBids, GAM Ad]", video: true)
    }
    
    // MARK: - Video Interstitials
    
    func testPPMInterstitial_Video_320x480_with_EndCard() {
        checkInterstitialLoadResult(exampleName: "Video Interstitial 320x480 with End Card (PPM)")
    }
    
    func testPPMInterstitial_Video_noBids() {
        checkInterstitialLoadResult(exampleName: "Video Interstitial 320x480 (PPM) [noBids]",
                                    expectFailure: true)
    }
    
    func testGAMInterstitial_Video_OK_AppEvent() {
        checkInterstitialLoadResult(exampleName: "Video Interstitial 320x480 (GAM) [OK, AppEvent]")
    }
    
    func testGAMInterstitial_Video_noBids_gamAd() {
        checkInterstitialLoadResult(exampleName: "Video Interstitial 320x480 (GAM) [noBids, GAM Ad]")
    }
    
    func testGAMInterstitial_Video_VanillaPrebidOrder() {
        checkInterstitialLoadResult(exampleName: "Video Interstitial 320x480 (GAM) [Vanilla Prebid Order]")
    }
    
    func testMoPubInterstitial_Video() {
        checkInterstitialLoadResult(exampleName: "Video Interstitial 320x480 (MoPub) [OK, OXB Adapter]",
                                    callbacks: mopubInterstitialCallbacks)
    }
    
    func testMoPubInterstitial_Video_NoBids() {
        checkInterstitialLoadResult(exampleName: "Video Interstitial 320x480 (MoPub) [noBids, MoPub Ad]",
                                    callbacks: mopubInterstitialCallbacks)
    }
    
    func testMoPubInterstitial_Video_VanillaPrebidOrder() {
        checkInterstitialLoadResult(exampleName: "Video Interstitial 320x480 (MoPub) [Vanilla Prebid Order]",
                                    callbacks: mopubInterstitialCallbacks)
    }
    
    // MARK: - Rewarded Video
    
    func testRewardedVideo() {
        checkRewardedLoadResult(exampleName: "Video Rewarded 320x480 (PPM)")
    }
    
    func testPPMRewarded_noBids() {
        checkRewardedLoadResult(exampleName: "Video Rewarded 320x480 (PPM) [noBids]",
                                expectFailure: true)
    }
    
    func testGAMRewarded() {
        checkRewardedLoadResult(exampleName: "Video Rewarded 320x480 (GAM) [OK, Metadata]")
    }
    
    func testGAMRewarded_noBids_gamAd() {
        checkRewardedLoadResult(exampleName: "Video Rewarded 320x480 (GAM) [noBids, GAM Ad]")
    }
    
    func testMoPubRewarded() {
        checkRewardedLoadResult(exampleName: "Video Rewarded 320x480 (MoPub) [OK, OXB Adapter]",
                                callbacks: mopubRewardedCallbacks)
    }
    
    func testMoPubRewarded_noBids() {
        checkRewardedLoadResult(exampleName: "Video Rewarded 320x480 (MoPub) [noBids, MoPub Ad]",
                                callbacks: mopubRewardedCallbacks)
    }
    
    func testMoPubRewarded_DeprecatedAPI() {
        checkRewardedLoadResult(exampleName: "[Deprecated API] Video Rewarded 320x480 (MoPub) [OK, OXB Adapter]",
                                callbacks: mopubRewardedCallbacks)
    }
    
    func testMoPubRewarded_noBids_DeprecatedAPI() {
        checkRewardedLoadResult(exampleName: "[Deprecated API] Video Rewarded 320x480 (MoPub) [noBids, MoPub Ad]",
                                callbacks: mopubRewardedCallbacks)
    }

    // MARK: - Native Styles
    
    //This test are temporary disabled, as the server returns:
    //"request.imp[0] uses native, but this bidder doesn't support it"
    func testBannerNativeStyle() {
        checkBannerLoadResult(exampleName: "Banner Native Styles")
    }
    
    func testGAMBannerNativeStyle_MRect() {
        checkBannerLoadResult(exampleName: "Banner Native Styles (GAM) [MRect]")
    }
    
    func testMoPubBannerNativeStyle_OK() {
        checkBannerLoadResult(exampleName: "Banner Native Styles (MoPub)",
                              adapterBased: true,
                              callbacks: mopubBannerCallbacks)
    }

}