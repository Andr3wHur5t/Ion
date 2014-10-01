//
//  IonLabelOverflowBehavior.h
//  Ion
//
//  Created by Andrew Hurst on 8/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonLabel.h"

static CGFloat sIonTextScrollSpeed = 0.04f;//s

@interface IonLabelOverflowBehavior : NSObject <IonLabelOverflowBehaviorDelegate>

/**
 * The containing view.
 */
@property (weak, nonatomic) IonLabel* container;

/**
 * The label view.
 */
@property (weak, nonatomic) UILabel* label;


#pragma mark Utilities

/**
 * Check if we can perform management functions.
 * @returns {BOOL}
 */
- (BOOL) canPerformManagementFunctions;
@end
