//
//  FOSession.m
//  BlockpartySDK
//
//  Created by Andrew Hurst on 1/19/15.
//  Copyright (c) 2015 21e6. All rights reserved.
//

#import "FOSession.h"

static NSString *kFOSessionTokenKey = @"token";
static NSString *kFOSessionTokenExpirationKey = @"tokenExpiration";
static NSString *kFOSessionExtraKey = @"extra";

@implementation FOSession

#pragma mark Construction

- (instancetype)initWithToken:(NSString *)token
                   expiration:(NSTimeInterval)expiration
                      andName:(NSString *)name {
  self =
      [self initWithToken:token expiration:expiration name:name andExtra:NULL];
  return self;
}

- (instancetype)initWithToken:(NSString *)token
                   expiration:(NSTimeInterval)expiration
                         name:(NSString *)name
                     andExtra:(NSDictionary *)extra {
  self = [self init];
  if (self) {
    _token = token;
    _tokenExpiration = expiration;
    _name = name;
    _extra = extra;
    [self saveToCache];
  }
  return self;
}

- (instancetype)initRestoredSessionWithName:(NSString *)name {
  NSDictionary *sessionInfo, *extra;
  NSString *token;
  NSNumber *expirationNum;
  NSParameterAssert([name isKindOfClass:[NSString class]]);
  if (![name isKindOfClass:[NSString class]]) return NULL;

  // Get session info & Validate
  sessionInfo = [[self class] sessionInfoForName:name];
  if (![sessionInfo isKindOfClass:[NSDictionary class]]) return NULL;
  if ([[self class] sessionWithInfoHasExpired:sessionInfo]) return NULL;

  // Set states
  token = [sessionInfo objectForKey:kFOSessionTokenKey];
  if (![token isKindOfClass:[NSString class]]) return NULL;

  expirationNum = [sessionInfo objectForKey:kFOSessionTokenExpirationKey];
  if (![expirationNum isKindOfClass:[NSNumber class]]) return NULL;

  extra = [sessionInfo objectForKey:kFOSessionExtraKey];
  if (![extra isKindOfClass:[NSDictionary class]]) return NULL;

  return [self initWithToken:token
                  expiration:[expirationNum doubleValue]
                        name:name
                    andExtra:extra];
}

#pragma mark Session Management

- (void)saveToCache {
  [[self class] persistSessionWithName:self.name
                                 token:self.token
                            expiration:self.tokenExpiration
                              andExtra:self.extra];
}

- (void)invalidateSession {
  [[self class] removeSessionWithName:self.name];
}

#pragma mark Session State Management

- (void)addStateChangeTarget:(id)target andAction:(SEL)action {
}

#pragma mark Session Request Interface

- (void)configureRequest:(FORequest *)request {
  // Set headers of request to match the state of our
  NSLog(@"Set Headers of request");
}

- (void (^)(NSHTTPURLResponse *, id, NSError *))
    interceptorCallbackForCallback:(void (^)(NSHTTPURLResponse *, id,
                                             NSError *))callback {
  __block void (^sCallback)(NSHTTPURLResponse *, id, NSError *) = callback;
  NSParameterAssert(callback);
  if (!callback) return NULL;

  return ^(NSHTTPURLResponse *response, id data, NSError *error) {
      // TODO: Run internal Processing on response to see if our state has
      // changed.
      sCallback(response, data, error);
  };
}

#pragma mark Session Persistences

+ (BOOL)sessionHasPersistedWithName:(NSString *)sessionName {
  NSDictionary *sessionInfo;
  if (![sessionName isKindOfClass:[NSString class]]) return FALSE;

  sessionInfo = [self sessionInfoForName:sessionName];
  if (![sessionInfo isKindOfClass:[NSDictionary class]]) return FALSE;

  return ![self sessionWithInfoHasExpired:sessionInfo];
}

+ (BOOL)sessionWithInfoHasExpired:(NSDictionary *)sessionInfo {
  NSNumber *tokenExpiration;
  if (![sessionInfo isKindOfClass:[NSDictionary class]]) return TRUE;

  tokenExpiration = [sessionInfo objectForKey:@"tokenExpiration"];
  if (![tokenExpiration isKindOfClass:[NSNumber class]]) return TRUE;

  // Expiration is past now?
  return [tokenExpiration doubleValue] <= [NSDate date].timeIntervalSince1970;
}

+ (NSDictionary *)sessionInfoForName:(NSString *)sessionName {
  NSDictionary *sessionInfo, *managedSessions;
  if (![sessionName isKindOfClass:[NSString class]]) return NULL;

  managedSessions =
      [[NSUserDefaults standardUserDefaults] objectForKey:@"managedSessions"];
  if (![managedSessions isKindOfClass:[NSDictionary class]]) return NULL;

  sessionInfo = [managedSessions objectForKey:sessionName];
  if (![sessionInfo isKindOfClass:[NSDictionary class]]) return NULL;

  return sessionInfo;
}

+ (void)removeSessionWithName:(NSString *)sessionName {
  NSDictionary *dict;
  NSMutableDictionary *managedSessionInfo;
  NSUserDefaults *defaults;
  NSParameterAssert([sessionName isKindOfClass:[NSString class]]);

  defaults = [NSUserDefaults standardUserDefaults];

  dict = [defaults objectForKey:@"managedSessions"];

  managedSessionInfo = [[NSMutableDictionary alloc]
      initWithDictionary:[dict isKindOfClass:[NSDictionary class]] ? dict
                                                                   : @{}];
  if (![managedSessionInfo isKindOfClass:[NSMutableDictionary class]]) return;

  [managedSessionInfo removeObjectForKey:sessionName];

  [defaults setObject:managedSessionInfo forKey:@"managedSessions"];
  [defaults synchronize];

  NSLog(@"Removed session with name '%@'", sessionName);
}

+ (void)saveSessionInfo:(NSDictionary *)info forName:(NSString *)name {
  NSDictionary *dict;
  NSMutableDictionary *managedSessionInfo;
  NSUserDefaults *defaults;
  NSParameterAssert([info isKindOfClass:[NSDictionary class]]);
  NSParameterAssert([name isKindOfClass:[NSString class]]);

  defaults = [NSUserDefaults standardUserDefaults];

  dict = [defaults objectForKey:@"managedSessions"];

  managedSessionInfo = [[NSMutableDictionary alloc]
      initWithDictionary:[dict isKindOfClass:[NSDictionary class]] ? dict
                                                                   : @{}];
  if (![managedSessionInfo isKindOfClass:[NSMutableDictionary class]]) return;

  [managedSessionInfo setObject:info forKey:name];

  [defaults setObject:managedSessionInfo forKey:@"managedSessions"];
  [defaults synchronize];
}

+ (void)persistSessionWithName:(NSString *)name
                         token:(NSString *)token
                    expiration:(NSTimeInterval)expiration
                      andExtra:(NSDictionary *)extra {
  NSParameterAssert([token isKindOfClass:[NSString class]]);
  NSParameterAssert([name isKindOfClass:[NSString class]]);
  if (![token isKindOfClass:[NSString class]] ||
      ![name isKindOfClass:[NSString class]])
    return;

  [self saveSessionInfo:@{
    kFOSessionTokenKey : token,
    kFOSessionTokenExpirationKey : @(expiration),
    kFOSessionExtraKey : [extra isKindOfClass:[NSDictionary class]] ? extra
                                                                    : @{}
  } forName:name];
}
@end
