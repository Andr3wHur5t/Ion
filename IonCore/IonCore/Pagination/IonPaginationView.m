//
//  IonPaginationView.m
//  IonCore
//
//  Created by Andrew Hurst on 10/16/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IonPaginationView.h"

@interface IonPaginationView ()

/**
 * An array of our current pages.
 */
@property (strong, nonatomic, readonly) NSMutableArray *pages;

/**
 * Array from our active pages.
 */
@property (strong, nonatomic, readonly) NSMutableArray *activePages;


#pragma mark Page Refrences
/**
 * A Refrence to the first active page.
 */
@property (weak, nonatomic, readwrite) id firstActivePage;

/**
 * Checks if the first active page has passed our, change thresholds.
 */
- (void)checkFirstActivePage;

/**
 * A Refrence to the last active page.
 */
@property (weak, nonatomic, readwrite) id lastActivePage;

/**
 * Checks if the last active page has passed our, change thresholds.
 */
- (void)checkLastActivePage;

@end


@implementation IonPaginationView

@synthesize pages = _pages;
@synthesize activePages = _activePages;

#pragma mark Pagination Checks

- (NSMutableArray *)activePages {
    if ( !_activePages )
        _activePages = [[NSMutableArray alloc] init];
    return _activePages;
}


- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset: contentOffset];
    
    // Run all pagination checks
    [self checkFirstActivePage];
    [self checkLastActivePage];
}

#pragma mark First Active Page

- (void)checkFirstActivePage {
    // Top passes top change threshold
        // Change First Cell to second cell
        // Load New Cell, it make first cell
    // Bottom passes top change threshold
        // Remove First Cell
        // Update Second Cell to first Cell
}

#pragma mark Last Active Cell

- (void)checkLastActivePage {
    // Top passes bottom change threshold
        // Change last Cell to second to last cell
        // Load New Cell, it make last cell
    // Bottom passes bottom change threshold
        // Remove last Cell
        // Update Second Cell to last Cell
}

#pragma mark Page Management

- (NSMutableArray *)pages {
    if ( !_pages )
        _pages = [[NSMutableArray alloc] init];
    return _pages;
}



@end
