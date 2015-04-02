//
//  FOSession.h
//  BlockpartySDK
//
//  Created by Andrew Hurst on 1/19/15.
//  Copyright (c) 2015 21e6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FOSessionRequest.h"

typedef enum : NSUInteger {
                 FOSessionState_Invalid = 0,
                 FOSessionState_Valid,
                 FOSessionState_Unknown,
               } FOSessionState;

@interface FOSession : NSObject

/*!
 @brief Constructs the session with the inputed token and name.

 @param token The token associated with the session.
 @param name  The name of the session.

 @return The constructed session manager.
 */
- (instancetype)initWithToken:(NSString *)token
                   expiration:(NSTimeInterval)expiration
                      andName:(NSString *)name;

/*!
 @brief Constructs the session with the inputed token, name, and extra
 information.


 @param token       The token associated with the session.
 @param expiration  The expiration of the token
 @param name        The name of the session.
 @param extra       The extra Info for the token

 @return The constructed session manager.
 */
- (instancetype)initWithToken:(NSString *)token
                   expiration:(NSTimeInterval)expiration
                         name:(NSString *)name
                     andExtra:(NSDictionary *)extra;

/*!
 @brief Constructs a session restored from the cache if available.

 @param name The name of the session to restore.

 @return The restored session, or NULL.
 */
- (instancetype)initRestoredSessionWithName:(NSString *)name;

#pragma mark Session Management

/*!
 @brief Removes the session from the cache.
 */
- (void)invalidateSession;

#pragma mark Session State Management

/*!
 @brief The current state of the session.
 */
@property(assign, nonatomic, readonly) FOSessionState state;

/*!
 @brief Adds a target action set to be invoked when the state of the session
 changes.

 @param target The target to add.
 @param action The action to add.
 */
- (void)addStateChangeTarget:(id)target andAction:(SEL)action;

#pragma mark Session Configuration
/*!
 @brief The name of the session.
 */
@property(strong, nonatomic, readonly) NSString *name;

/*!
 @brief The sessions token.
 */
@property(strong, nonatomic, readonly) NSString *token;

/*!
 @brief The Extra information associated with the session.
 */
@property(strong, nonatomic, readonly) NSDictionary *extra;

/*!
 @brief The time the token will expire.
 */
@property(assign, nonatomic, readonly) NSTimeInterval tokenExpiration;

#pragma mark Session Request Interface

/*!
 @brief Configures the request for the session.

 @param request The request to configure.

 @return The configured request.
 */
- (void)configureRequest:(FORequest *)request;

/*!
 @brief Returns an interceptor callback for session requests.

 @param callback The callback to invoke after interception.
 */
- (void (^)(NSHTTPURLResponse *, id, NSError *))interceptorCallbackForCallback:
        (void (^)(NSHTTPURLResponse *, id, NSError *))callback;

#pragma mark Session Persistence Check

/*!
 @brief Checks if the session with the specified name has persisted within the
 cache.

 @param sessionName The session to check.

 @return True if the persisted session is supposedly valid.
 */
+ (BOOL)sessionHasPersistedWithName:(NSString *)sessionName;

@end
