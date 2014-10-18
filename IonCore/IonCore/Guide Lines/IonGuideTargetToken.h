//
//  IonGuideTargetToken.h
//  Ion
//
//  Created by Andrew Hurst on 9/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <IonData/IonData.h>


/**
 * The sections, and modes of the frame we can use.
 */
typedef enum : NSUInteger {
    IonGuideLineFrameMode_Vertical = 0,
    IonGuideLineFrameMode_Horizontal = 1
} IonGuideLineFrameMode;

/**
 * The processing block.
 */
typedef CGFloat(^IonGuideLineProcessingBlock)( id data );

@interface IonGuideTargetToken : NSObject
#pragma mark Constructors
/**
 * Constructs a token with the inputted key path, and observed object.
 * @param object the observed object.
 * @param keyPath the key path to observe.
 * @param processingBlock the processing block used to process the value.  
 */
- (instancetype) initWithObservedObject:(id) object
                                keyPath:(NSString *)keyPath
                     andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock;

/**
 * Constructs a token with the inputted key path, and observed object.
 * @param object the observed object.
 * @param keyPath the key path to observe.  
 */
- (instancetype) initWithObservedObject:(id) object andKeyPath:(NSString *)keyPath;


/**
 * Constructs a token with the inputted key path, and observed object.
 * @param object the observed object.
 * @param keyPath the key path to observe.
 * @param processingBlock the processing block used to process the value.  
 */
+ (instancetype) tokenWithObservedObject:(id) object
                                keyPath:(NSString *)keyPath
                     andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock;

/**
 * Constructs a token with the inputted key path, and observed object.
 * @param object the observed object.
 * @param keyPath the key path to observe.  
 */
+ (instancetype) tokenWithObservedObject:(id) object andKeyPath:(NSString *)keyPath;

#pragma mark Params
/**
 * The observer key path.
 */
@property (weak, nonatomic, readonly) NSString *keyPath;

/**
 * The observed object.
 */
@property (weak, nonatomic, readonly) id observedObject;

/**
 * The current value of the target at the specified key path.
 */
@property (weak, nonatomic, readonly) id rawValue;

/**
 * The current processed value of the target at the specified key path.
 */
@property (assign, nonatomic, readonly) CGFloat processedValue;

/**
 * The block used to process the raw value.
 */
@property (strong, nonatomic, readonly) IonGuideLineProcessingBlock processingBlock;

#pragma mark Observer
/**
 * The observer helper.
 */
@property (strong, nonatomic, readonly) FOKeyValueObserver *observer;

/**
 * Configures the observer to invokes the target with the selector.
 * @param target the observers target.
 * @param selector the observers target selector.
 */
- (void) configureObserverWithTarget:(id) target andSelector:(SEL) selector;

#pragma mark Processing Blocks
/**
 * Default processing block.
 */
+ (IonGuideLineProcessingBlock) defaultProcessingBlock;

/**
 * Rect size processing block.
 * @param mode the axis to extract
 */
+ (IonGuideLineProcessingBlock) rectSizeProcessingBlockUsingMode:(IonGuideLineFrameMode) mode;

/**
 * Size processing block.
 * @param mode - the axis to extract
 * @param amount - the ammount of the axis to extract.
 */
+ (IonGuideLineProcessingBlock) sizeProcessingBlockUsingMode:(IonGuideLineFrameMode) mode
                                                   andAmount:(CGFloat) amount;

/**
 * Size processing block.
 * @param mode  - the axis to extract
 */
+ (IonGuideLineProcessingBlock) sizeProcessingBlockUsingMode:(IonGuideLineFrameMode) mode;

/**
 * Point processing block.
 * @param mode - the axis to extract
 * @param amount - the ammount of the axis to extract.
 */
+ (IonGuideLineProcessingBlock) pointProcessingBlockUsingMode:(IonGuideLineFrameMode) mode
                                                    andAmount:(CGFloat) amount;
/**
 * Point processing block.
 * @param mode - the axis to extract
 */
+ (IonGuideLineProcessingBlock) pointProcessingBlockUsingMode:(IonGuideLineFrameMode) mode;

/**
 * External position processing block.
 * @param mode - the axis to extract
 */
+ (IonGuideLineProcessingBlock) externalPositioningProcessingBlockUsingMode:(IonGuideLineFrameMode) mode;

/**
 * External position processing block.
 * @param mode - the axis to extract
 * @param amount - the amount of the size to use
 */
+ (IonGuideLineProcessingBlock) externalPositioningProcessingBlockUsingMode:(IonGuideLineFrameMode) mode
                                                                  andAmount:(CGFloat) amount;

/**
 * Constant value processing block.
 * @param val - the value to return
 */
+ (IonGuideLineProcessingBlock) constantProcessingBlockUsingValue:(CGFloat) val;

@end
