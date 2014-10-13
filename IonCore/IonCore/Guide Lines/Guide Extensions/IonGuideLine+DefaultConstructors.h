//
//  IonGuideLine+DefaultConstructors.h
//  Ion
//
//  Created by Andrew Hurst on 8/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideLine.h"
#import "IonGuideLine+DependentGuides.h"

@interface IonGuideLine (DefaultConstructors)
#pragma mark Default UIView Based Guides

/**
 * Constructs a guide line based off the views frame size, using the mode to specify axis, and amount specifying
 * the percentage of the size to use.
 * @param view - the view to base the guide off of.
 * @param amount - the amount to use.
 * @param mode the mode specifying axis to use
 */
+ (instancetype) guideFromViewFrameSize:(UIView*) view usingAmount:(CGFloat) amount andMode:(IonGuideLineFrameMode) mode;

#pragma mark UIView Dependent
/**
 * Constructs a guide line based off the inputted views' corner radius, using the mode to specify axis.
 * @param view - the view to base the guide off of.
 * @param mode - the mode specifying axis to use
 */
+ (instancetype) guideFromViewCornerRadius:(UIView*) view usingMode:(IonGuideLineFrameMode) mode;

/**
 * Constructs a guide line based off the inputted views' style margin, using the mode to specify axis.
 * @param view - the view to base the guide off of.
 * @param mode - the mode specifying axis to use
 */
+ (instancetype) guideFromViewStyleMargin:(UIView*) view usingMode:(IonGuideLineFrameMode) mode;

/**
 * Constructs a guide line based off the inputted views' style padding, using the mode to specify axis.
 * @param view - the view to base the guide off of.
 * @param mode the mode specifying axis to use
 */
+ (instancetype) guideFromViewStylePadding:(UIView*) view usingMode:(IonGuideLineFrameMode) mode;

/**
 * Constructs a guide line based off the inputted views' corner radius, and style margin, using the mode to specify axis.
 * @param view - the view to base the guide off of.
 * @param mode - the mode specifying axis to use
 */
+ (instancetype) guideFromViewAutoMargin:(UIView*) view usingMode:(IonGuideLineFrameMode) mode;

#pragma mark Frame Based Guides

/**
 * Constructs a guide line based off the inputted object frames' size, using the mode to specify axis, and amount specifying how much.
 * @param target - the target object to base off of.
 * @param keyPath - the key path of the rect to use.
 * @param amount - the amount of the axis to use.
 * @param mode - the mode specifying axis to use
 */
+ (instancetype) guideWithTargetRectSize:(id) target
                        usingRectKeyPath:(NSString*) keyPath
                                  amount:(CGFloat) amount
                                 andMode:(IonGuideLineFrameMode) mode;


/**
 * Constructs a guide line based off the inputted object frames' size combined with origin to get the external position, using the mode to specify axis, and amount specifying how much of the size to use.
 * @param target - the target object to base off of.
 * @param keyPath - the key path of the rect to use.
 * @param amount - the amount of the axis to use.
 * @param mode - the mode specifying axis to use
 */
+ (instancetype) guideWithTargetRectPosition:(id) target
                            usingRectKeyPath:(NSString*) keyPath
                                      amount:(CGFloat) amount
                                     andMode:(IonGuideLineFrameMode) mode;

#pragma mark Size Based Guides
/**
 * Constructs a guide line based off the inputted objects size at the specified key path.
 * @param target - the target object to base off of.
 * @param keyPath - the key path of the size to use.
 * @param amount - the amount of the axis to use.
 * @param mode - the mode specifying axis to use
 */
+ (instancetype) guideFromSizeOnTarget:(id) target
                          usingKeyPath:(NSString *)keyPath
                                amount:(CGFloat) amount
                               andMode:(IonGuideLineFrameMode) mode;


/**
 * Constructs a guide line based off the inputted objects size at the specified key path.
 * @param target - the target object to base off of.
 * @param keyPath - the key path of the size to use.
 * @param mode - the mode specifying axis to use
 */
+ (instancetype) guideFromSizeOnTarget:(id) target
                          usingKeyPath:(NSString *)keyPath
                               andMode:(IonGuideLineFrameMode) mode;

#pragma mark Point Based Guides
/**
 * Constructs a guide line based off the inputted objects point at the specified key path.
 * @param target - the target object to base off of.
 * @param keyPath - the key path of the point to use.
 * @param amount - the amount of the axis to use.
 * @param mode - the mode specifying axis to use
 */
+ (instancetype) guideFromPointOnTarget:(id) target
                          usingKeyPath:(NSString *)keyPath
                                amount:(CGFloat) amount
                               andMode:(IonGuideLineFrameMode) mode;


/**
 * Constructs a guide line based off the inputted objects point at the specified key path.
 * @param target - the target object to base off of.
 * @param keyPath - the key path of the point to use.
 * @param mode - the mode specifying axis to use
 */
+ (instancetype) guideFromPointOnTarget:(id) target
                          usingKeyPath:(NSString *)keyPath
                               andMode:(IonGuideLineFrameMode) mode;
#pragma mark Special Guides

/**
 * Constructs a guide line based off the inputted value.
 * @param value - the value to return.
 */
+ (instancetype) guideWithStaticValue:(CGFloat) value;

/**
 * Gets the negative guide of that guide line.
 */
- (instancetype) negativeGuide;
@end


@interface NSNumber (IonGuideLine)

/**
 * Converts the current number into a static guide line.
 */
- (IonGuideLine *)toGuideLine;

@end
