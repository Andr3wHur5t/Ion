//
//  IonVisualTestViewController.m
//  Ion
//
//  Created by Andrew Hurst on 7/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonVisualTestViewController.h"



@interface IonVisualTestViewController () {
    IonSimpleCache* sc;
    IonTitleBar* titleBar;
    IonView* containerView;
    IonScrollView *scrollView;
}

@end

@implementation IonVisualTestViewController

- (void) constructViews {
    [super constructViews];
    
    [self.view setBackgroundImageUsingKey: @"aspect"];

    [self constructTitleBar];
    [self constructContentBar];
    [self constructContentView];
}

/**
 * Constructs the content view.
 */
- (void) constructContentView {
    scrollView = [[IonScrollView alloc] init];
   [scrollView setSuperGuidesWithHorz: self.view.originGuideHoriz
                              andVert: containerView.sizeExternalGuideVert];
    
    scrollView.leftSizeGuide = self.view.originGuideHoriz;
    scrollView.rightSizeGuide = self.view.sizeGuideHoriz;
    scrollView.topSizeGuide = containerView.sizeExternalGuideVert;
    scrollView.bottomSizeGuide = self.view.sizeGuideVert;
    
    [self.view addSubview: scrollView];
}

/**
 * Constructs the title bar.
 */
- (void) constructTitleBar {
    IonButton *leftButton, *rightButton;
    IonLabel* testLabel;
    
    titleBar = [[IonTitleBar alloc] init];
    [self.view addSubview: titleBar];
    
    leftButton = [[IonInterfaceButton alloc] initWithFileName: @"Add"];
    rightButton = [[IonInterfaceButton alloc] initWithFileName: @"Add"];
    
    testLabel = [[IonLabel alloc] init];
    //testLabel.text = @"Lorem ipsum dolor sit amet consectetur adipiscing elit";
    testLabel.text = @"People";
    
    
    titleBar.leftView = leftButton;
    titleBar.rightView = rightButton;
    titleBar.centerView = testLabel;
    titleBar.respondsToStatusBar = TRUE;
    [titleBar updateFrame];
    
    // Position
    titleBar.localHorizGuide = titleBar.centerGuideHoriz;
    titleBar.localVertGuide = titleBar.originGuideVert;
    
    titleBar.superHorizGuide = self.view.centerGuideHoriz;
    titleBar.superVertGuide = self.view.originGuideVert;
}

/**
 * Constructs the content bar.
 */
- (void) constructContentBar {
    IonTextBar *textInput;
    
    containerView = [[IonView alloc] init];
    
    // Button
//    button = [[IonInterfaceButton alloc] initWithFileName: @"Hamburger"];
//    [button setGuidesWithLocalVert: button.centerGuideVert
//                        localHoriz: button.originGuideHoriz
//                         superVert: containerView.centerGuideVert
//                     andSuperHoriz: containerView.leftPadding];
    
    // text input
    textInput = [[IonTextBar alloc] initWithFrame: (CGRect){ CGPointZero, (CGSize){ 275, 30 } }];
    [textInput setGuidesWithLocalHoriz: textInput.originGuideHoriz
                             localVert: textInput.centerGuideVert
                            superHoriz: containerView.leftAutoPadding
                          andSuperVert: containerView.centerGuideVert];
    
    textInput.leftSizeGuide = containerView.leftAutoPadding;
    textInput.rightSizeGuide = containerView.rightAutoPadding;
    textInput.topSizeGuide = containerView.topAutoPadding;
    textInput.bottomSizeGuide = containerView.bottomAutoPadding;
    
    textInput.placeholder = @"Search for a name";
    textInput.themeClass = @"peopleSearch";
    [containerView addSubview: textInput];
    
    // Container
    [containerView setSuperGuidesWithHorz: self.view.originGuideHoriz
                                  andVert: titleBar.sizeExternalGuideVert];
    
    containerView.leftSizeGuide = self.view.originGuideHoriz;
    containerView.rightSizeGuide = self.view.sizeGuideHoriz;
    containerView.topSizeGuide = [IonGuideLine guideWithStaticValue: 0.0f];
    containerView.bottomSizeGuide = [IonGuideLine guideWithStaticValue: 45.0f];
    containerView.themeElement = @"sub-bar";
    
    
    //[containerView addSubview: button];
    [self.view addSubview: containerView];
    
}

- (void) viewWillAppear:(BOOL)animated {
    // Set the overriden background.
    [self doTests];
    
    // Call this last
    [super viewWillAppear: animated];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}



/** = = = = = = = = = = = = Tests = = = = = = = = = = = = = = =  */

- (void) doTests {
    sc = [IonSimpleCache cacheWithName:@"Test Cache" withLoadCompletion:^(NSError *error) {
        [self test];
    }];
    
    [self performSelector:@selector(remove) withObject:NULL afterDelay:5];
}


-(void) appendItems:(NSInteger) count inGroup:(NSString*) group arr:(NSMutableArray*) arr {
    NSNumber* randomContent;
    randomContent = [NSNumber numberWithInt: arc4random()];
    
    for ( NSInteger i = count; i >= 0; --i )
        [arr addObject: [NSString stringWithFormat:@"%@/%i", group,  arc4random()]];
    
}

- (void) test {
    NSMutableArray* paths = [@[] mutableCopy];
    //NSNumber* randomContent;
    
    [self appendItems:200 inGroup:@"here" arr: paths];
    [self appendItems:20 inGroup:@"lie" arr: paths];
    [self appendItems:100 inGroup:@"space" arr: paths];
    
    /*for ( NSString* path in paths ) {
        randomContent = [NSNumber numberWithInt: arc4random()];
        [sc setObject: [[NSData dataFromNumber: randomContent] toBase64] forKey:path withCompletion: NULL];
        for ( NSInteger i = 10 + arc4random() % 50; i >= 0; --i )
            [sc objectForKey:path withResultBlock: ^(id object) {} ];
    }*/

}

- (void) remove {
    sc = NULL;
}

- (void) shouldLayoutSubviews {
    [super shouldLayoutSubviews];
}

/** = = = = = = = = = = = = End Tests = = = = = = = = = = = = = = =  */

/**
 * This is where we should free our recreateable data, or save data to disk.
 */
- (void) shouldFreeNonCriticalObjects {
    
}

@end