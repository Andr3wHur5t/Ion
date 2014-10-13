//
//  IonScrollActionView.h
//  Ion
//
//  Created by Andrew Hurst on 10/3/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonView.h"

@class IonScrollView;

/**
 * This is an abstract class which can automatically configure IonScroll Views when added as a subview.
 */
@interface IonScrollActionView : IonView
#pragma mark Standard Interface
/**
 * Configures the IonScrollView to conform to our parameters.
 * @param scrollView - the scroll view to configure.
 */
- (void) configureScrollView:(IonScrollView *)scrollView;

/**
 * Cleans up our set configurations if any.
 * @param scrollView - the scroll view to remove our configuration from.
 */
- (void) removeConfigurationsFromScrollView:(IonScrollView *)scrollView;

@end
