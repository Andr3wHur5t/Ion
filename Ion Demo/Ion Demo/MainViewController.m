//
//  ViewController.m
//  Ion Demo
//
//  Created by Andrew Hurst on 10/8/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "MainViewController.h"
#import "IDPeopleTable.h"

@interface MainViewController ()

/**
 * The title view of the controller. Constructed, and setup in getter.
 */
@property (strong, nonatomic, readonly) IonTitleBar *titleBar;

/**
 * Our table of profiles.
 */
@property (strong, nonatomic, readonly) IDPeopleTable *profileTable;


/**
 * An array of randomly generated profile data to be used as our data model.
 */
@property (strong, nonatomic, readwrite) NSMutableArray *profileModel;

@end

@implementation MainViewController

@synthesize titleBar = _titleBar;
@synthesize profileTable = _profileTable;
@synthesize profileModel = _profileModel;

#pragma mark Construction
- (instancetype) init {
    self = [super init];
    if ( self )
        // Adding a status bar behavior which will toggle the status bar when we shake the device.
        // Note it will auto return after a period of time.
        [self addDelegateToManager: [[IonStatusBarBehaviorMotionGestureDisplay alloc] init]];
    return self;
}

#pragma mark Controller Interface
- (void)constructViews {
    // Construct your views here, this will allow you to configure your views with the initial style.
   
    // Add a title bar & update its frame
    // Note: The view is configured in its' getter.
    [self.view addSubview: self.titleBar];
    [self.titleBar updateFrame];

    // Add a text bar.
    
    // Add our profile table to the view. look at the IDProfileTable For more Information.
    [self.view addSubview: self.profileTable];
    
    // Register our profile data model with the table so that it will automaticly update.
    [self.profileTable registerDataModelInTarget: self atKeyPath: @"profileModel"];
    
    // Generate some data for our profile data model in a KVC compliant way.
    [self addProfileModelObjects: [PHProfile randomProfilesWithCount: 10]];
    
    [self performBlock:^{
        // NOTE: This appears not to work... for style application
        [self addProfileModelObjects: [PHProfile randomProfilesWithCount: 10]];
    } afterDelay: 4.0f];
}

#pragma mark Object Construction

- (IonTitleBar *)titleBar {
    // Construct our title bar if we haven't already
    if ( !_titleBar ) {
        _titleBar = [[IonTitleBar alloc] init];
        
        // We added a status bar behavior to the application, we can observe when it changes and update our position.
        _titleBar.respondsToStatusBar = TRUE;
        
        // Set the position of the title bar. (Technicaly this can be implicit but its here for example.)
        [_titleBar setGuidesWithLocalHoriz: _titleBar.originGuideHoriz
                                 localVert: _titleBar.originGuideVert
                                superHoriz: self.view.originGuideHoriz
                              andSuperVert: self.view.originGuideVert];
        
    }
    return _titleBar;
}

- (IDPeopleTable *)profileTable {
    // Construct our table if needed.
    if ( !_profileTable ) {
        _profileTable = [[IDPeopleTable alloc] init];
        
        // Set the class of table so that the theme system can configure it for us.
        _profileTable.themeClass = @"profileTable";
        _profileTable.backgroundColor = UIColorFromRGB( 0xF5F5F5 );
        
        // Set the position of our table.
        [_profileTable setGuidesWithLocalHoriz: _profileTable.originGuideHoriz
                                     localVert: _profileTable.originGuideVert
                                    superHoriz: self.view.originGuideVert
                                     superVert: self.titleBar.sizeExternalGuideVert
                                          left: self.view.originGuideHoriz
                                         right: self.view.sizeGuideHoriz
                                           top: self.titleBar.sizeExternalGuideVert
                                     andBottom: self.view.sizeGuideVert];
    }
    return _profileTable;
}

#pragma mark Data Model

- (NSMutableArray *)profileModel {
    if ( !_profileModel )
        _profileModel = [[NSMutableArray alloc] init];
    return _profileModel;
}

// KVC compliance is required to support automatic updates
- (void) addProfileModelObjects:(NSArray *) profileObjects {
    for (PHProfile *profile in profileObjects )
        [self addProfileModelObject: profile];
}

- (void) addProfileModelObject:(PHProfile *)object {
    [self insertObject: object inProfileModelAtIndex: [self.profileModel count]];
}

- (void)insertObject:(PHProfile *)profile inProfileModelAtIndex:(NSUInteger)index {
    [self.profileModel insertObject: profile atIndex: index];
}

- (void)removeObjectFromProfileModelAtIndex:(NSUInteger)index {
   [self.profileModel removeObjectAtIndex:index];
}


#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
