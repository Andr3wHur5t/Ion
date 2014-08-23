//
//  IonGuideLine.h
//  Ion
//
//  Created by Andrew Hurst on 8/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IonView;
@class IonGuideLine;
/**
 * The calculation block for the guide line
 */
typedef CGFloat(^IonGuildLineCalcBlock)( CGFloat target );

/**
 * The processing block.
 */
typedef CGFloat(^IonGuideLineProcessingBlock)( id data );

/**
 * The sections, and modes of the frame we can use.
 */
typedef enum : NSUInteger {
    IonGuideLineFrameMode_Vertical = 0,
    IonGuideLineFrameMode_Horizontal = 1
} IonGuideLineFrameMode;


/**
 * A value which will adjust according to a set of calculations based off of a target value.
 */
@interface IonGuideLine : NSObject
#pragma mark Constructors

/**
 * Constructs a guide line with the inputted blocks, and target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @param {IonGuideLineProcessingBlock} the block to use in processing the watched value on updates.
 * @param {IonGuildLineCalcBlock} the calculation block used to calculate the resulting position.
 * @returns {instancetype}
 */
- (instancetype) initWithTarget:(id) target
                        keyPath:(NSString*) keyPath
                processingBlock:(IonGuideLineProcessingBlock) processingBlock
                   andCalcBlock:(IonGuildLineCalcBlock) calcBlock;

/**
 * Constructs a guide line with the inputted block, and target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @param {IonGuildLineCalcBlock} the calculation block used to calculate the resulting position.
 * @returns {instancetype}
 */
- (instancetype) initWithTarget:(id) target
                        keyPath:(NSString*) keyPath
                   andCalcBlock:(IonGuildLineCalcBlock) calcBlock;

/**
 * Constructs a guide line with the inputted block, and target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @param {IonGuideLineProcessingBlock} the block to use in processing the watched value on updates.
 * @returns {instancetype}
 */
- (instancetype) initWithTarget:(id) target
                        keyPath:(NSString*) keyPath
                andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock;

/**
 * Constructs a guide line with the target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @returns {instancetype}
 */
- (instancetype) initWithTarget:(id) target
                        andKeyPath:(NSString*) keyPath;

/**
 * Constructs a guide line as a child of the current guide line with the specified calculation block.
 * @param {IonGuildLineCalcBlock} the calculation block used to calculate the resulting position.
 * @returns {instancetype}
 */
- (instancetype) guideAsChildUsingCalcBlock:(IonGuildLineCalcBlock) calcBlock;

/**
 * Constructs a guide line as a child of the current guide line.
 * @returns {instancetype}
 */
- (instancetype) guideAsChild;

/**
 * Constructs a guide line with the inputted blocks, and target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @param {IonGuideLineProcessingBlock} the block to use in processing the watched value on updates.
 * @param {IonGuildLineCalcBlock} the calculation block used to calculate the resulting position.
 * @returns {instancetype}
 */
+ (instancetype) guideWithTarget:(id) target
                         keyPath:(NSString*) keyPath
                 processingBlock:(IonGuideLineProcessingBlock) processingBlock
                    andCalcBlock:(IonGuildLineCalcBlock) calcBlock;

/**
 * Constructs a guide line with the inputted block, and target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @param {IonGuildLineCalcBlock} the calculation block used to calculate the resulting position.
 * @returns {instancetype}
 */
+ (instancetype) guideWithTarget:(id) target
                         keyPath:(NSString*) keyPath
                    andCalcBlock:(IonGuildLineCalcBlock) calcBlock;

/**
 * Constructs a guide line with the inputted block, and target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @param {IonGuideLineProcessingBlock} the block to use in processing the watched value on updates.
 * @returns {instancetype}
 */
+ (instancetype) guideWithTarget:(id) target
                         keyPath:(NSString*) keyPath
              andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock;

/**
 * Constructs a guide line with the target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @returns {instancetype}
 */
+ (instancetype) guideWithTarget:(id) target
                      andKeyPath:(NSString*) keyPath;

#pragma mark Default UIView Based Guides

