//
//  IonStyle.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonStyle.h"
#import "UIView+IonBackgroundUtilities.h"

@interface IonStyle ()

@property NSMutableDictionary* colors;
@property NSMutableDictionary* gradients;
@property NSMutableDictionary* images;

@end

@implementation IonStyle

#pragma mark External Interface

/**
 * This is a Parseing constructor
 */
- (instancetype) initWithConfiguration:(NSDictionary*) config {
    self = [self init];
    
    if ( self ) {
        NSLog(@"config");
    }
    
    return self;
}

/**
 * This applys the current style to the inputted view.
 * @param {UIVIew*} the view to apply the style to.
 * @returns {void}
 */
- (void) applyToView:(UIView*) view {
    // Call all seting to view here
    
    // Call the deligate and dasiy chanined deligates.
}

/**
 * This overrides the current styles proproties with the inputed style.
 * @param {IonStyle*} the style to override the current style
 * @returns {IonStyle*} the net style of the overide
 */
- (IonStyle*) overideStyleWithStyle:(IonStyle*)overideingStyle {
    IonStyle* result = [[IonStyle alloc] init];
    
    //overide proproties with the overideing styles proproties.
    
    return result;
}



#pragma mark Base View Interface

@end
