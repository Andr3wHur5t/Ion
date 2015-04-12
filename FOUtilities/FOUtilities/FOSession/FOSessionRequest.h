//
//  FOSessionRequest.h
//  BlockpartySDK
//
//  Created by Andrew Hurst on 1/19/15.
//  Copyright (c) 2015 21e6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FORequest.h"

@class FOSession;

@interface FOSessionRequest : FORequest

#pragma mark Constructors
/*!
 @brief Constructs a session request with the inputed session, and URL.

 @param session The session the request belongs to.
 @param string  The URL String the request is for.
 @param body    The body of the request.
 */
- (instancetype)initWithSession:(FOSession *)session
                      urlString:(NSString *)string
                        andBody:(id)body;

/*!
 @brief Constructs a session request with the inputed session, and URL.

 @param session The session the request belongs to.
 @param string  The URL the request is for.
 */
- (instancetype)initWithSession:(FOSession *)session
                   andUrlString:(NSString *)string;

/*!
 @brief Constructs a session request with the inputed session, and URL.

 @param session The session the request belongs to.
 @param url     The URL the request is for.
 */
- (instancetype)initWithSession:(FOSession *)session andUrl:(NSURL *)url;

/*!
 @brief Constructs a session request with the inputed session, and URL.

 @param session The session the request belongs to.
 @param url  The URL the request is for.
 @param body    The body of the request.
 */
- (instancetype)initWithSession:(FOSession *)session
                            url:(NSURL *)url
                        andBody:(id)body;

#pragma mark Session Management

/*!
 @brief The session the request belongs to.
 */
@property(weak, nonatomic, readonly) FOSession *session;

@end
