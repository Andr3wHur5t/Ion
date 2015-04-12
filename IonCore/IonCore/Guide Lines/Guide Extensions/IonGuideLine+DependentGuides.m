//
//  IonGuideLine+DependentGuides.m
//  Ion
//
//  Created by Andrew Hurst on 8/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideLine+DependentGuides.h"

@implementation IonGuideLine (DependentGuides)

- (instancetype)initWithGuide:(IonGuideLine *)firstGuide
                      modType:(IonValueModType)modType
               andSecondGuide:(IonGuideLine *)secondGuide {
  IonGuideLine *resultGuide;
  NSParameterAssert(secondGuide &&
                    [secondGuide isKindOfClass:[IonGuideLine class]]);
  NSParameterAssert(firstGuide &&
                    [firstGuide isKindOfClass:[IonGuideLine class]]);
  if (!firstGuide || ![firstGuide isKindOfClass:[IonGuideLine class]] ||
      !secondGuide || ![secondGuide isKindOfClass:[IonGuideLine class]])
    return NULL;

  resultGuide = [IonGuideLine
      guideWithTarget:firstGuide
              keyPath:@"position"
         andCalcBlock:
             modType == IonValueModType_Subtract
                 ? [[self class]
                       calcBlockWithSubtracted:sIonGuideLine_PrimaryTargetKey
                                            by:@"secondGuide"]
                 : [[self class] calcBlockForModType:modType]];

  // Add Secondary target guide
  [resultGuide addTarget:secondGuide
             withKeyPath:@"position"
                 andName:@"secondGuide"];

  return resultGuide;
}

+ (instancetype)guideWithGuide:(IonGuideLine *)firstGuide
                       modType:(IonValueModType)modType
                andSecondGuide:(IonGuideLine *)secondGuide {
  return [[[self class] alloc] initWithGuide:firstGuide
                                     modType:modType
                              andSecondGuide:secondGuide];
}

#pragma mark Arithmetic

- (IonGuideLine *)dividedBy:(IonGuideLine *)otherGuide {
  return [IonGuideLine guideWithGuide:self
                              modType:IonValueModType_Divide
                       andSecondGuide:otherGuide];
}

- (IonGuideLine *)multipliedBy:(IonGuideLine *)otherGuide {
  return [IonGuideLine guideWithGuide:self
                              modType:IonValueModType_Multiply
                       andSecondGuide:otherGuide];
}

- (IonGuideLine *)addedBy:(IonGuideLine *)otherGuide {
  return [IonGuideLine guideWithGuide:self
                              modType:IonValueModType_Add
                       andSecondGuide:otherGuide];
}

- (IonGuideLine *)subtractedBy:(IonGuideLine *)otherGuide {
  return [IonGuideLine guideWithGuide:self
                              modType:IonValueModType_Subtract
                       andSecondGuide:otherGuide];
}

#pragma mark Max Guides

- (IonGuideLine *)max:(IonGuideLine *)bGuide {
  NSParameterAssert([bGuide isKindOfClass:[IonGuideLine class]]);
  if (![bGuide isKindOfClass:[IonGuideLine class]]) return NULL;

  return [[self class] guideWithGuide:self
                              modType:IonValueModType_Max
                       andSecondGuide:bGuide];
}

- (IonGuideLine *)min:(IonGuideLine *)bGuide {
  NSParameterAssert([bGuide isKindOfClass:[IonGuideLine class]]);
  if (![bGuide isKindOfClass:[IonGuideLine class]]) return NULL;

  return [[self class] guideWithGuide:self
                              modType:IonValueModType_Min
                       andSecondGuide:bGuide];
}

@end
