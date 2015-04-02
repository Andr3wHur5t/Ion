//
//  FOSessionRequest.m
//  BlockpartySDK
//
//  Created by Andrew Hurst on 1/19/15.
//  Copyright (c) 2015 21e6. All rights reserved.
//

#import "FOSessionRequest.h"
#import "FOSession.h"

@implementation FOSessionRequest

@synthesize session = _session;
#pragma mark Constructors

- (instancetype)initWithSession:(FOSession *)session
                      urlString:(NSString *)string
                        andBody:(id)body {
  NSParameterAssert([session isKindOfClass:[FOSession class]]);
  if (![session isKindOfClass:[FOSession class]]) return NULL;
  self = [super initWithURLstring:string andBody:body];
  if (self) {
    _session = session;
  }
  return self;
}

- (instancetype)initWithSession:(FOSession *)session
                   andUrlString:(NSString *)string {
  NSParameterAssert([session isKindOfClass:[FOSession class]]);
  if (![session isKindOfClass:[FOSession class]]) return NULL;
  self = [super initWithURLstring:string andBody:NULL];
  if (self) {
    _session = session;
  }
  return self;
}

- (instancetype)initWithSession:(FOSession *)session andUrl:(NSURL *)url {
  NSParameterAssert([session isKindOfClass:[FOSession class]]);
  if (![session isKindOfClass:[FOSession class]]) return NULL;
  self = [super initWithURL:url andBody:NULL];
  if (self) {
    _session = session;
  }
  return self;
}

- (instancetype)initWithSession:(FOSession *)session
                            url:(NSURL *)url
                        andBody:(id)body {
  NSParameterAssert([session isKindOfClass:[FOSession class]]);
  if (![session isKindOfClass:[FOSession class]]) return NULL;
  self = [super initWithURL:url andBody:body];
  if (self) {
    _session = session;
  }
  return self;
}

#pragma mark Simple HTTP Intercepts

- (void)GET:(void (^)(NSHTTPURLResponse *, id, NSError *))callback {
  [self.session configureRequest:self];
  [super GET:[self.session interceptorCallbackForCallback:callback]];
}

- (void)POST:(void (^)(NSHTTPURLResponse *, id, NSError *))callback {
  [self.session configureRequest:self];
  [super POST:[self.session interceptorCallbackForCallback:callback]];
}

- (void)PUT:(void (^)(NSHTTPURLResponse *, id, NSError *))callback {
  [self.session configureRequest:self];
  [super PUT:[self.session interceptorCallbackForCallback:callback]];
}

- (void)DELETE:(void (^)(NSHTTPURLResponse *, id, NSError *))callback {
  [self.session configureRequest:self];
  [super DELETE:[self.session interceptorCallbackForCallback:callback]];
}

@end
