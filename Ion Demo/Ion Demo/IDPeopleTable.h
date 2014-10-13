//
//  IDPeopleTabel.h
//  Ion Demo
//
//  Created by Andrew Hurst on 10/8/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <IonCore/IonCore.h>
#import <PHData/PHData.h>

@interface IDPeopleTable : IonScrollView

#pragma mark KVC Data model.
/**
 * Registeres the keypath with the update.
 * @param target - the target object to observe.
 * @param keypath - the keypath to observe on the target object.
 */
- (void) registerDataModelInTarget:(id) target atKeyPath:(NSString *)keyPath;

#pragma mark Manual Item Management
/**
 * Adds A Profile to the scroll view.
 * @param profile - the profile you want added to the view.
 */
- (void) addProfile:(PHProfile *)profile;

/**
 * Adds an array of profiles to the view.
 * @param profiles - the array of profiles you want to add.
 */
- (void) addProfiles:(NSArray *)profiles;

@end
