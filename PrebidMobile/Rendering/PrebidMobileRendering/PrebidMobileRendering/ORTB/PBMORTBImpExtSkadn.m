/*   Copyright 2018-2021 Prebid.org, Inc.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "PBMORTBImpExtSkadn.h"
#import "PBMORTBAbstract+Protected.h"

static NSString * const SKAdNetworkVersion = @"2.0";

@implementation PBMORTBImpExtSkadn

- (instancetype )init {
    if (self = [super init]) {
        _skadnetids = @[];
    }
    return self;
}

- (void)setSkadnetids:(NSArray<NSString *> *)scadnetids {
    _skadnetids = scadnetids ? [NSArray arrayWithArray:scadnetids] : @[];
}

- (nonnull PBMJsonDictionary *)toJsonDictionary {
    PBMMutableJsonDictionary * const ret = [PBMMutableJsonDictionary new];
    
    if (self.sourceapp && self.skadnetids.count > 0) {
        if (@available(iOS 14.5, *)) {
            ret[@"versions"] = @[@"2.0", @"2.1", @"2.2"];
        } else {
            ret[@"versions"] = @[@"2.0", @"2.1"];
        }
        
        ret[@"sourceapp"] = self.sourceapp;
        ret[@"skadnetids"] = self.skadnetids;
    }
    
    [ret pbmRemoveEmptyVals];
    return ret;
}

- (instancetype)initWithJsonDictionary:(nonnull PBMJsonDictionary *)jsonDictionary {
    if (self = [self init]) {
        _sourceapp = jsonDictionary[@"sourceapp"];
        _skadnetids = jsonDictionary[@"skadnetids"];
    }

    return self;
}
@end
