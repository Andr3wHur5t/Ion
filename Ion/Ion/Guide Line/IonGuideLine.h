//
//  IonGuideLine.h
//  Ion
//
//  Created by Andrew Hurst on 8/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonGuideTargetToken.h"

@class IonView;
@class IonGuideLine;

/**
 * The calculation block for the guide line.
 * @param {NSDictionary*} a dictionary of named values representing all of the guidelines' target values.
 * @reutns {CGFloat}
 */
typedef CGFloat(^IonGuildLineCalcBlock)( NSDictionary *values );


typedef CGFloat(^IonValueModBlock)( CGFloat a, CGFloat b );

/**
 * Modification Types that are supported.
 */
typedef enum : NSUInteger {
    IonValueModType_Add = 0,
    IonValueModType_Subtract = 1,
    IonValueModType_Multiply = 2,
    IonValueModType_Divide = 3
} IonValueModType;

/**
 * Debug Depth Types
 */
typedef enum : NSUInteger {
    IonGuideDebugDepth_None = 0,
    IonGuideDebugDepth_Shallow = 1,
    IonGuideDebugDepth_Deep = 2
} IonGuideDebugDepth;

static NSString *sIonGuideLine_PrimaryTargetKey = @"primary";

/**
 * A value which will adjust according to a set of calculations based off of a target value.
 */
@interface IonGuideLine : NSObject
#pragma mark Constructors

/**
 * Constructs a guide line based off the inputted value.
 * @param {CGFloat} the value to return.
 * @returns {instancetype}
 */
- (instancetype) initWithStaticValue:(CGFloat) value;

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

#pragma mark Calculation
/**
 * The block which will calculate the resulting position.
 */
@property (assign, nonatomic, readwrite) IonGuildLineCalcBlock calcBlock;

/**
 * The resulting position of the line.
 */
@property (assign, nonatomic, readwrite) CGFloat position;

#pragma mark Target Management
/**
 * Adds a target variable with the inputted name.
 * @param {id} the target object.
 * @param {NSString*} the target key path.
 * @param {NSString*} the string associated with this set.
 */
- (void) addTarget:(id) target withKeyPath:(NSString *)keyPath andName:(NSString *)name;

/**
 * Adds a target variable with the inputted name.
 * @param {id} the target object.
 * @param {NSString*} the target key path.
 * @param {IonGuideLineProcessingBlock} the processing block used to extract the value.
 * @param {NSString*} the string associated with this set.
 */
- (void) addTarget:(id) target
       withKeyPath:(NSString *)keyPath
   processingBlock:(IonGuideLineProcessingBlock) processingBlock
           andName:(NSString *)name;

/**
 * Removes the target variable with the inputted name.
 * @param {NSString*} the name of the pair to remove.
 * @warning You can't remove the primary target,
 */
- (void) removeTargetWithName:(NSString *)name;

#pragma mark Change Subscription
/**
 * Configures a guideline to subscribe to changes in this guide line as a child.
 * @param {IonGuideLine*} the guide line to set.
 */
- (void) configureGuideLineAsChild:(IonGuideLine *)line;

#pragma mark Primary Target Setters
/**
 * Sets the primary target value of the guide.
 * @param {id} the target object.
 * @param {NSString*} the key to observe.
 */
- (void) setTarget:(id) target usingKeyPath:(NSString *)keyPath;

/**
 * Sets the primary target value of the guide.
 * @param {id} the target object.
 * @param {NSString*} the key to observe.
 * @param {IonGuideLineProcessingBlock} the processing block used to extract the variable.
 */
- (void) setTarget:(id) target
      usingKeyPath:(NSString *)keyPath
andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock;

#pragma mark Debugging Tools
/**
 * Sets the block to be called on changes.
 * @warning For debugging only.
 */
- (void) setDebugBlock:(void(^)( )) debugBlock;

/**
 * The depth of debugging messages for this guide.
 */
@property (assign, nonatomic, readwrite) IonGuideDebugDepth debuggingDepth;

/**
 * The optional debug name of the guide.
 */
@property (strong, nonatomic, readwrite) NSString *debugName;

#pragma mark Utility Constructors
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

#pragma mark Local Observers
/**
 * Adds a local observer to be invoked when the position value changes.
 * @param {id} the target to invoke the action on.
 * @param {SEL} the action to invoke on the target.
 */
- (void) addLocalObserverTarget:(id) target andAction:(SEL) action;

/**
 * Removes the local observer matching the target and action specified.
 * @param {id} the target to invoke the action on.
 * @param {SEL} the action to invoke on the target.
 */
- (void) removeLocalObserverTarget:(id) target andAction:(SEL) action;

/**
 * Removes all local observers.
 */
- (void) removeAllLocalObservers;

#pragma mark Default Calculation Blocks
/**
 * Gets the value mod block for the specified mod type.
 * @param {IonValueModType} the mod type to get the value for.
 * @returns {IonValueModBlock}
 */
+ (IonValueModBlock) modBlockForType:(IonValueModType) type;

/**
 * Default calculation block.
 * @returns {IonGuildLineCalcBlock}
 */
+ (IonGuildLineCalcBlock) defaultCalculationBlock;

/**
 * A calculation block which preforms the inputted block on all guides.
 * @param {CGFloat(^)( CGFloat a, CGFloat b)} the block which gets called for each set of values.
 * @returns {IonGuildLineCalcBlock}
 */
+ (IonGuildLineCalcBlock) compositeCalcBlockUsingValueBlock:(IonValueModBlock) valueBlock;

/**
 * Gets the calc block for the specified modification type.
 * @param {IonValueModType} the modification type used to composite values.
 * @returns {IonGuildLineCalcBlock}
 */
+ (IonGuildLineCalcBlock) calcBlockForModType:(IonValueModType) modType;

/**
 * Constructs an calc block which subtracts the two values. Value1 - Value2
 * @param {NSString*} the key of value 1
 * @param {NSString*} the key of value 2
 * @returns {IonGuildLineCalcBlock}
 */
+ (IonGuildLineCalcBlock) calcBlockWithSubtracted:(NSString *)value1 by:(NSString *)value2;

@end
