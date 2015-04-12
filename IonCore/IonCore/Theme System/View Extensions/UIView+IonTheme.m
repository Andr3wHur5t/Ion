//
//  UIView+IonTheme.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonTheme.h"
#import <objc/runtime.h>
#import <IonData/IonData.h>
#import "IonStyle.h"

/** Variable Keys
 */
static void *sThemeConfigurationKey = "IonThemeConfiguration";
static NSString *sIonStyleMarginKey = @"StyleMargin";
static NSString *sIonStylePaddingKey = @"StylePadding";

@implementation UIView (IonTheme)

#pragma mark Theme Configuration Object

- (void)setThemeConfiguration:(IonThemeConfiguration *)themeConfiguration {
  // Set the change callback
  __block typeof(self) weakSelf = self;
  [themeConfiguration setChangeCallback:^(NSError *err) {
      [weakSelf
          setParentStyle:weakSelf.themeConfiguration.currentStyle.parentStyle];
  }];

  // Set it
  objc_setAssociatedObject(self, sThemeConfigurationKey, themeConfiguration,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (IonThemeConfiguration *)themeConfiguration {
  IonThemeConfiguration *config =
      objc_getAssociatedObject(self, sThemeConfigurationKey);
  if (!config) {
    config = [[IonThemeConfiguration alloc] init];
    self.themeConfiguration = config;
  }
  return config;
}

#pragma mark Application

- (void)setIonTheme:(IonTheme *)themeObject {
  if (!themeObject || ![themeObject isKindOfClass:[IonTheme class]]) return;

  // Set the root style as the parent style
  [self setParentStyle:[themeObject rootStyle]];
}

- (void)setParentStyle:(IonStyle *)style {
  if (!style || ![style isKindOfClass:[IonStyle class]]) return;
  [self setStyle:[style styleForView:self]];
}

- (void)setStyle:(IonStyle *)style {
  if (!style || ![style isKindOfClass:[IonStyle class]]) return;
  // Update ourself
  self.themeConfiguration.currentStyle = style;

  // Apply to self
  if (self.themeConfiguration.themeShouldBeAppliedToSelf)
    [style applyToView:self];

  // Set Children styles
  for (UIView *child in self.subviews) [child setParentStyle:style];
}

- (void)addSubviewUsingStyle:(UIView *)view {
  [self addSubview:view];
  [view setParentStyle:self.style];
}

- (IonStyle *)style {
  return self.themeConfiguration.currentStyle;
}

#pragma mark Theme Element

+ (BOOL)automaticallyNotifiesObserversOfThemeElement {
  return FALSE;
}

- (void)setThemeElement:(NSString *)themeElement {
  [self willChangeValueForKey:@"themeElement"];
  self.themeConfiguration.themeElement = themeElement;
  [self didChangeValueForKey:@"themeElement"];

  // Update self
  if (self.superview) [self setParentStyle:self.superview.style];
}

- (NSString *)themeElement {
  return self.themeConfiguration.themeElement;
}

#pragma mark Theme Element

+ (BOOL)automaticallyNotifiesObserversOfThemeClass {
  return FALSE;
}

- (void)setThemeClass:(NSString *)themeClass {
  [self willChangeValueForKey:@"themeClass"];
  self.themeConfiguration.themeClass = themeClass;
  [self didChangeValueForKey:@"themeClass"];

  // Update self
  if (self.superview) [self setParentStyle:self.superview.style];
}

- (NSString *)themeClass {
  return self.themeConfiguration.themeClass;
}

#pragma mark Theme Element

+ (BOOL)automaticallyNotifiesObserversOfThemeID {
  return FALSE;
}

- (void)setThemeID:(NSString *)themeID {
  [self willChangeValueForKey:@"themeId"];
  self.themeConfiguration.themeID = themeID;
  [self didChangeValueForKey:@"themeId"];

  // Update self
  if (self.superview) [self setParentStyle:self.superview.style];
}

- (NSString *)themeID {
  return self.themeConfiguration.themeID;
}

#pragma mark Data Retrevial

- (void)applyStyle:(IonStyle *)style {
  NSNumber *animationDuration;
  CGSize styleMargin, stylePadding;
  NSParameterAssert([style isKindOfClass:[IonStyle class]]);
  if (![style isKindOfClass:[IonStyle class]]) return;

  // Get the style margin
  styleMargin = [style.configuration sizeForKey:sIonThemeView_StyleMargin];
  if (CGSizeEqualToSize(styleMargin, CGSizeUndefined)) styleMargin = CGSizeZero;
  self.styleMargin = styleMargin;

  // Get the style Padding
  stylePadding = [style.configuration sizeForKey:sIonThemeView_StylePadding];
  if (CGSizeEqualToSize(stylePadding, CGSizeUndefined))
    stylePadding = CGSizeZero;
  self.stylePadding = stylePadding;

  // Get Animation Durration
  animationDuration =
      [style.configuration numberForKey:sIonThemeView_AnimationDuration];
  if (!animationDuration) animationDuration = @0.3;
  self.animationDuration = [animationDuration floatValue];
}

#pragma mark Can Set Background
- (void)setStyleCanSetBackground:(BOOL)styleCanSetBackground {
  [self.categoryVariables
      setObject:[NSNumber numberWithBool:styleCanSetBackground]
         forKey:@"canSetBackground"];
}

- (BOOL)styleCanSetBackground {
  return [self.categoryVariables boolForKey:@"canSetBackground"
                               defaultValue:FALSE];
}

#pragma mark Style Margin

+ (BOOL)automaticallyNotifiesObserversOfStyleMargin {
  return FALSE;
}

- (void)setStyleMargin:(CGSize)styleMargin {
  [self willChangeValueForKey:@"styleMargin"];
  [self.categoryVariables setObject:[NSValue valueWithCGSize:styleMargin]
                             forKey:sIonStyleMarginKey];
  [self didChangeValueForKey:@"styleMargin"];
}

- (CGSize)styleMargin {
  return [(NSValue *)
          [self.categoryVariables objectForKey:sIonStyleMarginKey] CGSizeValue];
}

#pragma mark Style Padding

+ (BOOL)automaticallyNotifiesObserversOfStylePadding {
  return FALSE;
}

- (void)setStylePadding:(CGSize)stylePadding {
  [self willChangeValueForKey:@"stylePadding"];
  [self.categoryVariables setObject:[NSValue valueWithCGSize:stylePadding]
                             forKey:sIonStylePaddingKey];
  [self didChangeValueForKey:@"stylePadding"];
}

- (CGSize)stylePadding {
  return [(NSValue *)[self.categoryVariables
      objectForKey:sIonStylePaddingKey] CGSizeValue];
}

#pragma mark Auto Margin

+ (NSSet *)keyPathsForValuesAffectingAutoMargin {
  return [NSSet setWithObjects:@"stylePadding", @"layer.cornerRadius", nil];
}

- (CGSize)autoMargin {
  CGSize autoMargin;
  autoMargin.width = MAX(self.stylePadding.width, self.layer.cornerRadius);
  autoMargin.height = MAX(self.stylePadding.height, self.layer.cornerRadius);
  return autoMargin;
}

#pragma mark Animation Duration

+ (BOOL)automaticallyNotifiesObserversOfAnimationDuration {
  return FALSE;
}

- (void)setAnimationDuration:(CGFloat)animationDuration {
  [self willChangeValueForKey:@"animationDuration"];
  [self.categoryVariables
      setObject:[NSNumber numberWithDouble:animationDuration]
         forKey:@"animationDuration"];
  [self didChangeValueForKey:@"animationDuration"];
}

- (CGFloat)animationDuration {
  return
      [[self.categoryVariables numberForKey:@"animationDuration"] floatValue];
}

#pragma mark Utilities

- (NSString *)description {
  return [NSString
      stringWithFormat:
          @"{Class:\"%@\",ID:\"%@\",Element:\"%@\",\nframe:%@}, %@",
          self.themeConfiguration.themeClass, self.themeConfiguration.themeID,
          self.themeConfiguration.themeElement, NSStringFromCGRect(self.frame),
          [super description]];
}

@end
