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

@interface IonIcon ()

/*!
 @brief The ID of the current set image operation.
 */
@property(strong, nonatomic, readwrite) NSUUID *setID;
@property(assign, nonatomic, readwrite) BOOL hasSetImage;

@end

@implementation IonIcon

@synthesize image = _image;
@synthesize imageKey = _imageKey;
@synthesize alpha = _alpha;

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
  _alpha = 1.0f;
  self.styleCanSetSize = TRUE;
  self.hasSetImage = FALSE;
}

#pragma mark Image Set Overrides

- (void)setMaskImage:(UIImage *)image
          renderMode:(IonBackgroundRenderOptions)renderMode {
  [super setMaskImage:image
           renderMode:renderMode
           completion:[self imageSetCompletionForState]];
}

- (void)setMaskImageUsingKey:(NSString *)key
                inRenderMode:(IonBackgroundRenderOptions)renderMode {
  [super setMaskImageUsingKey:key
                 inRenderMode:renderMode
                   completion:[self imageSetCompletionForState]];
}

- (void (^)(NSError *e))imageSetCompletionForState {
  __block void (^completion)(void);
  __block NSUUID *currentSetId;

  if (!self.hasSetImage) {
    super.alpha = 0.0f;
    completion = ^{
      super.alpha = _alpha;
    };
  } else {
    completion = ^{};
  }

  currentSetId = [[NSUUID alloc] init];
  self.setID = currentSetId;
  return ^(NSError *e) {
    if ([e isKindOfClass:[NSError class]]) {
      NSLog(@"%s -- %@", __func__, e.localizedDescription);
    }
    // If we are the most recent set id then set
    if ([currentSetId.UUIDString isEqualToString:self.setID.UUIDString])
      completion();
  };
}

#pragma mark UIView Override

- (void)setAlpha:(CGFloat)alpha {
  _alpha = alpha;
  [super setAlpha:alpha];
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
  if ([_imageKey isEqualToString:imageKey]) return;  // Dedupe
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
