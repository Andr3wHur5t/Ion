//
//  IonVisualTestViewController.m
//  Ion
//
//  Created by Andrew Hurst on 7/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonVisualTestViewController.h"

@interface IonVisualTestViewController () {
    UIView* imgView;
}

@end

@implementation IonVisualTestViewController

- (void) constructViews {
    [super constructViews];
    // Render Debug
    imgView = [[UIView alloc] init];
    [self.view addSubview:imgView];
    
    // Theme Testing
    imgView.themeConfiguration.themeClass = @"secondaryStyle";
    self.view.themeConfiguration.themeShouldBeAppliedToSelf = FALSE;
    //imgView.themeID = @"simpleStyle";
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    // Set the overriden background.
    
    [self.view setBackgroundImage: [UIImage imageNamed:@"aspect-test"] renderMode: IonBackgroundRenderContained];
}

- (void) shouldLayoutSubviews {
    [super shouldLayoutSubviews];
    CGSize s = self.view.frame.size;
    s.height = 20 + 70;
    imgView.frame = (CGRect) {CGPointZero,s};
}


/**
 * This is where we should free our recreateable data, or save data to disk.
 */
- (void) shouldFreeNonCriticalObjects {
    
}

@end
