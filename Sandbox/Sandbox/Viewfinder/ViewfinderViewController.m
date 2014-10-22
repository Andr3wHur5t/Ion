//
//  ViewfinderViewController.m
//  Sandbox
//
//  Created by Andrew Hurst on 10/19/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "ViewfinderViewController.h"
#import "InfoBarView.h"
#import "CameraPreview.h"

@interface ViewfinderViewController ()

/**
 * Our Info Bar.
 */
@property (strong, nonatomic, readonly) InfoBarView *infoBar;

/**
 * Our Camera view.
 */
@property (strong, nonatomic, readonly) CameraPreview *cameraPreview;

@end

@implementation ViewfinderViewController

@synthesize infoBar = _infoBar;
@synthesize cameraPreview = _cameraPreview;

#pragma mark Controller Interface
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Configure view theme settings
    self.view.themeElement = @"viewfinder";
    
    // Add Subviews
    [self.view addSubview: self.cameraPreview];
    [self.view addSubview: self.infoBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Info Bar

- (InfoBarView *)infoBar {
    if ( !_infoBar ) {
        _infoBar = [[InfoBarView alloc] init];
        
        // Position & Size
        [_infoBar setGuidesWithLocalHoriz: _infoBar.originGuideHoriz
                                localVert: _infoBar.originGuideVert
                               superHoriz: self.view.originGuideHoriz
                                superVert: self.view.originGuideVert
                                     left: self.view.originGuideHoriz
                                    right: self.view.sizeGuideHoriz
                                      top: self.view.originGuideHoriz
                                andBottom: [@45 toGuideLine]];
    }
    return _infoBar;
}

#pragma mark Camera Preview

- (CameraPreview *)cameraPreview {
    if ( !_cameraPreview ) {
        _cameraPreview = [[CameraPreview alloc] init];
        
        // Position
        [_cameraPreview setGuidesWithLocalHoriz: _cameraPreview.originGuideHoriz
                                      localVert: _cameraPreview.originGuideVert
                                     superHoriz: self.view.originGuideHoriz
                                      superVert: self.view.originGuideVert
                                           left: self.view.originGuideHoriz
                                          right: self.view.sizeGuideHoriz
                                            top: self.view.originGuideVert
                                      andBottom: self.view.sizeGuideVert];
        
    }
    return _cameraPreview;
}


#pragma mark Title Bar

- (void) configureTitleConfiguration {
    self.titleConfiguration.leftView = [[IonInterfaceButton alloc] initWithFileName: @"People"];
    self.titleConfiguration.rightView = [[IonInterfaceButton alloc] initWithFileName: @"Events"];
    self.titleConfiguration.centerView = [[IonInterfaceButton alloc] initWithFileName: @"Spottr"];
}


@end
