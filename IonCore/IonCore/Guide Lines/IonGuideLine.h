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
 * @param values - a dictionary of named values representing all of the guidelines' target values.
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
    IonValueModType_Divide = 3,
    IonValueModType_Max = 4,
    IonValueModType_Min = 5
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
 * @param value - the value the guide will be set to.
 */
- (instancetype) initWithStaticValue:(CGFloat) value;

/**
 * Constructs a guide line with the inputted blocks, and target information.
 * @param target - the target object to get the watched value from.
 * @param keyPath - the key path of the value to watch on the target object.
 * @param processingBlock - the block to use in processing the watched value on updates.
 * @param calcBlock - the calculation block used to calculate the resulting position.
 */
- (instancetype) initWithTarget:(id) target
                        keyPath:(NSString*) keyPath
                processingBlock:(IonGuideLineProcessingBlock) processingBlock
                   andCalcBlock:(IonGuildLineCalcBlock) calcBlock;


/**
 * Constructs a guide line with the inputted block, and target information.
 * @param target - the target object to get the watched value from.
 * @param keyPath - the key path of the value to watch on the target object.
 * @param calcBlock - the calculation block used to calculate the resulting position.
 */
- (instancetype) initWithTarget:(id) target
                        keyPath:(NSString*) keyPath
                   andCalcBlock:(IonGuildLineCalcBlock) calcBlock;

/**
 * Constructs a guide line with the inputted block, and target information.
 * @param target - the target object to get the watched value from.
 * @param keyPath - the key path of the value to watch on the target object.
 * @param processingBlock - the block to use in processing the watched value on updates.
 */
- (instancetype) initWithTarget:(id) target
                        keyPath:(NSString*) keyPath
                andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock;

/**
 * Constructs a guide line with the target information.
 * @param target - the target object to get the watched value from.
 * @param keyPath - the key path of the value to watch on the target object.
 */
- (instancetype) initWithTarget:(id) target
                        andKeyPath:(NSString*) keyPath;

/**
 * Constructs a guide line with the target as the inputted guide.
 * @param guide - the target guide to set to the primary target.
 */
- (instancetype) initWithTargetGuide:(IonGuideLine *)guide;
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
 * @param target - the target object.
 * @param keyPath - the target key path.
 * @param name - the name associated with this set.
 */
- (void) addTarget:(id) target withKeyPath:(NSString *)keyPath andName:(NSString *)name;

/**
 * Adds a guide as a target variable with the inputted name.
 * @param guide - the target guide to add.
 * @param name - the name associated with this set.
 */
- (void) addTargetGuide:(IonGuideLine *)guide withName:(NSString *)name;

/**
 * Adds a target variable with the inputted name.
 * @param target - the target object.
 * @param keyPath - the target key path.
 * @param processingBlock - the processing block used to extract the value.
 * @param name - the string associated with this set.
 */
- (void) addTarget:(id) target
       withKeyPath:(NSString *)keyPath
   processingBlock:(IonGuideLineProcessingBlock) processingBlock
           andName:(NSString *)name;

/**
 * Removes the target variable with the inputted name.
 * @param name - the name of the pair to remove.
 * @warning You can't remove the primary target,
 */
- (void) removeTargetWithName:(NSString *)name;

#pragma mark Change Subscription
/**
 * Configures a guideline to subscribe to changes in this guide line as a child.
 * @param line - the guide line to set.
 */
- (void) configureGuideLineAsChild:(IonGuideLine *)line;

#pragma mark Primary Target Setters
/**
 * Sets the primary target value of the guide.
 * @param target - the target object.
 * @param keyPath - the key to observe.
 */
- (void) setTarget:(id) target usingKeyPath:(NSString *)keyPath;

/**
 * Sets the primary target value of the guide.
 * @param target - the target object.
 * @param keyPath - the key to observe.
 * @param processingBlock - the processing block used to extract the variable.
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
 * @param calcBlock - the calculation block used to calculate the resulting position.
 */
- (instancetype) guideAsChildUsingCalcBlock:(IonGuildLineCalcBlock) calcBlock;

/**
 * Constructs a guide line as a child of the current guide line.
 */
- (instancetype) guideAsChild;

/**
 * Constructs a guide line with the inputted blocks, and target information.
 * @param target the target object to get the watched value from.
 * @param keyPath - the key path of the value to watch on the target object.
 * @param processingBlock - the block to use in processing the watched value on updates.
 * @param calcBlock - the calculation block used to calculate the resulting position.
 */
+ (instancetype) guideWithTarget:(id) target
                         keyPath:(NSString *)keyPath
                 processingBlock:(IonGuideLineProcessingBlock) processingBlock
                    andCalcBlock:(IonGuildLineCalcBlock) calcBlock;

/**
 * Constructs a guide line with the inputted block, and target information.
 * @param target the target object to get the watched value from.
 * @param keyPath - the key path of the value to watch on the target object.
 * @param calcBlock - the calculation block used to calculate the resulting position.
 */
+ (instancetype) guideWithTarget:(id) target
                         keyPath:(NSString*) keyPath
                    andCalcBlock:(IonGuildLineCalcBlock) calcBlock;

/**
 * Constructs a guide line with the inputted block, and target information.
 * @param target the target object to get the watched value from.
 * @param keyPath - the key path of the value to watch on the target object.
 * @param processingBlock - the block to use in processing the watched value on updates.
 */
+ (instancetype) guideWithTarget:(id) target
                         keyPath:(NSString*) keyPath
              andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock;

/**
 * Constructs a guide line with the target information.
 * @param target the target object to get the watched value from.
 * @param keyPath - the key path of the value to watch on the target object.
 */
+ (instancetype) guideWithTarget:(id) target
                      andKeyPath:(NSString*) keyPath;

#pragma mark Local Observers
/**
 * Adds a local observer to be invoked when the position value changes.
 * @param target - the target to invoke the action on.
 * @param action - the action to invoke on the target.
 */
- (void) addLocalObserverTarget:(id) target andAction:(SEL) action;

/**
 * Removes the local observer matching the target and action specified.
 * @param target - the target to invoke the action on.
 * @param action - the action to invoke on the target.
 */
- (void) removeLocalObserverTarget:(id) target andAction:(SEL) action;

/**
 * Removes all local observers.
 */
- (void) removeAllLocalObservers;

#pragma mark Default Calculation Blocks
/**
 * Gets the value mod block for the specified mod type.
 * @param type - the mod type to get the value for.
 */
+ (IonValueModBlock) modBlockForType:(IonValueModType) type;

/**
 * Default calculation block.
 */
+ (IonGuildLineCalcBlock) defaultCalculationBlock;

/**
 * A calculation block which preforms the inputted block on all guides.
 * @param valueBlock - the block which gets called for each set of values.
 */
+ (IonGuildLineCalcBlock) compositeCalcBlockUsingValueBlock:(IonValueModBlock) valueBlock;

/**
 * Gets the calc block for the specified modification type.
 * @param modType - the modification type used to composite values.
 */
+ (IonGuildLineCalcBlock) calcBlockForModType:(IonValueModType) modType;

/**
 * Constructs an calc block which subtracts the two values. Value1 - Value2
 * @param value1 - the key of value 1
 * @param value2 - the key of value 2
 */
+ (IonGuildLineCalcBlock) calcBlockWithSubtracted:(NSString *)value1 by:(NSString *)value2;

@end
