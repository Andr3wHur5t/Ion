//
//  IonGuideLine.m
//  Ion
//
//  Created by Andrew Hurst on 8/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideLine.h"
#import "IonGuideTargetToken.h"
#import <IonData/IonData.h>

@interface IonGuideLine () {
    // Debug Block
    void(^_debugBlock) ( );
    
    // Calc Block, Seems like we can't use an auto synthesized value.
    // You will keep lousing the reference to the block if you do.
    IonGuildLineCalcBlock _calcBlock;
}

/**
 * The dependent variables
 */
@property (strong, nonatomic, readonly) NSMutableDictionary *targets;

/**
 * Local observers
 */
@property (strong, nonatomic, readonly) FOTargetActionList *localObservers;
@end

@implementation IonGuideLine

@synthesize targets = _targets;
@synthesize localObservers = _localObservers;

#pragma mark Constructors

- (instancetype) initWithStaticValue:(CGFloat) value {
    self = [super init];
    if ( self ) {
        self.debuggingDepth = IonGuideDebugDepth_None;
        self.position = value;
    }
    return self;
}

- (instancetype) init {
    return [self initWithStaticValue: 0.0f];
}

- (instancetype) initWithTargetToken:(IonGuideTargetToken *)targetToken
                        andCalcBlock:(IonGuildLineCalcBlock) calcBlock {
    NSParameterAssert( targetToken && [targetToken isKindOfClass: [IonGuideTargetToken class]] );
    if ( !targetToken || ![targetToken isKindOfClass: [IonGuideTargetToken class]] )
        return NULL;
    self = [self init];
    if ( self ) {
        _calcBlock = calcBlock ? calcBlock : [[self class] defaultCalculationBlock];
        [self setPrimaryTargetToken: targetToken];
    }
    return self;
}

- (instancetype) initWithTarget:(id) target
                        keyPath:(NSString*) keyPath
                processingBlock:(IonGuideLineProcessingBlock) processingBlock
                   andCalcBlock:(IonGuildLineCalcBlock) calcBlock {
    NSParameterAssert( target );
    NSParameterAssert( keyPath && [keyPath isKindOfClass: [NSString class]] );
    if ( !target || !keyPath || ![keyPath isKindOfClass: [NSString class]] )
        return NULL;
    return [self initWithTargetToken: [IonGuideTargetToken tokenWithObservedObject: target
                                                                           keyPath: keyPath
                                                                andProcessingBlock: processingBlock]
                        andCalcBlock: calcBlock];
}

- (instancetype) initWithTarget:(id) target
                        keyPath:(NSString*) keyPath
                   andCalcBlock:(IonGuildLineCalcBlock) calcBlock {
    return [self initWithTarget: target
                        keyPath: keyPath
                processingBlock: NULL
                   andCalcBlock: calcBlock];
}

- (instancetype) initWithTarget:(id) target
                        keyPath:(NSString*) keyPath
             andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock {
    return [self initWithTarget: target
                        keyPath: keyPath
                processingBlock: processingBlock
                   andCalcBlock: NULL];
}


- (instancetype) initWithTarget:(id) target
                     andKeyPath:(NSString*) keyPath {
    return [self initWithTarget: target
                        keyPath: keyPath
                processingBlock: NULL
                   andCalcBlock: NULL];
}

- (instancetype) initWithTargetGuide:(IonGuideLine *)guide {
    return [self initWithTarget: guide
                        keyPath: @"position"
                processingBlock: NULL
                   andCalcBlock: NULL];
}


#pragma mark Subscription Change
/**
 * Configures a guideline to subscribe to changes in this guide line as a child.
 * @param {IonGuideLine*} the guide line to set.
 
 */
- (void) configureGuideLineAsChild:(IonGuideLine*) line {
    NSParameterAssert( line && [line isKindOfClass: [IonGuideLine class]] );
    if ( !line || ![line isKindOfClass:[IonGuideLine class]] )
        return;
    
    [line setTarget: self usingKeyPath: @"position"];
}

#pragma mark Primary Target Setters
/**
 * Sets the primary target token of the guide.
 * @param {IonGuideTargetToken*} the primary target token.
 */
- (void) setPrimaryTargetToken:(IonGuideTargetToken *)targetToken {
    NSParameterAssert( targetToken && [targetToken isKindOfClass: [IonGuideTargetToken class]] );
    if ( !targetToken || ![targetToken isKindOfClass: [IonGuideTargetToken class]] )
        return;
    [self addTargetToken: targetToken withName: sIonGuideLine_PrimaryTargetKey];
}

/**
 * Sets the primary target value of the guide.
 * @param {id} the target object.
 * @param {NSString*} the key to observe.
 */
