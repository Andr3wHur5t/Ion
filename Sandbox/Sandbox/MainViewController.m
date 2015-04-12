//
//  MainViewController.m
//  Sandbox
//
//  Created by Andrew Hurst on 10/19/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "MainViewController.h"

#import "PeopleViewController.h"
#import "ViewfinderViewController.h"
#import "EventsViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@interface MainViewController () <IonPaginationControllerDelegate>

/**
 * Our title bar.
 */
@property (strong, nonatomic, readonly) IonTitleBar *titleBar;

/**
 * Our Content View.
 */
@property (strong, nonatomic, readonly) IonPaginationController *contentView;

#pragma mark Controllers

/**
 * People Page Controller
 */
@property (strong, nonatomic, readonly) PeopleViewController *peoplePage;

/**
 * Viewfinder Page Controller
 */
@property (strong, nonatomic, readonly) ViewfinderViewController *viewfinderPage;

/**
 * Events Page Controller
 */
@property (strong, nonatomic, readonly) EventsViewController *eventsPage;

/**
 * Events Page Title Bar Configuration.
 */

@end

@implementation MainViewController

@synthesize titleBar = _titleBar;
@synthesize contentView = _contentView;
@synthesize peoplePage = _peoplePage;
@synthesize viewfinderPage = _viewfinderPage;
@synthesize eventsPage = _eventsPage;


#pragma mark Controller Interface

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview: self.titleBar];
    [self.view addSubview: self.contentView];
    
    // Add Children View controllers
    [self addChildViewController: self.peoplePage];
    [self addChildViewController: self.eventsPage];
    [self addChildViewController: self.viewfinderPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Title Bar

- (IonTitleBar *)titleBar {
    if ( !_titleBar ) {
        _titleBar  = [[IonTitleBar alloc] init];
        _titleBar.respondsToStatusBar = TRUE;
    }
    return _titleBar;
}


#pragma mark Content View

- (IonPaginationController *)contentView {
    if ( !_contentView ) {
        _contentView = [[IonPaginationController alloc] initWithHorizontalMode: TRUE];
        _contentView.delegate = self;
        
        // Set position, and size
        [_contentView setGuidesWithLocalHoriz: _contentView.originGuideHoriz
                                    localVert: _contentView.originGuideVert
                                   superHoriz: self.view.originGuideHoriz
                                    superVert: self.titleBar.sizeExternalGuideVert
                                         left: self.view.originGuideHoriz
                                        right: self.view.sizeGuideHoriz
                                          top: self.titleBar.sizeExternalGuideVert
                                    andBottom: self.view.sizeGuideVert];
        
        // Add Content
        [_contentView addPage: self.peoplePage withName: @"people"];
        [_contentView addPage: self.viewfinderPage withName: @"viewfinder"];
        [_contentView addPage: self.eventsPage withName: @"events"];
        
        // Set Starting Page
        [_contentView navigateToPageWithName: @"viewfinder" animated: NO];
    }
    return _contentView;
}

- (void) didNavigateToPageAtIndex:(NSUInteger)index {
    // Update the title bar.
    [((IonViewController *)[self.contentView.pages objectAtIndex: index]).titleConfiguration apply: self.titleBar];
}


#pragma mark Controllers

- (PeopleViewController *)peoplePage {
    if ( !_peoplePage ) {
        _peoplePage = [[PeopleViewController alloc] init];

        [((IonInterfaceButton *)_peoplePage.titleConfiguration.rightView) addTarget:self action: @selector(goToViewfinder) forControlEvents: IonCompletedButtonAction];
    }
    return _peoplePage;
}

- (ViewfinderViewController *)viewfinderPage {
    if ( !_viewfinderPage ) {
        _viewfinderPage = [[ViewfinderViewController alloc] init];
        
        [((IonInterfaceButton *)_viewfinderPage.titleConfiguration.leftView) addTarget:self action: @selector(goToPeople) forControlEvents: IonCompletedButtonAction];
        [((IonInterfaceButton *)_viewfinderPage.titleConfiguration.rightView) addTarget:self action: @selector(goToEvents) forControlEvents: IonCompletedButtonAction];
        
    }
    return _viewfinderPage;
}

- (EventsViewController *)eventsPage {
    if ( !_eventsPage ) {
        _eventsPage = [[EventsViewController alloc] init];
        
        [((IonInterfaceButton *)_eventsPage.titleConfiguration.leftView) addTarget:self action: @selector(goToViewfinder) forControlEvents: IonCompletedButtonAction];
    }
    return _eventsPage;
}

- (void) goToViewfinder {
    //[self.contentView navigateToPageWithName: @"viewfinder"];
   
}

- (void) goToEvents {
    [self.contentView navigateToPageWithName: @"events"];
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    NSDictionary *info;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
}

- (void) goToPeople {
    [self.contentView navigateToPageWithName: @"people"];
}

- (void) goToProfile {

}

@end




