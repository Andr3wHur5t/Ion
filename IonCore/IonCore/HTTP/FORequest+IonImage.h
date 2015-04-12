//
//  FORequest+IonImage.h
//  IonCore
//
//  Created by Andrew Hurst on 12/8/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <FOUtilities/FOUtilities.h>

@interface FORequest (IonImage)
/*!
 @brief Retrieves an image at the specified path.
 
 @param path     The image key or the URL.
 @param callback The callback to call with the resulting data.
 */
+ (void)getImageAt:(NSString *)path
      withCallback:(void (^)(UIImage *image, NSError *error))callback;
@end
