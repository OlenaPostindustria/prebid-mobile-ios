//
//  PBMORTBAppExtPrebid.h
//  OpenXSDKCore
//
//  Copyright © 2020 OpenX. All rights reserved.
//

#import "PBMORTBAbstract.h"

NS_ASSUME_NONNULL_BEGIN

@interface PBMORTBAppExtPrebid : PBMORTBAbstract

@property (nonatomic, copy, nullable) NSString *source;
@property (nonatomic, copy, nullable) NSString *version;
@property (nonatomic, strong, nullable) NSDictionary<NSString *, NSArray<NSString *> *> *data;

@end

NS_ASSUME_NONNULL_END