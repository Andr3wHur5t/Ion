//
//  IACLink.h
//  IACommunication
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * An internal native UI link. A link allows you to point to another part of the UI
 * without having a reference to it, while still allowing data to be exchanged with the target.
 *
 * You should also look at the wiki for more information on how this works.
 */
@interface IACLink : NSObject

#pragma mark URL Constructors
/**
 * Constructs the link using the inputted URL, reason, referral, and data.
 * @param url - the url to the receiver
 * @param reason - the reason you invoked the link.
 * @param referral - the referral link for the receiver to invoke once it's finished.
 * @param data - the data you want sent to the receiver to be processed.
 */
- (instancetype) initWithURL:(NSURL *)url
                      reason:(NSString *)reason
                referralLink:(IACLink *)referral
                     andData:(NSDictionary *)data;

/**
 * Constructs the link using the inputted URL, reason, and data.
 * @param url - the url to the receiver
 * @param reason - the reason you invoked the link.
 * @param data - the data you want sent to the receiver to be processed.
 */
- (instancetype) initWithURL:(NSURL *)url
                      reason:(NSString *)reason
                     andData:(NSDictionary *)data;

/**
 * Constructs the link using the inputted URL,, reason, and referral.
 * @param url - the url to the receiver
 * @param reason - the reason you invoked the link.
 * @param referral - the referral link for the receiver to invoke once it's finished.
 */
- (instancetype) initWithURL:(NSURL *)url
                      reason:(NSString *)reason
             andReferralLink:(IACLink *)referral;

/**
 * Constructs the link using the inputted URL, and reason.
 * @param url - the url to the receiver
 * @param reason - the reason you invoked the link.
 */
- (instancetype) initWithURL:(NSURL *)url andReason:(NSString *)reason;


/**
 * Constructs the link using the inputted URL, reason, and data.
 * @param url - the url to the receiver
 * @param reason - the reason you invoked the link.
 * @param data - the data you want sent to the receiver to be processed.
 */
+ (instancetype) linkWithURL:(NSURL *)url
                      reason:(NSString *)reason
                     andData:(NSDictionary *)data;

/**
 * Constructs the link using the inputted URL, reason, and referral.
 * @param url - the url to the receiver
 * @param reason - the reason you invoked the link.
 * @param referral - the referral link for the receiver to invoke once it's finished.
 */
+ (instancetype) linkWithURL:(NSURL *)url
                      reason:(NSString *)reason
             andReferralLink:(IACLink *)referral;

/**
 * Constructs the link using the inputted URL, and reason.
 * @param url - the url to the receiver
 * @param reason - the reason you invoked the link.
 */
+ (instancetype) linkWithURL:(NSURL *)url andReason:(NSString *)reason;

/**
 * Constructs the link using the inputted referral URL.
 * @param url - the url to the receiver
 */
+ (instancetype) referralLinkWithURL:(NSURL *)url;

#pragma mark String Constructors

/**
 * Constructs the link using the inputted URL string, reason, referral, and data.
 * @param urlString - the url to the receiver
 * @param reason - the reason you invoked the link.
 * @param referral - the referral link for the receiver to invoke once it's finished.
 * @param data - the data you want sent to the receiver to be processed.
 */
- (instancetype) initWithURLString:(NSString *)urlString
                            reason:(NSString *)reason
                      referralLink:(IACLink *)referral
                           andData:(NSDictionary *)data;

/**
 * Constructs the link using the inputted URL string, reason, and data.
 * @param urlString - the url to the receiver
 * @param reason - the reason you invoked the link.
 * @param data - the data you want sent to the receiver to be processed.
 */
- (instancetype) initWithURLString:(NSString *)urlString
                            reason:(NSString *)reason
                           andData:(NSDictionary *)data;

/**
 * Constructs the link using the inputted URL string, reason, and referral.
 * @param urlString - the url to the receiver
 * @param reason - the reason you invoked the link.
 * @param referral - the referral link for the receiver to invoke once it's finished.
 */
- (instancetype) initWithURLString:(NSString *)urlString
                            reason:(NSString *)reason
                   andReferralLink:(IACLink *)referral;

/**
 * Constructs the link using the inputted URL string, and reason.
 * @param urlString - the url to the receiver
 * @param reason - the reason you invoked the link.
 */
- (instancetype) initWithURLString:(NSString *)urlString andReason:(NSString *)reason;

/**
 * Constructs the link using the inputted URL string, reason, and data.
 * @param urlString - the url to the receiver
 * @param reason - the reason you invoked the link.
 * @param data - the data you want sent to the receiver to be processed.
 */
+ (instancetype) linkWithURLString:(NSString *)urlString
                            reason:(NSString *)reason
                           andData:(NSDictionary *)data;

/**
 * Constructs the link using the inputted URL string, reason, and referral.
 * @param urlString - the url to the receiver
 * @param reason - the reason you invoked the link.
 * @param referral - the referral link for the receiver to invoke once it's finished.
 */
+ (instancetype) linkWithURLString:(NSString *)urlString
                            reason:(NSString *)reason
                   andReferralLink:(IACLink *)referral;

/**
 * Constructs the link using the inputted URL string, and reason.
 * @param urlString - the url to the receiver
 * @param reason - the reason you invoked the link.
 */
+ (instancetype) linkWithURLString:(NSString *)urlString andReason:(NSString *)reason;

/**
 * Constructs the link using the inputted referral URL string.
 * @param url - the url to the receiver
 */
+ (instancetype) referralLinkWithURLString:(NSString *)urlString;

#pragma mark URL Information
/**
 * An array of all path components.
 */
@property (strong, nonatomic, readonly) NSArray *pathComponents;

/**
 * Constructs a copy of the current link, excluding our first component in our components list.
 */
- (instancetype) linkWithoutFirstComponent;

#pragma mark Link Parameters
// These are parameters that would normally be encoded as JSON into the URL but
// because we are passing these internally as native objects we can reduce our complexity
// by using internal values.

/**
 * Reason for invocation. Used for special behaviors on the receiver, and metrics.
 */
@property (strong ,nonatomic, readwrite) NSString *reason;

/**
 * The query string parameters in a dictionary for easy access.
 */
@property (strong, nonatomic, readonly) NSDictionary *parameters;

#pragma mark Referral
/**
 * The link user to return to the sender object.
 * @warning if you set the "data" property it will likely be overwritten by the sender.
 */
@property (strong ,nonatomic, readwrite) IACLink *referralLink;

#pragma mark native Parameters
/**
 * A Dictionary containing native data for the receiver to process.
 */
@property (strong, nonatomic, readwrite) NSDictionary *data;

#pragma mark Utilities
/**
 * Converts the link into string format, excluding the "data" parameter.
 */
- (NSString *)toString;

/**
 * Gets the links' URLs' string format
 */
- (NSString *)urlString;

/**
 * Gets a URL string from the inputted components
 * @param components - the components to composite into a url path.
 */
+ (NSString *)urlStringFromComponents:(NSArray *)components;

/**
 * Gets a URL using the plist schema with the inputted path string.
 * @param path - the path to generate the url with.
 */
+ (NSString *)urlStringFromPath:(NSString *)path;

#pragma mark Query String Utilities

/**
 * Gets the query parameters in dictionary format from the inputted URL query string.
 * @param string - the query string to be parsed.
 */
+ (NSDictionary *)queryParametersFromString:(NSString *)string;

@end
