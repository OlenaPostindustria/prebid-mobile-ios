//
//  OXMORTBDeal.h
//  OpenXSDKCore
//
//  Copyright © 2020 OpenX. All rights reserved.
//

#import "OXMORTBAbstract.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 3.2.12: Deal

//This object constitutes a specific deal that was struck a priori between a buyer and a seller. Its presence
//with the Pmp collection indicates that this impression is available under the terms of that deal. Refer to
//Section 7.3 for more details.
@interface OXMORTBDeal : OXMORTBAbstract
    
//A unique identifier for the direct deal
//REQUIRED
@property (nonatomic, copy, nullable) NSString *id;

//Minimum bid for this impression expressed in CPM
//Defaults to 0
@property (nonatomic, strong) NSNumber *bidfloor;

//Currency specified using ISO-4217 alpha codes. This may be different from bid currency returned by bidder if this is allowed by the exchange
//Defaults to USD
@property (nonatomic, copy) NSString *bidfloorcur;

//Int. Optional override of the overall auction type of the bid request, where 1 = First Price, 2 = Second Price Plus, 3 = the value passed in bidfloor is the agreed upon deal price. Additional auction types can be defined by the exchange
@property (nonatomic, strong, nullable) NSNumber *at;

//Whitelist of buyer seats allowed to bid on this deal. Seat IDs must be communicated between bidders and the exchange a priori. Omission implies no seat restrictions
@property (nonatomic, copy) NSArray<NSString *> *wseat;

//Array of advertiser domains (e.g., advertiser.com) allowed to bid on this deal. Omission implies no advertiser restrictions
@property (nonatomic, copy) NSArray<NSString *> *wadomain;

//Placeholder for exchange-specific extensions to OpenRTB.
//Note: ext is not supported.

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
