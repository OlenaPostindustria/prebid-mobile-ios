//
//  OXMCreativeTrackerTest.swift
//  OpenXSDKCoreTests
//
//  Copyright © 2018 OpenX. All rights reserved.
//

import XCTest

class OXMEventManagerTest: XCTestCase {
    
    private var trackersCount = 0
    
    override func setUp() {
        super.setUp()
    
        trackersCount = 0
    }

    func testRegisterUnregister() {
        
        let creativeTracker = OXMEventManager()
        XCTAssertNotNil(creativeTracker.trackers)
        XCTAssertEqual(creativeTracker.trackers?.count, 0)
        
        // Add tracker
        let tracker1 = createTrackerWithExpectationCount(4)
        creativeTracker.registerTracker(tracker1)
        XCTAssertEqual(creativeTracker.trackers?.count, 1)
        
        creativeTracker.trackEvent(.impression) // expectations count: t1(1) t2(-) t3(-)
        
        // Add tracker
        let tracker2 = createTrackerWithExpectationCount(2)
        creativeTracker.registerTracker(tracker2)
        XCTAssertEqual(creativeTracker.trackers?.count, 2)
        
        creativeTracker.trackEvent(.impression) // expectations count: t1(2) t2(1) t3(-)
        
        // Add tracker
        let tracker3 = createTrackerWithExpectationCount(2)
        creativeTracker.registerTracker(tracker3)
        XCTAssertEqual(creativeTracker.trackers?.count, 3)
        
        creativeTracker.trackEvent(.impression) // expectations count: t1(3) t2(2) t3(1)

        // Remove "middle" tracker
        creativeTracker.unregisterTracker(tracker2)
        XCTAssertEqual(creativeTracker.trackers?.count, 2)

        creativeTracker.trackEvent(.impression) // expectations count: t1(4) t2(-) t3(2)
        
        waitForExpectations(timeout: 1)
    }
    
    func testSupportAllProtocol() {
        let creativeTracker = OXMEventManager()
        
        let exp = expectation(description:"expectation")
        exp.expectedFulfillmentCount = 4
        
        let eventTracker = MockOXMAdModelEventTracker(creativeModel: MockOXMCreativeModel(adConfiguration: OXMAdConfiguration()), serverConnection: OXMServerConnection())
       
        let testTrackEvent: OXMTrackingEvent = .impression
        eventTracker.mock_trackEvent = { event in
            XCTAssertEqual(testTrackEvent, event)
            exp.fulfill()
        }
        
        let testParams = OXMVideoVerificationParameters()
        eventTracker.mock_trackVideoAdLoaded = { params in
            XCTAssertTrue(testParams === params)
            exp.fulfill()
        }
        
        let testDuration: CGFloat = 42
        let testVolume: CGFloat = 3.14
        let testDeviceVolume: CGFloat = 1.618
        eventTracker.mock_trackStartVideo = { duration, volume in
            XCTAssertEqual(testDuration, duration)
            XCTAssertEqual(testVolume, volume)

            exp.fulfill()
        }
        
        eventTracker.mock_trackVolumeChanged = { playerVolume, deviceVolume in
            XCTAssertEqual(testVolume, playerVolume)
            XCTAssertEqual(testDeviceVolume, deviceVolume)
            
            exp.fulfill()
        }
        
        creativeTracker.registerTracker(eventTracker)
        
        creativeTracker.trackEvent(.impression)
        creativeTracker.trackVideoAdLoaded(testParams)
        creativeTracker.trackStartVideo(withDuration: testDuration, volume:testVolume)
        creativeTracker.trackVolumeChanged(testVolume, deviceVolume: testDeviceVolume)
        
        waitForExpectations(timeout: 0.1)
    }
    
    // MARK: - Helper Methods
    
    private func createTrackerWithExpectationCount(_ count: UInt) -> MockOXMAdModelEventTracker {
        let exp = expectation(description:"expectation\(trackersCount)")
        trackersCount += 1
        exp.expectedFulfillmentCount = Int(count)
        
        let eventTracker = MockOXMAdModelEventTracker(creativeModel: MockOXMCreativeModel(adConfiguration: OXMAdConfiguration()), serverConnection: OXMServerConnection())
        eventTracker.mock_trackEvent = { _ in
            exp.fulfill()
        }
        
        return eventTracker;
    }
}
