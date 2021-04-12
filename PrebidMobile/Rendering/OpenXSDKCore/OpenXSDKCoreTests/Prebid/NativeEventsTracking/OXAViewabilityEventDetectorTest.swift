//
//  OXAViewabilityEventDetectorTest.swift
//  OpenXSDKCoreTests
//
//  Copyright © 2021 OpenX. All rights reserved.
//

import Foundation
import XCTest

class OXAViewabilityEventDetectorTest: XCTestCase {
    func testInstantImpression() {
        let onImpressionDetected = NSMutableArray(object: { XCTFail() })
        let onLastEventDetected = NSMutableArray(object: { XCTFail() })
        
        let instantImpression = OXAViewabilityEvent(exposureSatisfactionCheck: { $0 > 0 },
                                                    durationSatisfactionCheck: { _ in true },
                                                    onEventDetected: { (onImpressionDetected[0] as! ()->())() })
        
        let eventDetector = OXAViewabilityEventDetector(viewabilityEvents: [instantImpression],
                                                        onLastEventDetected: { (onLastEventDetected[0] as! ()->())() })
        
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 0)
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 0.1)
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 1)
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 0.7)
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 4.9)
        
        let dummyExpectation = expectation(description: "timeout")
        dummyExpectation.isInverted = true
        waitForExpectations(timeout: 1)
        
        let impressionDetected = expectation(description: "impression detected")
        let lastEventReported = expectation(description: "last event reported")
        
        onImpressionDetected[0] = {
            impressionDetected.fulfill()
            onLastEventDetected[0] = { lastEventReported.fulfill() }
        }
        
        eventDetector.onExposureMeasured(0.1, passedSinceLastMeasurement: 0.3)
        waitForExpectations(timeout: 1)
        
        eventDetector.onExposureMeasured(2, passedSinceLastMeasurement: 1)
    }
    
    func testMRC50Impression() {
        let onImpressionDetected = NSMutableArray(object: { XCTFail() })
        let onLastEventDetected = NSMutableArray(object: { XCTFail() })
        
        let mrc50Impression = OXAViewabilityEvent(exposureSatisfactionCheck: { $0 >= 0.5 },
                                                  durationSatisfactionCheck: { $0 >= 1 },
                                                  onEventDetected: { (onImpressionDetected[0] as! ()->())() })
        
        let eventDetector = OXAViewabilityEventDetector(viewabilityEvents: [mrc50Impression],
                                                        onLastEventDetected: { (onLastEventDetected[0] as! ()->())() })
        
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 0)
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 0.1)
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 4)
        
        eventDetector.onExposureMeasured(0.9, passedSinceLastMeasurement: 0.1)
        eventDetector.onExposureMeasured(1.0, passedSinceLastMeasurement: 0.7)
        eventDetector.onExposureMeasured(0.0, passedSinceLastMeasurement: 0.1)
        
        eventDetector.onExposureMeasured(0.6, passedSinceLastMeasurement: 0.1)
        eventDetector.onExposureMeasured(0.8, passedSinceLastMeasurement: 0.4)
        eventDetector.onExposureMeasured(0.5, passedSinceLastMeasurement: 0.5)
        eventDetector.onExposureMeasured(0.4, passedSinceLastMeasurement: 0.2)
        
        eventDetector.onExposureMeasured(0.5, passedSinceLastMeasurement: 0.1)
        eventDetector.onExposureMeasured(0.6, passedSinceLastMeasurement: 0.4)
        eventDetector.onExposureMeasured(0.5, passedSinceLastMeasurement: 0.5)
        
        let dummyExpectation = expectation(description: "timeout")
        dummyExpectation.isInverted = true
        waitForExpectations(timeout: 1)
        
        let impressionDetected = expectation(description: "impression detected")
        let lastEventReported = expectation(description: "last event reported")
        
        onImpressionDetected[0] = {
            impressionDetected.fulfill()
            onLastEventDetected[0] = { lastEventReported.fulfill() }
        }
        
        eventDetector.onExposureMeasured(0.5, passedSinceLastMeasurement: 0.1)
        waitForExpectations(timeout: 1)
        
        eventDetector.onExposureMeasured(2, passedSinceLastMeasurement: 1)
    }
    
    func testMRC100Impression() {
        let onImpressionDetected = NSMutableArray(object: { XCTFail() })
        let onLastEventDetected = NSMutableArray(object: { XCTFail() })
        
        let mrc100Impression = OXAViewabilityEvent(exposureSatisfactionCheck: { $0 >= 1 },
                                                   durationSatisfactionCheck: { $0 >= 1 },
                                                   onEventDetected: { (onImpressionDetected[0] as! ()->())() })
        
        let eventDetector = OXAViewabilityEventDetector(viewabilityEvents: [mrc100Impression],
                                                        onLastEventDetected: { (onLastEventDetected[0] as! ()->())() })
        
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 0)
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 0.1)
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 4)
        
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.1)
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.7)
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 0.1)
        
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.1)
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.4)
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.5)
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 0.2)
        
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.1)
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.4)
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.5)
        
        let dummyExpectation = expectation(description: "timeout")
        dummyExpectation.isInverted = true
        waitForExpectations(timeout: 1)
        
        let impressionDetected = expectation(description: "impression detected")
        let lastEventReported = expectation(description: "last event reported")
        
        onImpressionDetected[0] = {
            impressionDetected.fulfill()
            onLastEventDetected[0] = { lastEventReported.fulfill() }
        }
        
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.1)
        waitForExpectations(timeout: 1)
        
        eventDetector.onExposureMeasured(2, passedSinceLastMeasurement: 1)
    }
    
    func testMultipleImpressions() {
        let onInstantImpressionDetected = NSMutableArray(object: { XCTFail() })
        let onVideo50impressionDetected = NSMutableArray(object: { XCTFail() })
        let onMrc100impressionDetected = NSMutableArray(object: { XCTFail() })
        
        let instantImpression = OXAViewabilityEvent(exposureSatisfactionCheck: { $0 > 0 },
                                                    durationSatisfactionCheck: { _ in true },
                                                    onEventDetected: { (onInstantImpressionDetected[0] as! ()->())() })
        let video50Impression = OXAViewabilityEvent(exposureSatisfactionCheck: { $0 >= 0.5 },
                                                    durationSatisfactionCheck: { $0 >= 2 },
                                                    onEventDetected: { (onVideo50impressionDetected[0] as! ()->())() })
        let mrc100Impression = OXAViewabilityEvent(exposureSatisfactionCheck: { $0 >= 1 },
                                                   durationSatisfactionCheck: { $0 >= 1 },
                                                   onEventDetected: { (onMrc100impressionDetected[0] as! ()->())() })
        
        let allImpressionEvents = [
            instantImpression,
            video50Impression,
            mrc100Impression,
        ]
        let onLastEventDetected = NSMutableArray(object: { XCTFail() })
        
        let eventDetector = OXAViewabilityEventDetector(viewabilityEvents: allImpressionEvents,
                                                        onLastEventDetected: { (onLastEventDetected[0] as! ()->())() })
        
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 0)
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 0.1)
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 4)
        
        let dummyExpectation = expectation(description: "timeout")
        dummyExpectation.isInverted = true
        waitForExpectations(timeout: 1)
        
        
        let instantImpressionDetected = expectation(description: "instant impression detected")
        onInstantImpressionDetected[0] = {
            instantImpressionDetected.fulfill()
        }
        
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.1)
        
        waitForExpectations(timeout: 1)
        
        eventDetector.onExposureMeasured(0.5, passedSinceLastMeasurement: 0.1)
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.7)
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 0.1)
        
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.1)
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.4)
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.5)
        eventDetector.onExposureMeasured(0, passedSinceLastMeasurement: 0.2)
        
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.1)
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.4)
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.5)
        
        let mrc100impressionDetected = expectation(description: "MRC100 impression detected")
        onMrc100impressionDetected[0] = {
            mrc100impressionDetected.fulfill()
        }
        
        eventDetector.onExposureMeasured(1, passedSinceLastMeasurement: 0.1)
        
        waitForExpectations(timeout: 1)
        
        eventDetector.onExposureMeasured(0.6, passedSinceLastMeasurement: 0.5)
        eventDetector.onExposureMeasured(0.7, passedSinceLastMeasurement: 0.4)
        
        let video50impressionDetected = expectation(description: "video 50 impression detected")
        let lastEventReported = expectation(description: "last event reported")
        
        onVideo50impressionDetected[0] = {
            video50impressionDetected.fulfill()
            onLastEventDetected[0] = {
                lastEventReported.fulfill()
            }
        }
        
        eventDetector.onExposureMeasured(0.9, passedSinceLastMeasurement: 0.1)
        
        waitForExpectations(timeout: 1)
        
        eventDetector.onExposureMeasured(2, passedSinceLastMeasurement: 2)
    }
}
