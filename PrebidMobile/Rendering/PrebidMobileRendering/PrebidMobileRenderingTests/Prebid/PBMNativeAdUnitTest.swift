//
//  PBMNativeAdUnitTest.swift
//  OpenXSDKCoreTests
//
//  Copyright © 2021 OpenX. All rights reserved.
//

import XCTest

@testable import PrebidMobileRendering

class PBMNativeAdUnitTest: XCTestCase, WinningBidResponseFabricator {
    func testDesignatedInit_noBlockCalled() {
        let configID = "some-base-config-ID"
        
        let nativeAdConfig = PBMNativeAdConfiguration(assets: [PBMNativeAssetTitle(length: 25)])
        
        let noRequesterCreated = expectation(description: "no requester created")
        noRequesterCreated.isInverted = true
        
        let adUnit = PBMNativeAdUnit(configID: configID, nativeAdConfiguration: nativeAdConfig) { adUnitConfig in
            XCTFail()
            return MockBidRequester(expectedCalls: [])
        } winNotifierBlock: { (bid, adMarkupStringHandler) in
            XCTFail()
            adMarkupStringHandler(nil)
        }
        
        XCTAssertEqual(adUnit.configId, configID)
        XCTAssertNotNil(adUnit.nativeAdConfig)
        XCTAssertNotEqual(adUnit.nativeAdConfig, nativeAdConfig) // copy; 'isEqual' not overridden
        
        //NOTE: temporary disabled as PBS doesnt support OM event trackers
        //OMID event tracker which is set by PBMNativeAdUnit
//        nativeAdConfig.eventtrackers = [PBMNativeEventTracker(event: .OMID,
//                                                              methods:
//                                                                [NSNumber(value:PBMNativeEventTrackingMethod.JS.rawValue)])]
        XCTAssertEqual(adUnit.nativeAdConfig.markupRequestObject.jsonDictionary as NSDictionary?,
                       nativeAdConfig.markupRequestObject.jsonDictionary as NSDictionary?)

        waitForExpectations(timeout: 1)
    }
    
    func testGetNativeAd() {
        let someLinkUrl = "some link URL"
        
        let testBlocks: [(adMarkup: String?, expectedNativeAd: PBMNativeAd?)] = [
            nil,
            "not a real native ad",
            """
{"link": {"url": "\(someLinkUrl)"}}
""",
        ].map { adString in
            if let adString = adString, let nativeAdMarkup = try? PBMNativeAdMarkup(jsonString: adString) {
                return (adString, PBMNativeAd(nativeAdMarkup: nativeAdMarkup))
            } else {
                return (adString, nil)
            }
        }
        
        let configID = "the-config-ID"
        let bidPrice = 0.85
        let nativeAdConfig = PBMNativeAdConfiguration(assets: [PBMNativeAssetTitle(length: 25)])
        
        for nextMarkup in testBlocks {
            let expectedAdMarkup = nextMarkup.adMarkup
            
            let bidResponse = makeWinningBidResponse(bidPrice: bidPrice)
            
            let requesterCreated = expectation(description: "requester created")
            let winNotNotified = expectation(description: "win not notified")
            winNotNotified.isInverted = true
            
            let winNotification = NSMutableArray(object: winNotNotified)
            
            let adUnit = PBMNativeAdUnit(configID: configID, nativeAdConfiguration: nativeAdConfig) { adUnitConfig in
                requesterCreated.fulfill()
                return MockBidRequester(expectedCalls: [
                    { responseHandler in
                        responseHandler(bidResponse, nil)
                    },
                ])
            } winNotifierBlock: { (bid, adMarkupStringHandler) in
                (winNotification[0] as! XCTestExpectation).fulfill()
                XCTAssertEqual(bid.price, Float(bidPrice))
                adMarkupStringHandler(expectedAdMarkup)
            }
            
            XCTAssertEqual(adUnit.configId, configID)
            
            let fetchDemandReturned = expectation(description: "fetch demand result returned")
            var returnedDemandResponseInfo: PBMDemandResponseInfo?
            adUnit.fetchDemand { demandResponseInfo in
                returnedDemandResponseInfo = demandResponseInfo
                fetchDemandReturned.fulfill()
                XCTAssertTrue(Thread.isMainThread)
                XCTAssertEqual(demandResponseInfo.fetchDemandResult, .ok)
            }

            waitForExpectations(timeout: 1)
            XCTAssertEqual(adUnit.lastBidResponse, bidResponse)
            XCTAssertNotNil(adUnit.lastDemandResponseInfo)
            
            let winNotifierCalled = expectation(description: "win notifier called")
            winNotification[0] = winNotifierCalled
            
            let nativeAdReturned = expectation(description: "native ad returned")
            returnedDemandResponseInfo?.getNativeAd { nativeAd in
                nativeAdReturned.fulfill()
                XCTAssertEqual(nativeAd, nextMarkup.expectedNativeAd)
            }
            
            waitForExpectations(timeout: 1)
        }
    }
    
