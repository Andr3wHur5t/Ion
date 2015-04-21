//
//  UIView+IonBackgroundUtilities.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonBackgroundUtilities.h"
#import "UIView+IonTheme.h"
#import <IonData/IonData.h>
#import <SimpleMath/SimpleMath.h>

@implementation UIView (IonBackgroundUtilities)

#pragma mark Gradient Backgrounds

- (void)setBackgroundToLinearGradient:
            (IonLinearGradientConfiguration *)gradientConfig
                           completion:(void (^)())completion {
  CGSize netSize = CGSizeEqualToSize(self.frame.size, CGSizeZero)
                       ? (CGSize){300, 300}
                       : self.frame.size;
  NSLog(@"Applying Background to view with size: %@",
        NSStringFromCGSize(netSize));
  // Generate and set the gradient
  [IonRenderUtilities renderLinearGradient:gradientConfig
                                resultSize:netSize
                           withReturnBlock:^(UIImage *image) {
                             self.layer.contents = (__bridge id)(image.CGImage);

                             if (completion) completion();
                           }];
}

- (void)setBackgroundToLinearGradient:
        (IonLinearGradientConfiguration *)gradientConfig {
  [self setBackgroundToLinearGradient:gradientConfig completion:NULL];
}

#pragma mark Image Backgrounds

+ (void)setImage:(UIImage *)image
         toLayer:(CALayer *)layer
      renderMode:(IonBackgroundRenderOptions)renderMode
      completion:(void (^)(NSError *))completion {
  void (^returnBlock)(UIImage *resImage);
  __block void (^sCom)(NSError *) = completion;
  if (![image isKindOfClass:[UIImage class]] ||
      ![layer isKindOfClass:[CALayer class]]) {
    if (sCom)
      sCom([NSError errorWithDomain:@"com.ion.backgrounds"
                               code:-201

                           userInfo:@{
                             NSLocalizedDescriptionKey :
                                 @"Can't set a image to layer because one or "
                             @"both parameters are NULL."
                           }]);
    return;
  }

  if (CGSizeEqualToSize(CGSizeZero, layer.frame.size)) {
    if (sCom)
      sCom([NSError errorWithDomain:@"com.ion.backgrounds"
                               code:-202

                           userInfo:@{
                             NSLocalizedDescriptionKey :
                                 @"Attempted to set image to a view with a "
                             @"size of {0,0} aborting."
                           }]);
    return;
  }
  // Our Return Block
  returnBlock = ^(UIImage *resImage) {
    if (!resImage.CGImage) {
      if (sCom)
        sCom([NSError
            errorWithDomain:@"com.ion.backgrounds"
                       code:-203
                   userInfo:@{
                     NSLocalizedDescriptionKey : @"Failed to resize image."
                   }]);
      return;
    }

    layer.contents = (id)(resImage.CGImage);
    if (sCom) sCom(NULL);
  };

  // Check if the image is already the corrent size
  if (CGSizeEqualToSize(image.size, layer.frame.size)) {
    returnBlock(image);  // call the return block because we are already the
    // correct size.
    return;
  }

  if (renderMode == IonBackgroundRenderContained)
    [IonRenderUtilities renderImage:image
                         withinSize:layer.frame.size
                     andReturnBlock:returnBlock];
  else
    [IonRenderUtilities renderImage:image
                           withSize:layer.frame.size
                     andReturnBlock:returnBlock];
}

+ (void)setImage:(UIImage *)image
         toLayer:(CALayer *)layer
      renderMode:(IonBackgroundRenderOptions)renderMode {
  [self setImage:image
         toLayer:layer
      renderMode:renderMode
      completion:^(NSError *e) {
        if ([e isKindOfClass:[NSError class]])
          NSLog(@"%s -- %@", __func__, e.localizedDescription);
      }];
}

#pragma mark Background

- (void)setBackgroundImage:(UIImage *)image {
  [self setBackgroundImage:image renderMode:IonBackgroundRenderFilled];
}

- (void)setBackgroundImage:(UIImage *)image
                renderMode:(IonBackgroundRenderOptions)renderMode {
  [self setBackgroundImage:image
                renderMode:renderMode
                completion:^(NSError *e) {
                  if ([e isKindOfClass:[NSError class]])
                    NSLog(@"%s -- %@", __func__, e.localizedDescription);
                }];
}

