//
//  IonGuideSet.h
//  Ion
//
//  Created by Andrew Hurst on 10/4/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonGuideLine.h"

@interface IonGuideSet : NSObject
#pragma mark Guides
/**
 * Our currently observed guides.
 */
@property (strong, nonatomic, readonly) NSMutableDictionary *guides;

/**
 * Sets the guide for the specified key.
 * @param guide - the new guide to set.
 * @param key - the key of the guide to set.
 */
- (void) setGuide:(IonGuideLine *)guide forKey:(NSString *)key;

/**
 * Gets the guide for the specified key.
 * @param key - the key you want the guide for.
 */
- (IonGuideLine *)guideForKey:(NSString *)key;

#pragma mark Change Callback
/**
 * Adds the target and action for guides position change updates.
 * @param target - the target to call the action on.
 * @param action the action to call on the target.
 */
- (void) addTarget:(id) target andAction:(SEL) action;

/**
 * Removes the target and action for guides position change updates.
 * @param target - the target to call the action on.
 * @param action - the action to call on the target.
 */
- (void) removeTarget:(id) target andAction:(SEL) action;

#pragma mark Guides
/**
 * Gets invoked when a guide changes.
 * @warning Invocation can cause undefined behavior. **Subclassing Only.**
 */
- (void) guideDidUpdate;

@end