/**
 * Constructs a guide line based off the inputted view frames' origin, using the mode to specify axis.
 * @param {UIView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewInternalOrigin:(UIView*) view usingMode:(IonGuideLineFrameMode) mode;

/**
 * Constructs a guide line based off the inputted view frames' size, using the mode to specify axis.
 * @param {UIView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewFrameSize:(UIView*) view usingMode:(IonGuideLineFrameMode) mode;

/**
 * Constructs a guide line based off the inputted view frames' size, using the mode to specify axis, and amount specifying how much.
 * @param {UIView*} the view to base the guide off of.
 * @param {CGFloat} the amount to use.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewFrameSize:(UIView*) view usingAmount:(CGFloat) amount andMode:(IonGuideLineFrameMode) mode;

/**
 * Constructs a guide line based off the inputted views' center, using the mode to specify axis.
 * @param {UIView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewCenter:(UIView*) view usingMode:(IonGuideLineFrameMode) mode;

/**
 * Constructs a guide line based off the inputted views' corner radius, using the mode to specify axis.
 * @param {UIView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewCornerRadius:(UIView*) view usingMode:(IonGuideLineFrameMode) mode;

/**
 * Constructs a guide line based off the inputted views' style margin, using the mode to specify axis.
 * @param {IonView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewStyleMargin:(IonView*) view usingMode:(IonGuideLineFrameMode) mode;

/**
 * Constructs a guide line based off the inputted views' corner radius, and style margin, using the mode to specify axis.
 * @param {IonView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewAutoMargin:(IonView*) view usingMode:(IonGuideLineFrameMode) mode;

#pragma mark Calculation

/**
 * The block which will calculate the resulting position.
 */
@property (assign, nonatomic) IonGuildLineCalcBlock calcBlock;

/**
 * The block which will be used for processing the raw data.
 */
@property (assign, nonatomic) IonGuideLineProcessingBlock processingBlock;

/**
 * The resulting position of the line.
 */
@property (assign, nonatomic) CGFloat position;

#pragma mark Change Subscription

/**
 * Configures a guideline to subscribe to changes in this guide line as a child.
 * @param {IonGuideLine*} the guide line to set.
 * @returns {void}
 */
- (void) configureGuideLineAsChild:(IonGuideLine*) line;

/**
 * Sets the target value to base our position off of.
 * @param {id} the targets' object.
 * @param {NSString*} the key to observe.
 * @returns {void}
 */
- (void) setTarget:(id) target usingKeyPath:(NSString*) keyPath;

#pragma mark Default Calculation Blocks

/**
 * The default calculation block.
 * @returns {IonGuildLineCalcBlock}
 */
+ (IonGuildLineCalcBlock) defaultCalculationBlock;

#pragma mark Processing Blocks

/**
 * The default processing block.
 * @returns {IonGuideLineProcessingBlock}
 */
+ (IonGuideLineProcessingBlock) defaultProcessingBlock;

/**
 * Rect size processing block.
 * @param {IonGuideLineFrameMode} the axis to extract
 * @returns {IonGuideLineProcessingBlock}
 */
+ (IonGuideLineProcessingBlock) rectSizeProcessingBlockUsingMode:(IonGuideLineFrameMode) mode;

/**
 * Size processing block.
 * @param {IonGuideLineFrameMode} the axis to extract
 * @returns {IonGuideLineProcessingBlock}
 */
+ (IonGuideLineProcessingBlock) sizeProcessingBlockUsingMode:(IonGuideLineFrameMode) mode;

/**
 * Point processing block.
 * @param {IonGuideLineFrameMode} the axis to extract
 * @returns {IonGuideLineProcessingBlock}
 */
+ (IonGuideLineProcessingBlock) pointProcessingBlockUsingMode:(IonGuideLineFrameMode) mode;

/**
 * Constant value processing block.
 * @param {CGFloat} the value to return
 * @returns {IonGuideLineProcessingBlock}
 */
+ (IonGuideLineProcessingBlock) constantProcessingBlockUsingValue:(CGFloat) val;

@end