- (void)setBackgroundImage:(UIImage *)image
                renderMode:(IonBackgroundRenderOptions)renderMode
                completion:(void (^)(NSError *))completion {
  if (!image) {
    self.styleCanSetBackground = TRUE;
    return;
  }

  self.styleCanSetBackground = FALSE;
  [UIView setImage:image
           toLayer:self.layer
        renderMode:renderMode
        completion:completion];
}

- (void)setBackgroundImageUsingKey:(NSString *)key {
  [self setBackgroundImageUsingKey:key inRenderMode:IonBackgroundRenderFilled];
}

- (void)setBackgroundImageUsingKey:(NSString *)key
                      inRenderMode:(IonBackgroundRenderOptions)renderMode {
  [self setBackgroundImageUsingKey:key
                      inRenderMode:renderMode
                        completion:^(NSError *e) {
                          if ([e isKindOfClass:[NSError class]])
                            NSLog(@"%s -- %@", __func__,
                                  e.localizedDescription);
                        }];
}

- (void)setBackgroundImageUsingKey:(NSString *)key
                      inRenderMode:(IonBackgroundRenderOptions)renderMode
                        completion:(void (^)(NSError *))completion {
  __block void (^sCom)(NSError *) = completion;
  [[IonImageManager interfaceManager]
            imageForKey:key
               withSize:self.frame.size
               contined:renderMode == IonBackgroundRenderContained
      andReturnCallback:^(UIImage *image) {
        if (![image isKindOfClass:[UIImage class]]) {
          if (sCom)
            sCom([NSError
                errorWithDomain:@"com.ion.backgrounds"
                           code:-200
                       userInfo:@{
                         NSLocalizedDescriptionKey : [NSString
                             stringWithFormat:
                                 @"Failed to load image for key \"%@\".", key]
                       }]);
          return;
        }

        [self setBackgroundImage:image renderMode:renderMode completion:sCom];
      }];
}

#pragma mark Mask

- (void)setMaskImage:(UIImage *)image {
  [self setMaskImage:image renderMode:IonBackgroundRenderContained];
}

- (void)setMaskImage:(UIImage *)image
          renderMode:(IonBackgroundRenderOptions)renderMode {
  [self setMaskImage:image
          renderMode:renderMode
          completion:^(NSError *e) {
            if ([e isKindOfClass:[NSError class]])
              NSLog(@"%s -- %@", __func__, e.localizedDescription);
          }];
}

- (void)setMaskImage:(UIImage *)image
          renderMode:(IonBackgroundRenderOptions)renderMode
          completion:(void (^)(NSError *))completion {
  if (!image) return;

  if (!self.layer.mask) self.layer.mask = [CALayer layer];
  self.layer.mask.frame = self.bounds;
  [UIView setImage:image
           toLayer:self.layer.mask
        renderMode:renderMode
        completion:completion];
}

- (void)setMaskImageUsingKey:(NSString *)key {
  [self setMaskImageUsingKey:key inRenderMode:IonBackgroundRenderContained];
}

- (void)setMaskImageUsingKey:(NSString *)key
                inRenderMode:(IonBackgroundRenderOptions)renderMode {
  [self setMaskImageUsingKey:key
                inRenderMode:renderMode
                  completion:^(NSError *e) {
                    if ([e isKindOfClass:[NSError class]])
                      NSLog(@"%s -- %@", __func__, e.localizedDescription);
                  }];
}

- (void)setMaskImageUsingKey:(NSString *)key
                inRenderMode:(IonBackgroundRenderOptions)renderMode
                  completion:(void (^)(NSError *))completion {
  __block void (^sCom)(NSError *) = completion;
  NSParameterAssert([key isKindOfClass:[NSString class]]);
  if (![key isKindOfClass:[NSString class]]) return;

  [[IonImageManager interfaceManager]
            imageForKey:key
               withSize:self.frame.size
               contined:renderMode == IonBackgroundRenderContained
      andReturnCallback:^(UIImage *image) {
        if (![image isKindOfClass:[UIImage class]]) {
          if (sCom)
            sCom([NSError
                errorWithDomain:@"com.ion.backgrounds"
                           code:-200
                       userInfo:@{
                         NSLocalizedDescriptionKey : [NSString
                             stringWithFormat:
                                 @"Failed to load image for key \"%@\".", key]
                       }]);
          return;
        }

        [self setMaskImage:image renderMode:renderMode completion:sCom];
      }];
}

#pragma mark Utilities

- (BOOL)isVisible {
  return self.isHidden && self.alpha != 0.0f;
}

@end