- (void) setTarget:(id) target usingKeyPath:(NSString *)keyPath {
    [self setTarget: target usingKeyPath: keyPath andProcessingBlock: NULL];
}

/**
 * Sets the primary target value of the guide.
 * @param {id} the target object.
 * @param {NSString*} the key to observe.
 * @param {IonGuideLineProcessingBlock} the processing block used to extract the variable.
 */
- (void) setTarget:(id) target
      usingKeyPath:(NSString *)keyPath
andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock {
    NSParameterAssert( target );
    NSParameterAssert( keyPath && [keyPath isKindOfClass: [NSString class]] );
    if ( !target || !keyPath || ![keyPath isKindOfClass:[NSString class]] )
        return;
    [self setPrimaryTargetToken: [IonGuideTargetToken tokenWithObservedObject: target
                                                                      keyPath: keyPath
                                                           andProcessingBlock: processingBlock]];
}

#pragma mark Calculation Block
/**
 * Gets the calculation block, if it doesn't exist replace it with the default one.
 * @returns {IonGuildLineCalcBlock} the calculation block, or default calculation block if it has not been set
 */
- (IonGuildLineCalcBlock) calcBlock {
    if ( !_calcBlock )
        _calcBlock = [IonGuideLine defaultCalculationBlock];
    return _calcBlock;
}

/**
 * Setter for the calculation block.
 * @param {}
 */
- (void) setCalcBlock:(IonGuildLineCalcBlock) calcBlock {
    // Note: we can't use an auto synthesized value... look at the notes in the ivar definition.
    _calcBlock = calcBlock;
}

#pragma mark Targets
/**
 * Gets, or creates the dependent variables list.
 * @returns {NSMutableDictionary*}
 */
- (NSMutableDictionary *)targets {
    if ( !_targets )
        _targets = [[NSMutableDictionary alloc] init];
    return _targets;
}

#pragma mark Target Management
/**
 * Adds a target variable with the inputted name.
 * @param {IonGuideTargetToken*} the target token to add.
 * @param {NSString*} the string associated with this set.
 */
- (void) addTargetToken:(IonGuideTargetToken *)targetToken withName:(NSString *)name {
    NSParameterAssert( name && [name isKindOfClass: [NSString class]] );
    NSParameterAssert( targetToken && [targetToken isKindOfClass: [IonGuideTargetToken class]] );
    if ( !name || ![name isKindOfClass:[NSString class]] ||
         !targetToken || ![targetToken isKindOfClass: [IonGuideTargetToken class]] )
        return;
    
    // Configure it to call the guide when it observes a change
    [targetToken configureObserverWithTarget: self andSelector: @selector(targetDidChange:)];
    
    // Add the token
    [self.targets setObject: targetToken forKey: name];
    
    // Force recalculate
    [self recalculatePosition];
}

- (void) addTarget:(id) target
       withKeyPath:(NSString *)keyPath
   processingBlock:(IonGuideLineProcessingBlock) processingBlock
           andName:(NSString *)name {
    [self addTargetToken: [IonGuideTargetToken tokenWithObservedObject: target
                                                               keyPath: keyPath
                                                    andProcessingBlock: processingBlock]
                withName: name];
}

- (void) addTarget:(id) target withKeyPath:(NSString *)keyPath andName:(NSString *)name {
    [self addTarget: target withKeyPath: keyPath processingBlock: NULL andName: name];
}

- (void) addTargetGuide:(IonGuideLine *)guide withName:(NSString *)name {
    [self addTarget: guide withKeyPath: @"position" andName: name];
}

- (void) internallyRemoveTargetWithName:(NSString *)name {
    NSParameterAssert( name && [name isKindOfClass: [NSString class]] );
    if ( !name || ![name isKindOfClass:[NSString class]] )
        return;
    [self.targets removeObjectForKey: name];
}

- (void) removeTargetWithName:(NSString *)name {
    NSParameterAssert( name && [name isKindOfClass: [NSString class]] );
    if ( !name || ![name isKindOfClass: [NSString class]] )
        return;
    
    // Check if name is primary
    if ( [name isEqualToString: sIonGuideLine_PrimaryTargetKey] ) {
        NSAssert( true , @"Name can not be %@!", name );
        return;
    }
    [self internallyRemoveTargetWithName: name];
}

#pragma mark Update Calculations
/**
 * Gets called when on of our targets change.
 * @param {NSDictionary*} the dictionary representing the change.
 */
