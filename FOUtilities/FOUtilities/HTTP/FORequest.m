//
//  FORequest.m
//  FOUtilities
//
//  Created by Andrew Hurst on 12/8/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "FORequest.h"

@interface FORequest ()

@property(strong, nonatomic, readwrite) NSData *bodyAsData;

@end

@implementation FORequest

@synthesize headers = _headers;

#pragma mark Construction

- (instancetype)init {
  self = [super init];
  if (self) {
    self.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    self.timeoutInterval = 240.0f;
  }
  return self;
}

- (instancetype)initWithURL:(NSURL *)url andBody:(id)body {
  NSParameterAssert([url isKindOfClass:[NSURL class]]);
  if (![url isKindOfClass:[NSURL class]]) return NULL;

  self = [super init];
  if (self) {
    self.url = url;
    self.body = body;
  }
  return self;
}

- (instancetype)initWithURLstring:(NSString *)url andBody:(id)body {
  NSURL *localUrl;
  NSParameterAssert([url isKindOfClass:[NSString class]]);
  if (![url isKindOfClass:[NSString class]]) return NULL;

  localUrl = [NSURL URLWithString:url];
  if (![localUrl isKindOfClass:[NSURL class]]) return NULL;

  return [self initWithURL:localUrl andBody:body];
}

- (instancetype)initWithURLTemplate:(NSString *) template
                      andParameters:(NSDictionary *)parameters {
  NSString *completedTemplate, *replacedKey, *value;
  NSMutableDictionary *body;
  NSMutableArray *usedKeys;
  NSRange sizeRange, locationRange;
  NSParameterAssert([template isKindOfClass:[NSString class]]);
  NSParameterAssert([parameters isKindOfClass:[NSDictionary class]]);
  if (![template isKindOfClass:[NSString class]] ||
      ![parameters isKindOfClass:[NSDictionary class]])
    return NULL;

  // Setup
  usedKeys = [[NSMutableArray alloc] init];
  completedTemplate = template;
  sizeRange = NSMakeRange(0, [completedTemplate length]);

  // Enumerate keys to complete URL template
  for (NSString *key in parameters) {
    replacedKey = [NSString stringWithFormat:@":%@", key];

    // Is it in the string?
    locationRange =
        [template rangeOfString:replacedKey options:0 range:sizeRange];
    if (locationRange.location != NSNotFound) {
      value = [parameters objectForKey:key];
      if (value)
        // Relace the instance
        completedTemplate = [completedTemplate
            stringByReplacingOccurrencesOfString:replacedKey
                                      withString:[value description]];

      // Mark it as used
      [usedKeys addObject:key];
    }
  }

  // Set Body
  body = [[NSMutableDictionary alloc] initWithDictionary:parameters
                                               copyItems:true];
  [body removeObjectsForKeys:usedKeys];
  if (body.allKeys.count == 0) body = NULL;

  // Make Request
  return [self initWithURLstring:completedTemplate andBody:body];
}

#pragma mark Body

+ (BOOL)automaticallyNotifiesObserversOfBody {
  return false;
}

- (void)setBody:(id)body {
  [self willChangeValueForKey:@"body"];
  _body = body;
  [self didChangeValueForKey:@"body"];

  if ([body isKindOfClass:[NSData class]]) {
    self.bodyAsData = _body;  // Data
                              // Auto Set content type?
  } else if ([body isKindOfClass:[NSDictionary class]]) {
    self.bodyAsData = [[self class] processDictionary:_body];
    self.contentType = [[self class] dictionaryBodyContentType];
  } else if ([body isKindOfClass:[NSString class]]) {
    self.bodyAsData = [(NSString *)_body dataUsingEncoding:NSUTF8StringEncoding
                                      allowLossyConversion:TRUE];
    self.contentType =
        [NSString stringWithFormat:@"%@; %@", sBPRequestContentType_TXT,
                                   sBPRequestContentTypeCharSet_UTF8];
  } else if ([body isKindOfClass:[UIImage class]]) {
    self.bodyAsData = UIImagePNGRepresentation((UIImage *)_body);
    self.contentType = sBPRequestContentType_PNG;
  }
}

+ (NSData *)processDictionary:(NSDictionary *)dict {
  NSError *serlizationError;
  NSData *data;
  if (![dict isKindOfClass:[NSDictionary class]]) return NULL;

  data = [NSJSONSerialization dataWithJSONObject:dict
                                         options:0
                                           error:&serlizationError];

  if (serlizationError) {
    NSLog(@"Failed to serlize dictionary because \"%@\"",
          serlizationError.description);
    return NULL;
  }
  return data;
}

+ (NSString *)dictionaryBodyContentType {
  return @"application/json";
}

#pragma mark Headers

- (NSMutableDictionary *)headers {
  if (!_headers) _headers = [[NSMutableDictionary alloc] init];
  return _headers;
}

#pragma mark Request Generation

