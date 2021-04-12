//
//  OXAGADUnifiedNativeAd.m
//  OpenXApolloGAMEventHandlers
//
//  Copyright © 2021 OpenX. All rights reserved.
//

#import "OXAGADUnifiedNativeAd.h"

#import <GoogleMobileAds/GoogleMobileAds.h>
#import "OXAInvocationHelper.h"


static NSNumber *classesCheckResult = nil;

@interface OXAGADUnifiedNativeAd ()
@property (nonatomic, strong, readonly) GADUnifiedNativeAd *unifiedNativeAd;
@end



@implementation OXAGADUnifiedNativeAd

- (instancetype)initWithUnifiedNativeAd:(GADUnifiedNativeAd *)unifiedNativeAd {
    if (!(self = [super init])) {
        return nil;
    }
    _unifiedNativeAd = unifiedNativeAd;
    return self;
}

// MARK: - Public (own) properties

+ (BOOL)classesFound {
    if (classesCheckResult != nil) {
        return classesCheckResult.boolValue;
    }
    const BOOL classesFound = [self findClasses];
    classesCheckResult = @(classesFound);
    return classesFound;
}

- (NSObject *)boxedAd {
    return self.unifiedNativeAd;
}

// MARK: - Public (Boxed) Methods

- (NSString *)headline {
    NSString *result = nil;
    [OXAInvocationHelper invokeClassResultSelector:@selector(headline)
                                          onTarget:self.unifiedNativeAd
                                       resultClass:[NSString class]
                                         outResult:&result
                                       onException:nil];
    return result;
}

- (NSString *)callToAction {
    NSString *result = nil;
    [OXAInvocationHelper invokeClassResultSelector:@selector(callToAction)
                                          onTarget:self.unifiedNativeAd
                                       resultClass:[NSString class]
                                         outResult:&result
                                       onException:nil];
    return result;
}

- (NSString *)body {
    NSString *result = nil;
    [OXAInvocationHelper invokeClassResultSelector:@selector(body)
                                          onTarget:self.unifiedNativeAd
                                       resultClass:[NSString class]
                                         outResult:&result
                                       onException:nil];
    return result;
}

- (NSDecimalNumber *)starRating {
    NSDecimalNumber *result = nil;
    [OXAInvocationHelper invokeClassResultSelector:@selector(starRating)
                                          onTarget:self.unifiedNativeAd
                                       resultClass:[NSDecimalNumber class]
                                         outResult:&result
                                       onException:nil];
    return result;
}

- (NSString *)store {
    NSString *result = nil;
    [OXAInvocationHelper invokeClassResultSelector:@selector(store)
                                          onTarget:self.unifiedNativeAd
                                       resultClass:[NSString class]
                                         outResult:&result
                                       onException:nil];
    return result;
}

- (NSString *)price {
    NSString *result = nil;
    [OXAInvocationHelper invokeClassResultSelector:@selector(price)
                                          onTarget:self.unifiedNativeAd
                                       resultClass:[NSString class]
                                         outResult:&result
                                       onException:nil];
    return result;
}

- (NSString *)advertiser {
    NSString *result = nil;
    [OXAInvocationHelper invokeClassResultSelector:@selector(advertiser)
                                          onTarget:self.unifiedNativeAd
                                       resultClass:[NSString class]
                                         outResult:&result
                                       onException:nil];
    return result;
}

// MARK: - Private Helpers

+ (BOOL)findClasses {
    BOOL result = NO;
    @try {
        if (!NSClassFromString(@"GADUnifiedNativeAd")) {
            return NO;
        }
        Class const testClass = [GADUnifiedNativeAd class];
        SEL selectors[] = {
            @selector(headline),
            @selector(callToAction),
            @selector(body),
            @selector(starRating),
            @selector(store),
            @selector(price),
            @selector(advertiser),
        };
        const size_t selectorsCount = sizeof(selectors) / sizeof(selectors[0]);
        for(size_t i = 0; i < selectorsCount; i++) {
            if (![testClass instancesRespondToSelector:selectors[i]]) {
                return NO;
            }
        }
        result = YES;
    }
    @catch(id anException) {
        result = NO;
    };
    return result;
}

@end
