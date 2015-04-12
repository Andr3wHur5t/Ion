//
//  SearchableTableViewController.m
//  Sandbox
//
//  Created by Andrew Hurst on 10/20/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "SearchableTableViewController.h"

@interface SearchableTableViewController () {
    IonView *previousCell;
}
#pragma mark Search
/**
 * Our Search Bar.
 */
@property (strong, nonatomic, readonly) IonView *searchBar;

#pragma mark Table
/**
 * Adds Content to our table view.
 */
- (void) addContentToTable;

@end

@implementation SearchableTableViewController

@synthesize searchBar = _searchBar;
@synthesize searchField = _searchField;
@synthesize table = _table;

#pragma mark Controller Interface

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add our subviews
    [self.view addSubview: self.table];
    [self.view addSubview: self.searchBar];
    
    // Add Content
    [self addContentToTable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Search

- (IonView *)searchBar {
    if ( !_searchBar ) {
        _searchBar = [[IonView alloc] init];
        
        _searchBar.themeElement = @"infobar";
        // Set Position And Size.
        [_searchBar setGuidesWithLocalHoriz: _searchBar.originGuideHoriz
                                  localVert: _searchBar.originGuideVert
                                 superHoriz: self.view.originGuideHoriz
                                  superVert: self.view.originGuideVert
                                       left: self.view.originGuideHoriz
                                      right: self.view.sizeGuideHoriz
                                        top: [@0 toGuideLine]
                                  andBottom: [@45 toGuideLine]];
        
        // Adds our search field
        [_searchBar addSubview: self.searchField];
    }
    return _searchBar;
}

- (IonTextBar *)searchField {
    if ( !_searchField ) {
        _searchField = [[IonTextBar alloc] init];
        
        // Configure
        _searchField.themeClass = @"search";
        [self configureSearchField];
        
        // Position And Size.
        [_searchField setGuidesWithLocalHoriz: _searchField.originGuideHoriz
                                    localVert: _searchField.originGuideVert
                                   superHoriz: self.searchBar.leftAutoPadding
                                    superVert: self.searchBar.topAutoPadding
                                         left: self.searchBar.leftAutoPadding
                                        right: self.searchBar.rightAutoPadding
                                          top: self.searchBar.topAutoPadding
                                    andBottom: self.searchBar.bottomAutoPadding];
    }
    return _searchField;
}

- (void) configureSearchField {
    // Should be subclassed;
}

#pragma mark Table

- (IonScrollView *)table {
    if ( !_table ) {
        _table = [[IonScrollView alloc] init];
        
        
        // Position & Size
        [_table setGuidesWithLocalHoriz: _table.originGuideHoriz
                              localVert: _table.originGuideVert
                             superHoriz: self.view.originGuideHoriz
                              superVert: self.view.originGuideVert
                                   left: self.view.originGuideHoriz
                                  right: self.view.sizeGuideHoriz
                                    top: self.view.originGuideVert
                              andBottom: self.view.sizeGuideVert];
        
        [_table setContentSizeHoriz: _table.sizeGuideHoriz  andVert: _table.bottomMargin];
        
        
        // Kinda Cheating... but I can fix it later.
        [self performBlock:^{
            UIEdgeInsets insets = _table.contentInset;
            insets.top = self.searchBar.sizeExternalGuideVert.position;
            _table.scrollIndicatorInsets = insets;
            _table.contentInset = insets;
        } afterDelay: 1.8];
    }
    return _table;
}


- (void) addContentToTable {
    // Should be subclassed;
}


- (void) addCell:(IonView *)cell {
    NSParameterAssert( [cell isKindOfClass: [IonView class]] );
    if ( ![cell isKindOfClass: [IonView class]] )
        return;
    
    [self.table addSubview: cell];
    
    // Position the cell.
    [cell setGuidesWithLocalHoriz: cell.centerGuideHoriz
                        localVert: cell.originGuideVert
                       superHoriz: self.table.centerGuideHoriz
                     andSuperVert: previousCell ? previousCell.bottomMargin : self.table.topAutoPadding] ;
    
    self.table.contentSizeVert = cell.bottomMargin;
    
    // Update Previous Cell
    previousCell = cell;
}


@end
