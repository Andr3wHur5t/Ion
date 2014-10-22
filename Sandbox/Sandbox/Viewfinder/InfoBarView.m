//
//  InfoBarView.m
//  Sandbox
//
//  Created by Andrew Hurst on 10/20/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "InfoBarView.h"
#import <PHData/PHData.h>

@implementation InfoBarView

@synthesize detailsButton = _detailsButton;
@synthesize label = _label;

#pragma mark Construction

- (void) construct {
    self.themeElement = @"infobar";
    
    [self addSubview: self.detailsButton];
    [self addSubview: self.label];
}

#pragma mark Details Button

- (IonInterfaceButton *)detailsButton {
    if ( !_detailsButton ) {
        _detailsButton = [[IonInterfaceButton alloc] initWithFileName: @"Hamburger"];
        
        // Position View
        [_detailsButton setGuidesWithLocalHoriz: _detailsButton.originGuideHoriz
                                      localVert: _detailsButton.centerGuideVert
                                     superHoriz: self.leftAutoPadding
                                   andSuperVert: self.centerGuideVert];
    }
    return _detailsButton;
}

#pragma mark Label

- (IonLabel *)label {
    if ( !_label ) {
        _label = [[IonLabel alloc] init];
        
        _label.text = [PHText loremWithWordCount: 12];
          // Position & Size View
        [_label setGuidesWithLocalHoriz: _label.originGuideHoriz
                              localVert: _label.centerGuideVert
                             superHoriz: self.detailsButton.rightMargin
                              superVert: self.centerGuideVert
                                   left: self.detailsButton.rightMargin
                                  right: self.rightAutoPadding
                                    top: self.topAutoPadding
                              andBottom: self.bottomAutoPadding];
    }
    return _label;
}

@end
