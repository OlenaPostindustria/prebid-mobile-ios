//
//  PBMErrorTest.swift
//  OpenXSDKCoreTests
//
//  Copyright © 2020 OpenX. All rights reserved.
//

import XCTest

@testable import PrebidMobileRendering

class PBMErrorTest: XCTestCase {
    func testErrorCollisions() {
        let allErrors = [
            PBMError.requestInProgress,
            
            PBMError.invalidAccountId,
            PBMError.invalidConfigId,
            PBMError.invalidSize,
            
            PBMError.serverError("some error reason"),
            
            PBMError.jsonDictNotFound,
            PBMError.responseDeserializationFailed,
            
            PBMError.noEventForNativeAdMarkupEventTracker,
            PBMError.noMethodForNativeAdMarkupEventTracker,
            PBMError.noUrlForNativeAdMarkupEventTracker,
            
            PBMError.noWinningBid,
            PBMError.noNativeCreative,
            
            NativeAdAssetBoxingError.noDataInsideNativeAdMarkupAsset,
            NativeAdAssetBoxingError.noImageInsideNativeAdMarkupAsset,
            NativeAdAssetBoxingError.noTitleInsideNativeAdMarkupAsset,
            NativeAdAssetBoxingError.noVideoInsideNativeAdMarkupAsset,
            
        ].map { $0 as NSError }
        
        for i in 1..<allErrors.count {
            for j in 0..<i {
                XCTAssertNotEqual(allErrors[i].code, allErrors[j].code,
                                  "\(i)('\(allErrors[i])' vs #\(j)('\(allErrors[j])'")
                XCTAssertNotEqual(allErrors[i].localizedDescription, allErrors[j].localizedDescription,
                                  "\(i)('\(allErrors[i])' vs #\(j)('\(allErrors[j])'")
            }
        }
    }
    
    func testErrorParsing() {
        let errors: [(Error?, PBMFetchDemandResult)] = [
            (PBMError.requestInProgress, .internalSDKError),
        
            (PBMError.invalidAccountId, .invalidAccountId),
            (PBMError.invalidConfigId, .invalidConfigId),
            (PBMError.invalidSize, .invalidSize),
        
            (PBMError.serverError("some error reason"), .serverError),
        
            (PBMError.jsonDictNotFound, .invalidResponseStructure),
            (PBMError.responseDeserializationFailed, .invalidResponseStructure),
            
            (PBMError.noWinningBid, .demandNoBids),
            
            (PBMError.noNativeCreative, .sdkMisuse_NoNativeCreative),
            
            (NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut), .demandTimedOut),
            (NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL), .networkError),
            
            (nil, .ok),
        ]
        
        for (error, code) in errors {
            XCTAssertEqual(PBMError.demandResult(fromError: error), code)
        }
    }
    
    func testInitWithMessage() {
        let error = PBMError(message: "MyError")
        XCTAssert(error.message == "MyError")
    }
    
    func testInitWithDescription() {
        let error = PBMError.error(description: "MyErrorDescription")
        
        // Verify default values
        XCTAssert(error.domain == PBMErrorDomain)
        XCTAssert(error.code == 700)
        XCTAssert(error.userInfo["NSLocalizedDescription"] as! String == "MyErrorDescription")
    }
    
    func testInitWithMessageAndType() {
        let errorMessage = "ERROR MESSAGE"
        let err = PBMError.error(message: errorMessage, type: .internalError)
        XCTAssert(err.localizedDescription.PBMdoesMatch(errorMessage), "error should have \(errorMessage) in its description")
    }
    
    func testCreateErrorWithDescriptionNegative() {
        var error = PBMError.createError(nil, description: "")
        XCTAssertFalse(error)
        
        error = PBMError.createError(nil, message: "", type: .invalidRequest)
        XCTAssertFalse(error)
        
        error = PBMError.createError(nil, description: "", statusCode: .generalLinear)
        XCTAssertFalse(error)
    }
}