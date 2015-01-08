//
//  FORequest.h
//  FOUtilities
//
//  Created by Andrew Hurst on 12/8/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FORequest : NSObject
#pragma mark Construction
/*!
 @brief Constructs a request with the inputted URL, and foundation payload.
 
 @param url     The URL for the request
 @param body The body of the request can be NSData, or NSDictionary.
 
 @return the configured request.
 */
- (instancetype)initWithURL:(NSURL *)url andBody:(id)body;

- (instancetype)initWithURLstring:(NSString *)url andBody:(id)body;

- (instancetype)initWithURLTemplate:(NSString *)templateUrl andParameters:(NSDictionary *)parameters;
#pragma mark Configuration
/*!
 @brief The URL of the request.
 */
@property (strong, nonatomic, readwrite) NSURL *url;

/*!
 @brief The body of the request.
 */
@property (strong, nonatomic, readwrite) id body;

/*!
 @brief The content type string of the request.
 */
@property (strong, nonatomic, readwrite) NSString *contentType;

/*!
 @brief The requests headers.
 */
@property (strong, nonatomic, readonly) NSMutableDictionary *headers;

/*!
 @brief The cache policy of the request.
 */
@property (assign, nonatomic, readwrite) NSURLRequestCachePolicy cachePolicy;

#pragma mark Connection Types
/*!
 @brief Performs a GET request with the current configuration.
 
 @param callback The callback to be called with the data, or foundation object.
 */
- (void)GET:(void(^)(NSHTTPURLResponse *response, id data, NSError *error))callback;

/*!
 @brief Performs a POST request with the current configuration.
 
 @param callback The callback to be called with the data, or foundation object.
 */
- (void)POST:(void(^)(NSHTTPURLResponse *response, id data, NSError *error))callback;

/*!
 @brief Performs a DELETE request with the current configuration.
 
 @param callback The callback to be called with the data, or foundation object.
 */
- (void)DELETE:(void(^)(NSHTTPURLResponse *response, id data, NSError *error))callback;

/*!
 @brief Performs a PUT request with the current configuration.
 
 @param callback The callback to be called with the data, or foundation object.
 */
- (void)PUT:(void(^)(NSHTTPURLResponse *response, id data, NSError *error))callback;

#pragma mark Internal

- (NSURLRequest *)requestWithType:(NSString *)requestType;

@end

#pragma mark Keys

static NSString *const sBPRequestContentType_JSON = @"application/json";
static NSString *const sBPRequestContentType_JPEG = @"image/jpeg";
static NSString *const sBPRequestContentType_PNG = @"image/png";
static NSString *const sBPRequestContentType_TXT = @"text/plain";

static NSString *const sBPRequestContentTypeCharSet_UTF8 = @"charset=utf-8";

