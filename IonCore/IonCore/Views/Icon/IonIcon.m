//
//  IonIcon.m
//  Ion
//
//  Created by Andrew Hurst on 9/12/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonIcon.h"
#import "UIView+IonBackgroundUtilities.h"
#import "UIView+IonTheme.h"
#import <IonData/IonData.h>

@implementation IonIcon

@synthesize image = _image;
@synthesize imageKey = _imageKey;

#pragma mark Constructors

- (instancetype)init {
  self = [super init];
  if (self) [self construct];
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) [self construct];
  return self;
}

- (instancetype)initWithImage:(UIImage *)image {
  self = [self init];
  if (self) self.image = image;
  return self;
}

- (instancetype)initWithImageKey:(NSString *)imageKey {
  self = [self init];
  if (self) self.imageKey = imageKey;
  return self;
}

- (void)construct {
  self.themeElement = sIonIconViewKey;
  self.styleCanSetSize = TRUE;
}
#pragma mark Configuration

+ (BOOL)automaticallyNotifiesObserversOfImage {
  return FALSE;
}

- (void)setImage:(UIImage *)image {
  NSParameterAssert([image isKindOfClass:[UIImage class]]);
  if (![image isKindOfClass:[UIImage class]]) return;
  [self willChangeValueForKey:@"image"];
  _image = image;
  [self didChangeValueForKey:@"image"];
  [self setMaskImage:_image renderMode:IonBackgroundRenderFilled];
}

+ (BOOL)automaticallyNotifiesObserversOfImageKey {
  return FALSE;
}

- (void)setImageKey:(NSString *)imageKey {
  NSParameterAssert([imageKey isKindOfClass:[NSString class]]);
  if (![imageKey isKindOfClass:[NSString class]]) return;
  [self willChangeValueForKey:@"imageKey"];
  _imageKey = imageKey;
  [self didChangeValueForKey:@"imageKey"];
  [self setMaskImageUsingKey:_imageKey inRenderMode:IonBackgroundRenderFilled];
}

#pragma mark Style Application

- (void)applyStyle:(IonStyle *)style {
  [super applyStyle:style];
  NSString *imageKey;

  // Size
  if (self.styleCanSetSize)
    self.frame =
        (CGRect){self.frame.origin,
                 [style.configuration sizeForKey:sIonIconView_IconSize]};

  // Image
  imageKey = [style.configuration stringForKey:sIonIconView_IconImage];
  if ([imageKey isKindOfClass:[NSString class]])
    [self setMaskImageUsingKey:imageKey inRenderMode:IonBackgroundRenderFilled];
  else if ([_image isKindOfClass:[UIImage class]])
    [self setMaskImage:_image renderMode:IonBackgroundRenderFilled];
  else if ([_imageKey isKindOfClass:[NSString class]])
    [self setMaskImageUsingKey:_imageKey
                  inRenderMode:IonBackgroundRenderFilled];
}

@end