- (void) targetDidChange:(NSDictionary *)change {
    NSParameterAssert( change && [change isKindOfClass:[NSDictionary class]] );
    if ( !change || ![change isKindOfClass:[NSDictionary class]] )
        return;
    
    // Did the value change to something new?
    if ( ![[change objectForKey: NSKeyValueChangeNewKey] isEqual: [change objectForKey: NSKeyValueChangeOldKey]] )
        [self recalculatePosition];// The value changed update our position
    
}

/**
 * Constructs a dictionary representing all current targets values with their associated name.
 * @returns {NSDictionary*}
 */
- (NSDictionary *)currentTargetValues {
    NSMutableDictionary *currentValues;
    currentValues = [[NSMutableDictionary alloc] init];
    [self.targets enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        [currentValues setObject: [NSNumber numberWithFloat: (float)((IonGuideTargetToken *)obj).processedValue]
                          forKey: key];
        if ( self.debuggingDepth == IonGuideDebugDepth_Deep )
            NSLog( @"%@ is %@", key, obj);
    }];
    
    if ( self.debuggingDepth == IonGuideDebugDepth_Deep )
        NSLog( @"%@ - %@", self.debugName, currentValues );
    return currentValues;
}

/**
 * Recalculates our position based off our targets.
 */
- (void) recalculatePosition {
    // Gets a dictionary representing all target values, then passes that into our calculation block which
    // returns a float. That value is then passed to update position with performs the update if necessary.
    [self updatePosition: self.calcBlock( [self currentTargetValues] ) ];
}

/**
 * Updates the position to match the inputted position.
 * @param {CGFloat} the new position.
 */
// TODO: Change to set position
- (void) updatePosition:(CGFloat) newPosition {
    // Only update if the net position actually changed.
    if ( self.position == newPosition )
        return;
    
    //update position.
    self.position = newPosition;
    if ( self.debuggingDepth != IonGuideDebugDepth_None )
        NSLog( @"%@ - updated position to %f", self.debugName, self.position);
    
    // Inform locally maintained observers of change
    [self.localObservers invokeActionSetsInGroup: @"observers"];
    
    // Call our debug block if we have one.
    if ( _debugBlock )
        _debugBlock( );
}

#pragma mark Local Observers
/**
 * Gets, or constructs the local targets dictionary.
 * @returns {FOTargetActionList*}
 */
- (FOTargetActionList *)localObservers {
    if ( !_localObservers )
        _localObservers = [[FOTargetActionList alloc] init];
    return _localObservers;
}

/**
 * Adds a local observer to be invoked when the position value changes.
 * @param {id} the target to invoke the action on.
 * @param {SEL} the action to invoke on the target.
 */
- (void) addLocalObserverTarget:(id) target andAction:(SEL) action {
    [self.localObservers addTarget: target andAction: action toGroup: @"observers"];
}

/**
 * Removes the local observer matching the target and action specified.
 * @param {id} the target to invoke the action on.
 * @param {SEL} the action to invoke on the target.
 */
- (void) removeLocalObserverTarget:(id) target andAction:(SEL) action {
    [self.localObservers removeTarget: target andAction: action fromGroup: @"observers"];
}

/**
 * Removes all local observers.
 */
- (void) removeAllLocalObservers {
    [self.localObservers removeGroup: @"observers"];
}

#pragma mark Debugging
/**
 * Debug Description
 */
- (NSString*) description {
    return [NSString stringWithFormat:@"%.2f", _position];
}

/**
 * Sets the block to be called on changes.
 * @warning For debugging only.
 */
- (void) setDebugBlock:(void(^)( )) debugBlock {
    _debugBlock = debugBlock;
}

#pragma mark Child Guide Construction
/**
 * Constructs a guide line as a child of the current guide line with the specified calculation block.
 * @param {IonGuildLineCalcBlock} the calculation block used to calculate the resulting position.
 * @returns {instancetype}
 */
- (instancetype) guideAsChildUsingCalcBlock:(IonGuildLineCalcBlock) calcBlock {
    return [[self class] guideWithTarget: self keyPath: @"position" andCalcBlock: calcBlock];
}

/**
 * Constructs a guide line as a child of the current guide line.
 * @returns {instancetype}
 */
- (instancetype) guideAsChild {
    return [self guideAsChildUsingCalcBlock: NULL];
}

#pragma mark Utility constructors
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
                    andCalcBlock:(IonGuildLineCalcBlock) calcBlock {
    return [[self alloc] initWithTarget: target
                                keyPath: keyPath
                        processingBlock: processingBlock
                           andCalcBlock: calcBlock];
}

/**
 * Constructs a guide line with the inputted block, and target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @param {IonGuildLineCalcBlock} the calculation block used to calculate the resulting position.
 * @returns {instancetype}
 */
