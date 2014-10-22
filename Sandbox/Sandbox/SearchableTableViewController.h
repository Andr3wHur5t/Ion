//
//  SearchableTableViewController.h
//  Sandbox
//
//  Created by Andrew Hurst on 10/20/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <IonCore/IonCore.h>

@interface SearchableTableViewController : IonViewController

#pragma mark Search
/**
 * Our Search Field.
 */
@property (strong, nonatomic, readonly) IonTextBar *searchField;

/**
 * Invoked when whe should configure our search field.
 */
- (void) configureSearchField;

#pragma mark Table
/**
 * Our Table View
 */
@property (strong, nonatomic, readonly) IonScrollView *table;

/**
 * Adds a cell to the table view.
 * @param cell - the cell to add to the view.
 */
- (void) addCell:(IonView *)cell;

@end
