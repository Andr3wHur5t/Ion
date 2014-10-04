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
 * @param {UIView*} the view to base the guide off of.
 * @param {CGFloat} the amount to use.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewFrameSize:(UIView*) view usingAmount:(CGFloat) amount andMode:(IonGuideLineFrameMode) mode;

#pragma mark UIView Dependent
/**
 * Constructs a guide line based off the inputted views' corner radius, using the mode to specify axis.
 * @param {UIView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewCornerRadius:(UIView*) view usingMode:(IonGuideLineFrameMode) mode;

/**
 * Constructs a guide line based off the inputted views' style margin, using the mode to specify axis.
 * @param {UIView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewStyleMargin:(UIView*) view usingMode:(IonGuideLineFrameMode) mode;

/**
 * Constructs a guide line based off the inputted views' style padding, using the mode to specify axis.
 * @param {UIView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewStylePadding:(UIView*) view usingMode:(IonGuideLineFrameMode) mode;

/**
 * Constructs a guide line based off the inputted views' corner radius, and style margin, using the mode to specify axis.
 * @param {UIView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewAutoMargin:(UIView*) view usingMode:(IonGuideLineFrameMode) mode;

#pragma mark Frame Based Guides

/**
 * Constructs a guide line based off the inputted object frames' size, using the mode to specify axis, and amount specifying how much.
 * @param {id} the target object to base off of.
 * @param {NSString*} the key path of the rect to use.
 * @param {CGFloat} the amount to use.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideWithTargetRectSize:(id) target
                        usingRectKeyPath:(NSString*) keyPath
                                  amount:(CGFloat) amount
                                 andMode:(IonGuideLineFrameMode) mode;


/**
 * Constructs a guide line based off the inputted object frames' size combined with origin to get the external position, using the mode to specify axis, and amount specifying how much of the size to use.
 * @param {id} the target object to base off of.
 * @param {NSString*} the key path of the rect to use.
 * @param {CGFloat} the amount to use.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideWithTargetRectPosition:(id) target
                            usingRectKeyPath:(NSString*) keyPath
                                      amount:(CGFloat) amount
                                     andMode:(IonGuideLineFrameMode) mode;


/**
 * Constructs a guide line based off the inputted value.
 * @param {CGFloat} the value to return.
 * @returns {instancetype}
 */
+ (instancetype) guideWithStaticValue:(CGFloat) value;

/**
 * Gets the negative guide of that guide line.
 * @returns {instancetype}
 */
- (instancetype) negativeGuide;
@end


@interface NSNumber (IonGuideLine)

/**
 * Converts the current number into a static guide line.
 */
- (IonGuideLine *)toGuideLine;

@end
