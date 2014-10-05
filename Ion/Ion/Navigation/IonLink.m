//
//  IonLink.m
//  Ion
//
//  Created by Andrew Hurst on 10/5/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonLink.h"
#import <IonData/IonData.h>


static NSString *sIonLinkReason_Referral = @"Referral";
@interface IonLink ()

/**
 * The URL representing the link.
 */
@property (strong, nonatomic, readwrite) NSURL *url;

@end

@implementation IonLink

@synthesize url = _url;

#pragma mark Constructors

- (instancetype) initWithURL:(NSURL *)url
                      reason:(NSString *)reason
                referralLink:(IonLink *)referral
                     andData:(NSDictionary *)data; {
    self = [super init];
    if ( self ) {
        self.url = [url standardizedURL];
        
        // Proprietary data
        self.reason = reason;
        self.referralLink = referral;
        self.data = data;
    }
    return self;
}

- (instancetype) initWithURL:(NSURL *)url
                      reason:(NSString *)reason
                     andData:(NSDictionary *)data {
    return [self initWithURL: url reason: reason referralLink: NULL andData: data];
}

- (instancetype) initWithURL:(NSURL *)url
                      reason:(NSString *)reason
             andReferralLink:(IonLink *)referral {
    return [self initWithURL: url reason: reason referralLink: referral andData: NULL];
}

- (instancetype) initWithURL:(NSURL *)url andReason:(NSString *)reason {
    return [self initWithURL: url reason: reason referralLink: NULL andData: NULL];
}

+ (instancetype) linkWithURL:(NSURL *)url
                      reason:(NSString *)reason
                     andData:(NSDictionary *)data  {
    return [[[self class] alloc] initWithURL: url reason: reason referralLink: NULL andData: data];
}

+ (instancetype) linkWithURL:(NSURL *)url
                      reason:(NSString *)reason
             andReferralLink:(IonLink *)referral  {
    return [[[self class] alloc] initWithURL: url reason: reason referralLink: referral andData: NULL];
}

+ (instancetype) linkWithURL:(NSURL *)url andReason:(NSString *)reason {
    return [[[self class] alloc] initWithURL: url reason: reason referralLink: NULL andData: NULL];
}

+ (instancetype) referralLinkWithURL:(NSURL *)url {
    return [[[self class] alloc] initWithURL: url andReason: sIonLinkReason_Referral];
}


#pragma mark String Constructors

- (instancetype) initWithURLString:(NSString *)urlString
                            reason:(NSString *)reason
                      referralLink:(IonLink *)referral
                           andData:(NSDictionary *)data {
    return [self initWithURL: [NSURL URLWithString: urlString]
                      reason: reason
                referralLink: referral
                     andData: data];
}

- (instancetype) initWithURLString:(NSString *)urlString
                            reason:(NSString *)reason
                           andData:(NSDictionary *)data {
    return [self initWithURLString: urlString reason: reason referralLink: NULL andData: data];
}

- (instancetype) initWithURLString:(NSString *)urlString
                            reason:(NSString *)reason
                   andReferralLink:(IonLink *)referral {
    return [self initWithURLString: urlString reason: reason referralLink: referral andData: NULL];
}

- (instancetype) initWithURLString:(NSString *)urlString andReason:(NSString *)reason {
    return [self initWithURLString: urlString reason: reason referralLink: NULL andData: NULL];
}

+ (instancetype) linkWithURLString:(NSString *)urlString
                            reason:(NSString *)reason
                           andData:(NSDictionary *)data {
    return [[[self class] alloc] initWithURLString: urlString reason: reason andData: data];
}

+ (instancetype) linkWithURLString:(NSString *)urlString
                            reason:(NSString *)reason
                   andReferralLink:(IonLink *)referral {
    return [[[self class] alloc] initWithURLString: urlString reason: reason andReferralLink: referral];
}

+ (instancetype) linkWithURLString:(NSString *)urlString andReason:(NSString *)reason {
    return [[[self class] alloc] initWithURLString: urlString andReason: reason];
}

+ (instancetype) referralLinkWithURLString:(NSString *)urlString {
    return [[[self class] alloc] initWithURLString: urlString andReason: sIonLinkReason_Referral];
}


#pragma mark URL

