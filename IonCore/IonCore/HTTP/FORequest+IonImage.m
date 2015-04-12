//
//  FORequest+IonImage.m
//  IonCore
//
//  Created by Andrew Hurst on 12/8/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "FORequest+IonImage.h"
#import <IonCore/IonCore.h>

@implementation FORequest (IonImage)

+ (void)getImageAt:(NSString *)path
      withCallback:(void (^)(UIImage *image, NSError *error))callback {
  __block NSString *safePath;
  __block void (^safeCallback)(UIImage * image, NSError * error);
  FORequest *imageRequest;
  NSRange httpRange;
  NSParameterAssert([path isKindOfClass:[NSString class]]);
  if (![path isKindOfClass:[NSString class]] || !callback) return;
  
  // Set safe values
  safePath = path;
  safeCallback = callback;
  
  // Look for HTTP
  httpRange = [path rangeOfString:@"http"
                          options:0
                            range:NSMakeRange(0, [@"http" length])];
  
  if (httpRange.location == NSNotFound) {
    // Keyed Image, Do work in background
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                     // Do work in background
                     [[IonImageManager interfaceManager]
                      imageForKey:safePath
                      withReturnCallback:^(UIImage *image){
                        if ( !image ) {
                          safeCallback(NULL, [NSError errorWithDomain:@"failed to retrive image." code:0 userInfo:NULL]);
                          return;
                          
                        } else {
                          safeCallback( image, NULL );
                        }
                      }];
                   });
  } else {
    // URL
    imageRequest = [[FORequest alloc] initWithURLstring:safePath andBody:NULL];
    // Set Cache Policy
    
    [imageRequest GET:^(NSHTTPURLResponse *response, id data, NSError *error) {
      __block UIImage *safeImge;
      NSError *processError;
      
      if (error) {
        safeCallback(NULL, error);
        return;
        
      } else if (response.statusCode != 200) {
        processError = [NSError
                        errorWithDomain:[NSString
                                         stringWithFormat:@"Image not found at '%@'",
                                         response.URL]
                        code:response.statusCode
                        userInfo:NULL];
        safeCallback(NULL, processError);
        return;
        
      } else {
        if (![data isKindOfClass:[UIImage class]]) {
          processError = [NSError
                          errorWithDomain:
                          [NSString stringWithFormat:@"Failed to retrive image from "
                           @"'%@' because 'data did not "
                           @"have content type of PNG, or "
                           @"JEPG'.",
                           response.URL]
                          code:response.statusCode
                          userInfo:NULL];
          safeCallback(NULL, processError);
          return;
        } else {
          safeImge = (UIImage *)data;
          dispatch_async(dispatch_get_global_queue(
                                                   DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
                         ^{
                           // Make sure they run their work on another queue so we can
                           // perform aditional requests.
                           safeCallback(safeImge, NULL);
                         });
        }
      }
      
    }];
  }
}
@end

