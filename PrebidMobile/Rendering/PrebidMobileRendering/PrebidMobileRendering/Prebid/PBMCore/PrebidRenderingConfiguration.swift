//
//  PrebidRenderingConfiguration.swift
//  PrebidMobileRendering
//
//  Copyright © 2021 Prebid. All rights reserved.
//

import Foundation

fileprivate let defaultTimeoutMillis = 2000

public class PrebidRenderingConfig : NSObject {
    
    // MARK: - Public Properties (SDK)
    
    @objc static public let shared = PrebidRenderingConfig()
    
    @objc public var version: String {
        PBMFunctions.sdkVersion()
    }
    
    // MARK: - Public Properties (Prebid)
    
    @objc public var prebidServerHost: PBMPrebidHost = .custom {
        didSet {
            bidRequestTimeoutDynamic = nil
        }
    }
    @objc public var accountID: String
    
    @objc public var bidRequestTimeoutMillis: Int
    @objc public var bidRequestTimeoutDynamic: NSNumber?


    // MARK: - Public Properties (SDK)
    
    //Controls how long each creative has to load before it is considered a failure.
    @objc public var creativeFactoryTimeout: TimeInterval = 6.0

    //If preRenderContent flag is set, controls how long the creative has to completely pre-render before it is considered a failure.
    //Useful for video interstitials.
    @objc public var creativeFactoryTimeoutPreRenderContent: TimeInterval = 30.0

    //Controls whether to use PrebidMobileRendering's in-app browser or the Safari App for displaying ad clickthrough content.
    @objc public var useExternalClickthroughBrowser = false

    //Controls the verbosity of PrebidMobileRendering's internal logger. Options are (from most to least noisy) .info, .warn, .error and .none. Defaults to .info.
    @objc public var logLevel: PBMLogLevel {
        get { PBMLog.singleton.logLevel }
        set { PBMLog.singleton.logLevel = newValue }
    }

    //If set to true, the output of PrebidMobileRendering's internal logger is written to a text file. This can be helpful for debugging. Defaults to false.
    @objc public var debugLogFileEnabled: Bool {
        get { PBMLog.singleton.logToFile }
        set { PBMLog.singleton.logToFile = newValue }
    }

    //If true, the SDK will periodically try to listen for location updates in order to request location-based ads.
    @objc public var locationUpdatesEnabled: Bool {
        get { PBMLocationManager.singleton.locationUpdatesEnabled }
        set { PBMLocationManager.singleton.locationUpdatesEnabled = newValue }
    }
    
    // MARK: - Public Methods
    
    @objc public func setCustomPrebidServer(url: String) throws {
        guard PBMHost.shared.verifyUrl(url) else {
            throw PBMError.prebidServerURLInvalid(url)
        }
        
        prebidServerHost = .custom;
        PBMHost.shared.setHostURL(url)
    }
    
    @objc public static func initializeRenderingModule() {
        PBMServerConnection.singleton()
        let _ = PBMLocationManager.singleton
        PBMUserConsentDataManager.singleton()
        PBMOpenMeasurementWrapper.singleton.initializeJSLib(with: PBMFunctions.bundleForSDK())
        
        PBMLog.info("prebid-mobile-sdk-rendering \(PBMFunctions.sdkVersion()) Initialized")
    }
    
    // MARK: - Private Methods
    
    override init() {
        accountID  = ""
        
        bidRequestTimeoutMillis = defaultTimeoutMillis
    }
}