- (NSURLRequest *)requestWithType:(NSString *)requestType {
  NSMutableURLRequest *request;
  NSParameterAssert([requestType isKindOfClass:[NSString class]]);
  if (![self.url isKindOfClass:[NSURL class]] ||
      ![requestType isKindOfClass:[NSString class]])
    return NULL;
  request = [[NSMutableURLRequest alloc] initWithURL:self.url];
  request.HTTPMethod = requestType;

  if (![self.bodyAsData isKindOfClass:[NSData class]] &&
      [[self class] requestTypeRequiresBody:requestType])
    self.body = @{};  // Set as empty dict
  request.HTTPBody = self.bodyAsData;

  // Set other headers
  request.allHTTPHeaderFields =
      [NSDictionary dictionaryWithDictionary:self.headers];
  request.cachePolicy = self.cachePolicy;

  request.timeoutInterval = self.timeoutInterval;

  if ([self.contentType isKindOfClass:[NSString class]])
    [request setValue:self.contentType forHTTPHeaderField:@"Content-Type"];

  return request;
}

+ (BOOL)requestTypeRequiresBody:(NSString *)requestType {
  if ([requestType isEqualToString:@"POST"])
    return true;
  else if ([requestType isEqualToString:@"PUT"])
    return true;
  else
    return false;
}

#pragma mark Connections

- (void)GET:(void (^)(NSHTTPURLResponse *response, id data,
                      NSError *error))callback {
  [self connectionWithRequestType:@"GET" andCallback:callback];
}

- (void)POST:(void (^)(NSHTTPURLResponse *response, id data,
                       NSError *error))callback {
  [self connectionWithRequestType:@"POST" andCallback:callback];
}

- (void)DELETE:(void (^)(NSHTTPURLResponse *response, id data,
                         NSError *error))callback {
  [self connectionWithRequestType:@"DELETE" andCallback:callback];
}

- (void)PUT:(void (^)(NSHTTPURLResponse *response, id data,
                      NSError *error))callback {
  [self connectionWithRequestType:@"PUT" andCallback:callback];
}

- (void)connectionWithRequestType:(NSString *)type
                      andCallback:(void (^)(NSHTTPURLResponse *response,
                                            id data, NSError *error))callback {
  NSURLRequest *request;
  NSParameterAssert([type isKindOfClass:[NSString class]]);
  if (![type isKindOfClass:[NSString class]] || !callback) return;

  __block void (^safeCallback)(NSHTTPURLResponse * response, id data,
                               NSError * error) = callback;

  request = [self requestWithType:type];
  if (![request isKindOfClass:[NSURLRequest class]]) {
    safeCallback(NULL, NULL,
                 [NSError errorWithDomain:@"" code:0 userInfo:NULL]);
    return;
  }

  [NSURLConnection
      sendAsynchronousRequest:request
                        queue:[[self class] connectionQueue]
            completionHandler:^(NSURLResponse *response, NSData *data,
                                NSError *connectionError) {
                NSError *proccessingError;
                NSHTTPURLResponse *httpResponse;
                NSString *contentTypeString;
                NSArray *contentTypeComponents;
                id processedData;

                if ([response isKindOfClass:[NSHTTPURLResponse class]])
                  httpResponse = (NSHTTPURLResponse *)response;

                if ([connectionError isKindOfClass:[NSError class]]) {
                  safeCallback(httpResponse, NULL, connectionError);
                  return;
                }

                // Detect Content Type
                if ([[httpResponse allHeaderFields]
                        isKindOfClass:[NSDictionary class]])
                  contentTypeString = [[httpResponse allHeaderFields]
                      objectForKey:@"Content-Type"];
                if ([contentTypeString isKindOfClass:[NSString class]])
                  contentTypeComponents =
                      [contentTypeString componentsSeparatedByString:@";"];

                // Parse Data
                if ([[self class] array:contentTypeComponents
                         containsString:sBPRequestContentType_JSON]) {
                  processedData = [NSJSONSerialization
                      JSONObjectWithData:data
                                 options:0
                                   error:&proccessingError];
                } else if ([[self class] array:contentTypeComponents
                                containsString:sBPRequestContentType_JPEG]) {
                  processedData = [UIImage imageWithData:data];

                } else if ([[self class] array:contentTypeComponents
                                containsString:sBPRequestContentType_PNG]) {
                  processedData = [UIImage imageWithData:data];

                } else if ([[self class] array:contentTypeComponents
                                containsString:sBPRequestContentType_TXT]) {
                  // TODO: take encoding from content type
                  processedData =
                      [[NSString alloc] initWithData:data
                                            encoding:NSUTF8StringEncoding];
                } else {
                  processedData = data;
                  proccessingError = connectionError;
                }

                // Give Response to callback
                safeCallback(httpResponse, processedData, proccessingError);
            }];
}

#pragma mark Queue

+ (NSOperationQueue *)connectionQueue {
  static dispatch_once_t onceToken;
  static NSOperationQueue *operationQueue;
  dispatch_once(&onceToken,
                ^{ operationQueue = [[NSOperationQueue alloc] init]; });
  return operationQueue;
}

#pragma mark Utilties

- (NSString *)description {
  return
      [NSString stringWithFormat:@"URL:\"%@\",content-type:\"%@\",Body:\"%@\"",
                                 self.url, self.contentType, self.body];
}

+ (BOOL)array:(NSArray *)array containsString:(NSString *)string {
  NSString *processedString;
  if (![array isKindOfClass:[NSArray class]] ||
      ![string isKindOfClass:[NSString class]])
    return FALSE;

  processedString =
      [string stringByReplacingOccurrencesOfString:@" " withString:@""];
  for (NSString *item in array)
    if ([[item stringByReplacingOccurrencesOfString:@" " withString:@""]
            isEqualToString:processedString])
      return TRUE;

  return FALSE;
}

@end
