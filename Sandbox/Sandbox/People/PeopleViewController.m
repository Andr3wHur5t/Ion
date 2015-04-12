//
//  PeopleViewController.m
//  Sandbox
//
//  Created by Andrew Hurst on 10/19/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "PeopleViewController.h"
#import "PersonCell.h"
#import "PersonGroupCell.h"

@interface PeopleViewController () {
    IonLabel *titleLabel;
}
@end

@implementation PeopleViewController

- (void) configureSearchField {
    self.searchField.placeholder = @"Search for a name";
}

- (void) configureTitleConfiguration {
    titleLabel = [[IonLabel alloc] init];
    titleLabel.text = @"People";
    
    self.titleConfiguration.leftView = [[IonInterfaceButton alloc] initWithFileName: @"addContact"];
    ((IonInterfaceButton *)self.titleConfiguration.leftView).enabled = false;
    
    self.titleConfiguration.rightView = [[IonInterfaceButton alloc] initWithFileName: @"Viewfinder"];
    self.titleConfiguration.centerView = titleLabel;
}

- (void) addContentToTable {
    PersonCell *cell;
    NSArray *content = [PHProfile randomProfilesWithCount: 10];
    for ( PHProfile *profile in content ) {
        cell = [[PersonCell alloc] init];
        
        
        // Size the cell
        
        [cell setSizeGuidesWithLeft: self.table.leftAutoPadding
                              right: self.table.rightAutoPadding
                                top: [@0 toGuideLine]
                          andBottom: [@80 toGuideLine]];
        
        
        [self addCell: cell];
        cell.model = profile;
    }
}


@end
