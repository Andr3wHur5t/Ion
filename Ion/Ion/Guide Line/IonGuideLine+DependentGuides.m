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
    __block IonGuideLine *blockSafeSecondGuide, *blockSafeFirstGuide;
    NSParameterAssert( secondGuide && [secondGuide isKindOfClass:[IonGuideLine class]] );
    NSParameterAssert( firstGuide && [firstGuide isKindOfClass:[IonGuideLine class]] );
    if ( !firstGuide || ![firstGuide isKindOfClass: [IonGuideLine class]] ||
        !secondGuide || ![secondGuide isKindOfClass: [IonGuideLine class]] )
        return NULL;
    
    
    blockSafeSecondGuide = secondGuide;
    blockSafeFirstGuide = firstGuide;
    resultGuide = [IonGuideLine guideWithTarget: firstGuide
                                        keyPath: @"position"
                                   andCalcBlock: ^CGFloat(CGFloat target) {
        CGFloat res;
        switch ( modType) {
            case IonValueModType_Subtract:
                res = blockSafeFirstGuide.position - blockSafeSecondGuide.position;
                break;
            case IonValueModType_Multipliy:
                res = blockSafeFirstGuide.position * blockSafeSecondGuide.position;
                break;
            case IonValueModType_Devide:
                res = blockSafeFirstGuide.position / blockSafeSecondGuide.position;
                break;
            default:
                res = blockSafeFirstGuide.position + blockSafeSecondGuide.position;
                break;
        }
        return res;
    }];
    
    // Add Dependent Guide
    [resultGuide addDependentTarget: secondGuide  andKeyPath: @"position"];
    
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
