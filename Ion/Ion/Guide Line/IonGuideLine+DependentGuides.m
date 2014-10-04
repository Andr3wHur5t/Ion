//
//  IonGuideLine+DependentGuides.m
//  Ion
//
//  Created by Andrew Hurst on 8/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideLine+DependentGuides.h"

@implementation IonGuideLine (DependentGuides)
/**
 * Creates a guide line from two guide line modified by each other.
 * @param {IonGuideLine*} the first guide line.
 * @param {IonGuideLine*} the second guide line.
 * @returns {instancetype}
 */
- (instancetype) initWithGuide:(IonGuideLine*) firstGuide
                       modType:(IonValueModType) modType
                andSecondGuide:(IonGuideLine*) secondGuide {
    IonGuideLine *resultGuide;
    NSParameterAssert( secondGuide && [secondGuide isKindOfClass:[IonGuideLine class]] );
    NSParameterAssert( firstGuide && [firstGuide isKindOfClass:[IonGuideLine class]] );
    if ( !firstGuide || ![firstGuide isKindOfClass: [IonGuideLine class]] ||
        !secondGuide || ![secondGuide isKindOfClass: [IonGuideLine class]] )
        return NULL;
    
    resultGuide = [IonGuideLine guideWithTarget: firstGuide
                                        keyPath: @"position"
                                   andCalcBlock: modType == IonValueModType_Subtract ?
                   [[self class] calcBlockWithSubtracted: sIonGuideLine_PrimaryTargetKey by: @"secondGuide"] :
                   [[self class] calcBlockForModType: modType] ];
    
    // Add Secondary target guide
    [resultGuide addTarget: secondGuide withKeyPath: @"position" andName:@"secondGuide"];
    
    return resultGuide;
}

/**
 * Creates a guide line from two guide line modified by each other.
 * @param {IonGuideLine*} the first guide line.
 * @param {IonGuideLine*} the second guide line.
 * @returns {instancetype}
 */
+ (instancetype) guideWithGuide:(IonGuideLine*) firstGuide
                        modType:(IonValueModType) modType
                 andSecondGuide:(IonGuideLine*) secondGuide {
    return [[[self class] alloc] initWithGuide: firstGuide modType: modType andSecondGuide: secondGuide];
}
@end