- (void) setUrl:(NSURL *)url {
    NSParameterAssert( url && [url isKindOfClass: [NSURL class]] );
    if ( !url || ![url isKindOfClass: [NSURL class]] )
        return;
    
    _url = url;
    
    [self getPathComponentsFromURL];
    [self getParametersFromURL];
}

#pragma mark Path Component

- (void) getPathComponentsFromURL {
    NSMutableArray *components;
    if ( !_url )
        return;
    
    components = [[NSMutableArray alloc] initWithArray: _url.pathComponents copyItems: TRUE];
    if ( components.count > 0 )
        [components removeObjectAtIndex: 0];
    _pathComponents = [NSArray arrayWithArray: components];
}

#pragma mark Parameters

- (void) getParametersFromURL {
    if ( !_url ) {
        _parameters = @{};
        return;
    }
    _parameters =  [[self class] queryParametersFromString: _url.query];
}

#pragma mark Child Generation

- (instancetype) linkWithoutFirstComponent {
    NSString* path;
    NSMutableArray *components;
    
    components = [NSMutableArray arrayWithArray: _pathComponents];
    if ( components && components.count > 0 )
        [components removeObjectAtIndex: 0];
    
    path = [NSString stringWithFormat: _url.query ? @"%@://%@?%@": @"%@://%@%@",
            _url.scheme ? _url.scheme : @"ion", // default to ion
            [[self class] pathStringFromComponents: components],
            _url.query ? _url.query : @""]; // Default to nothing
    
    return [[[self class] alloc] initWithURL: [NSURL URLWithString: path]
                                      reason: self.reason
                                referralLink: self.referralLink
                                     andData: self.data];
}

#pragma mark Utilities

- (NSString *)urlString {
    return _url.absoluteString;
}

- (NSString *)toString {
    return [NSString stringWithFormat: @"URL: \"%@\", Reason: \"%@\", Referral: \"%@\", Has Data: %@",
            [self urlString],
            self.reason ? self.reason : @"",
            self.referralLink ? [self.referralLink urlString] : @"None",
            self.data ? @"Yes" : @"No"];
}

- (NSString *)description {
    return [self toString];
}

+ (NSString *)pathStringFromComponents:(NSArray *)components {
    NSString *resultString = @"/";
    
    for ( NSString *component in components )
        resultString = [NSString stringWithFormat: @"%@%@/", resultString, component];
    
    return resultString;
}

+ (NSString *)urlStringFromComponents:(NSArray *)components {
    return [[self class] urlStringFromPath: [[self class] pathStringFromComponents: components]];
}

+ (NSString *)urlStringFromPath:(NSString *)path {
    return [NSString stringWithFormat: @"%@://%@", [[self class] plistSchema], path];
}

+ (NSString *)plistSchema {
    return @"ion"; // TODO: get from plist.
}

#pragma mark Parameter Utilities

+ (NSString *)decodeURLString:(NSString *)string {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(NULL,
                                                                                    (CFStringRef)string,
                                                                                    CFSTR("")));
}

+ (NSDictionary *)queryParametersFromString:(NSString *)string {
    id value, key;
    NSRange equalsLocation;
    NSMutableDictionary *parameters;
    NSArray *queryComponents;
    NSNumberFormatter *numberFormatter;
    
    numberFormatter = [[NSNumberFormatter alloc] init];
    
    parameters = [[NSMutableDictionary alloc] init];
    // Split correctly.
    queryComponents = [string componentsSeparatedByString: @"&"];
    
    if ( [string isEqual: @""] )
        return @{};
    
    for ( NSString *component in queryComponents ) {
        equalsLocation = [component rangeOfString: @"="];
        if ( equalsLocation.location == NSNotFound )
            [parameters setObject: [NSNull null] // Set as null if no equal sign.
                           forKey: [[self class] decodeURLString:component]];
        else {
            // Get the key.
            key = [[self class] decodeURLString: [component substringToIndex:equalsLocation.location]];
            
            // Get the value in the correct format
            value = [[self class] decodeURLString: [component substringFromIndex:equalsLocation.location + 1]];
            if ( value ) {
                // Check if it's a number
                if ( [(NSString *)value conformsToExpression: [@"1234567890.-" toInclusiveExpression]])
                    value = [numberFormatter numberFromString: value];
                
                
                // Set it in the correct key.
                [parameters setObject: value forKey: key];
            }
        }
    }
    
    return [NSDictionary dictionaryWithDictionary: parameters];
}
@end