    func testSecondFetch_andGetNativeAdBeforeFetch() {
        let someLinkUrl = "some link URL"
        
        let expectedAdMarkup = """
{"link": {"url": "\(someLinkUrl)"}}
"""
        let expectedNativeAd = PBMNativeAd(nativeAdMarkup: try! PBMNativeAdMarkup(jsonString: expectedAdMarkup))
        
        let configID = "the-config-ID"
        let bidPrice = 0.85
        let nativeAdConfig = PBMNativeAdConfiguration(assets: [PBMNativeAssetTitle(length: 25)])
        
        let bidResponse = makeWinningBidResponse(bidPrice: bidPrice)
        
        let requesterNotCreated = expectation(description: "requester not created")
        requesterNotCreated.isInverted = true
        let requesterCreatedNotification = NSMutableArray(object: requesterNotCreated)
        let winNotNotified = expectation(description: "win not notified")
        winNotNotified.isInverted = true
        
        let winNotification = NSMutableArray(object: winNotNotified)
        
        let adUnit = PBMNativeAdUnit(configID: configID, nativeAdConfiguration: nativeAdConfig) { adUnitConfig in
            (requesterCreatedNotification[0] as! XCTestExpectation).fulfill()
            return MockBidRequester(expectedCalls: [
                { responseHandler in
                    responseHandler(bidResponse, nil)
                },
            ])
        } winNotifierBlock: { (bid, adMarkupStringHandler) in
            (winNotification[0] as! XCTestExpectation).fulfill()
            XCTAssertEqual(bid.price, Float(bidPrice))
            adMarkupStringHandler(expectedAdMarkup)
        }
        
        XCTAssertEqual(adUnit.configId, configID)
        
        let requesterCreated = expectation(description: "requester created")
        requesterCreatedNotification[0] = requesterCreated
        
        var returnedDemandResponseInfo: PBMDemandResponseInfo?
        
        let fetchDemandReturned = expectation(description: "fetch demand result returned")
        adUnit.fetchDemand { demandResponseInfo in
            returnedDemandResponseInfo = demandResponseInfo
            fetchDemandReturned.fulfill()
            XCTAssertTrue(Thread.isMainThread)
            XCTAssertEqual(demandResponseInfo.fetchDemandResult, .ok)
        }

        waitForExpectations(timeout: 1)
        XCTAssertEqual(adUnit.lastBidResponse, bidResponse)
        XCTAssertNotNil(adUnit.lastDemandResponseInfo)
        
        let winNotifierCalled = expectation(description: "win notifier called")
        winNotification[0] = winNotifierCalled
        
        let nativeAdReturned = expectation(description: "native ad returned")
        returnedDemandResponseInfo?.getNativeAd { nativeAd in
            nativeAdReturned.fulfill()
            XCTAssertEqual(nativeAd, expectedNativeAd)
        }
        
        waitForExpectations(timeout: 1)
        
        let fetchDemandFailed = expectation(description: "fetch demand failed")
        adUnit.fetchDemand { demandResponseInfo in
            fetchDemandFailed.fulfill()
            XCTAssertTrue(Thread.isMainThread)
            XCTAssertEqual(demandResponseInfo.fetchDemandResult, .sdkMisuse_NativeAdUnitFetchedAgain)
        }

        waitForExpectations(timeout: 1)
    }
}