+ (instancetype) guideWithTarget:(id) target
                         keyPath:(NSString*) keyPath
                    andCalcBlock:(IonGuildLineCalcBlock) calcBlock {
    return [[self alloc] initWithTarget: target
                                keyPath: keyPath
                        processingBlock: NULL
                           andCalcBlock: calcBlock];
}

/**
 * Constructs a guide line with the inputted block, and target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @param {IonGuideLineProcessingBlock} the block to use in processing the watched value on updates.
 * @returns {instancetype}
 */
+ (instancetype) guideWithTarget:(id) target
                         keyPath:(NSString*) keyPath
              andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock {
    return [[self alloc] initWithTarget: target
                                keyPath: keyPath
                        processingBlock: processingBlock
                           andCalcBlock: NULL];
}

/**
 * Constructs a guide line with the target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @returns {instancetype}
 */
+ (instancetype) guideWithTarget:(id) target
                      andKeyPath:(NSString*) keyPath {
    return [[self alloc] initWithTarget: target
                                keyPath: keyPath
                        processingBlock: NULL
                           andCalcBlock: NULL];
}

#pragma mark Calculation Blocks
/**
 * Gets the value mod block for the specified mod type.
 * @param {IonValueModType} the mod type to get the value for.
 * @returns {IonValueModBlock}
 */
+ (IonValueModBlock) modBlockForType:(IonValueModType) type {
    switch ( type ) {
        case IonValueModType_Subtract:
            return ^CGFloat(CGFloat a, CGFloat b) {
                return a - b;
            };
            break;
        case IonValueModType_Multiply:
            return ^CGFloat(CGFloat a, CGFloat b) {
                return a * b;
            };
            break;
        case IonValueModType_Divide:
            return ^CGFloat(CGFloat a, CGFloat b) {
                return a / b;
            };
            break;
        default:
            return ^CGFloat(CGFloat a, CGFloat b) {
                return a + b;
            };
            break;
    }
}

/**
 * A calculation block which preforms the inputted block on all guides.
 * @param {CGFloat(^)( CGFloat a, CGFloat b)} the block which gets called for each set of values.
 * @returns {IonGuildLineCalcBlock}
 */
+ (IonGuildLineCalcBlock) compositeCalcBlockUsingValueBlock:(IonValueModBlock) valueBlock {
    __block CGFloat(^valueCalcBlock)( CGFloat a, CGFloat b) = valueBlock;
    
    return ^CGFloat( NSDictionary *targetValues ) {
        __block CGFloat resultValue = 0.0f;
        __block BOOL hasBeenSet = false;
        
        [targetValues enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
            if ( hasBeenSet )
                resultValue = valueCalcBlock ( resultValue, [obj floatValue] );
            else {
                hasBeenSet = true;
                resultValue = [obj floatValue];
            }
        }];
        
        return resultValue;
    };
}

/**
 * Gets the calc block for the specified modification type.
 * @param {IonValueModType} the modification type used to composite values.
 * @returns {IonGuildLineCalcBlock}
 * @warning This does not behave correctly when using subtraction
 */
+ (IonGuildLineCalcBlock) calcBlockForModType:(IonValueModType) modType {
    return [[self class] compositeCalcBlockUsingValueBlock: [[self class] modBlockForType: modType]];
}

/**
 * The default calculation block.
 * @returns {IonGuildLineCalcBlock}
 */
+ (IonGuildLineCalcBlock) defaultCalculationBlock {
    return[[self class] calcBlockForModType: IonValueModType_Add];
}

/**
 * Constructs an calc block which subtracts the two values. Value1 - Value2
 * @param {NSString*} the key of value 1
 * @param {NSString*} the key of value 2
 * @returns {IonGuildLineCalcBlock}
 */
+ (IonGuildLineCalcBlock) calcBlockWithSubtracted:(NSString *)value1 by:(NSString *)value2 {
    __block NSString *val1, *val2;
    NSParameterAssert( value1 && [value1 isKindOfClass: [NSString class]] );
    NSParameterAssert( value2 && [value2 isKindOfClass: [NSString class]] );
    if ( !value1 || ![value1 isKindOfClass: [NSString class]] ||
         !value2 || ![value2 isKindOfClass: [NSString class]] )
        return NULL;
    
    val1 = value1;
    val2 = value2;
    
    return ^CGFloat( NSDictionary *targetValues ) {
        NSNumber *num1, *num2;
        
        num1 = [targetValues objectForKey: val1];
        num2 = [targetValues objectForKey: val2];
        
        return [(num1 ? num1 : @0) floatValue] - [(num2 ? num2 : @0) floatValue];
    };
}


#pragma mark Cleanup
/**
 * Attempts to automatically de-register
 */
- (void) dealloc {
    [[self targets] removeAllObjects];
}


@end
