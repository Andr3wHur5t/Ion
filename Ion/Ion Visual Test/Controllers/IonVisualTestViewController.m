//
//  IonVisualTestViewController.m
//  Ion
//
//  Created by Andrew Hurst on 7/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonVisualTestViewController.h"
#import <PHData/PHData.h>

@interface IonVisualTestViewController () {
    IonSimpleCache *sc;
    IonTitleBar *titleBar;
    IonView *containerView;
    IonScrollView *scrollView;
}

@property (strong, nonatomic, readonly) IonGuideLine *scrollResponsiveLine;
@end

@implementation IonVisualTestViewController

@synthesize scrollResponsiveLine = _scrollResponsiveLine;

- (void) constructViews {
    [super constructViews];
    
    [self.view setBackgroundImageUsingKey: @"aspect"];

    
    [self constructTitleBar];
    [self constructContentView];
    [self constructContentBar];
    [self.view bringSubviewToFront: titleBar];
}

/**
 * Constructs the content view.
 */
- (void) constructContentView {
    scrollView = [[IonScrollView alloc] init];
    [scrollView setSuperGuidesWithHorz: self.view.originGuideHoriz
                               andVert: titleBar.sizeExternalGuideVert];
    [scrollView setSizeGuidesWithLeft: self.view.originGuideHoriz
                                right: self.view.sizeGuideHoriz
                                  top: titleBar.sizeExternalGuideVert
                            andBottom: self.view.sizeGuideVert];
    
    // Add the refresh action view
    IonScrollRefreshActionView *refreshView = [[IonScrollRefreshActionView alloc] init];
    refreshView.canAutomaticallyDisplay = FALSE;
    [scrollView addSubview: refreshView];
    
    
    
    // Test views
    UIView *tmpView, *previousView;
    
    [PHProfile registerFaceboxProfileImageNames];
    // Add some polyfill content
    for ( int i = 0; i < 15; ++i ) {
        previousView = tmpView;
        tmpView = [self polyFillPersonCellForId: i];
        
        if ( i != 0)
            [tmpView setSuperGuidesWithHorz: scrollView.leftAutoPadding
                                    andVert: previousView.bottomMargin];
        else
            [tmpView setSuperGuidesWithHorz: scrollView.leftAutoPadding
                                    andVert: scrollView.topAutoPadding];
        
        // Add Cell
        [scrollView addSubview: tmpView];
        previousView = tmpView;
        
        // Add Bar
        tmpView = [[IonView alloc] init];
        tmpView.themeClass = @"seperator";
        [tmpView setSizeGuidesWithLeft: [@3 toGuideLine]
                                 right: [IonGuideLine guideWithGuide: scrollView.sizeGuideHoriz
                                                             modType: IonValueModType_Subtract
                                                      andSecondGuide: [@3 toGuideLine]]
                                   top: [@0 toGuideLine]
                             andBottom: [@2 toGuideLine]];
        
        [tmpView setSuperGuidesWithHorz: [@3 toGuideLine]
                                andVert: previousView.bottomMargin];
        [scrollView addSubview: tmpView];
    }
    
    // Set the content size
    [scrollView setContentSizeHoriz: scrollView.sizeGuideHoriz  andVert: tmpView.bottomMargin];
   
    // Add Scroll View To Main View
    [self.view addSubview: scrollView];
    
    [self performBlock:^{
        UIEdgeInsets insets = scrollView.contentInset;
        insets.top = 45;
        scrollView.contentInset = insets;
    } afterDelay: 0.8];
}


- (IonView *)polyFillPersonCellForId:(NSUInteger) idn {
    PHProfile *profile;
    IonView *cell, *profileImage, *exposeHint;
    IonLabel *nameLabel;
    
    // Get a random profile
    profile = [PHProfile randomProfile];
    
    cell = [[IonView alloc] init];
    cell.themeElement = @"cell";
    
    // Profile image
    profileImage = [[IonView alloc] init ];
    profileImage.themeClass = @"profileImage";
    profileImage.frame = (CGRect){ CGPointZero, (CGSize){ 65, 65 }};
    [profileImage setBackgroundImage: [UIImage imageNamed: profile.profileImageName]];
    [profileImage setGuidesWithLocalHoriz: profileImage.originGuideHoriz
                                localVert: profileImage.centerGuideVert
                               superHoriz: cell.leftAutoPadding
                             andSuperVert: cell.centerGuideVert];
    [cell addSubview: profileImage];
    
    // Text
    nameLabel = [[IonLabel alloc] init];
    nameLabel.themeClass = @"nameLabel";
    nameLabel.text = profile.name;
    [nameLabel setSizeGuidesWithLeft: profileImage.rightMargin
                               right: cell.rightAutoPadding
                                 top: cell.topAutoPadding
                           andBottom: cell.bottomAutoPadding];
    [nameLabel setGuidesWithLocalHoriz: nameLabel.originGuideHoriz
                             localVert: nameLabel.centerGuideVert
                            superHoriz: profileImage.rightMargin
                          andSuperVert: cell.centerGuideVert];
    [cell addSubview: nameLabel];
    
    // Expose Hint
    exposeHint = [[IonView alloc] init];
    exposeHint.themeClass = @"exposeHint";
    [exposeHint setSizeGuidesWithLeft: [@0 toGuideLine]
                                right: [@3 toGuideLine]
                                  top: [@0 toGuideLine]
                            andBottom: [IonGuideLine guideWithGuide: cell.sizeGuideVert
                                                            modType: IonValueModType_Divide
                                                     andSecondGuide: [@3 toGuideLine]]];
    [exposeHint setGuidesWithLocalHoriz: exposeHint.sizeGuideHoriz
                              localVert: exposeHint.centerGuideVert
                             superHoriz: profileImage.leftMargin
                           andSuperVert: cell.centerGuideVert];
    [cell addSubview: exposeHint];
    
    // Size Cell
    [cell setSizeGuidesWithLeft: scrollView.leftAutoPadding
                          right: scrollView.rightAutoPadding
                            top: cell.originGuideVert
                      andBottom: [IonGuideLine guideWithGuide: profileImage.sizeGuideVert
                                                      modType: IonValueModType_Add
                                               andSecondGuide: [IonGuideLine guideWithGuide: cell.topAutoPadding
                                                                                    modType: IonValueModType_Multiply
                                                                             andSecondGuide: [@2 toGuideLine]]]];
    
    // Position should be handeled by the caller.
    return cell;
}


// Move To Ion Data Strings
- (NSString *)stringFromNumber:(NSUInteger) num countOfZeros:(NSUInteger) count {
    NSUInteger requiredZeros, digets;
    NSNumberFormatter *numFormatter;
    NSString *resultString;
    
    // Get required zeros
    digets = [self numberOfDigits: num];
    if ( digets > count )
        requiredZeros = 0;
    else
        requiredZeros = count - digets;
    
    // Prepend zeros
    resultString= @"";
    for ( NSUInteger i = 0; i < requiredZeros; ++i)
        resultString = [resultString stringByAppendingString:@"0"];
    
    // get formated numbet
    numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setFormatterBehavior: NSNumberFormatterBehaviorDefault];
    resultString = [resultString stringByAppendingString: [numFormatter stringFromNumber: [NSNumber numberWithUnsignedInteger: num]]];
    return resultString;
}


// Move to ion Data Math
- (NSUInteger) numberOfDigits:(NSUInteger) number {
    NSUInteger digits = 0;
    if ( number <= 0 ) digits = 1; // remove this line if '-' counts as a digit
    while (number) {
        number /= 10;
        digits++;
    }
    return digits;
}

#define Within( x, min, max )  ( (x) >= (max) ? ( (x) < (max) ? (x) : (max) ) : ( (x) > (min) ? (x) : (min) ) )


- (IonGuideLine *)scrollResponsiveLine {
    // A set of persistant states
    __block CGFloat lastOffset, currentDiferental, min, max;
    __block IonScrollView *iScrollView;
    
    if ( !_scrollResponsiveLine ) {
        currentDiferental = lastOffset = 0.0f;
        iScrollView = scrollView;
        min = -80;
        max = 0;
        _scrollResponsiveLine = [[IonGuideLine alloc] initWithTargetGuide: titleBar.sizeExternalGuideVert];
        [_scrollResponsiveLine addTargetGuide: scrollView.contentOffsetVert withName: @"contentOffset"];
        [_scrollResponsiveLine addTargetGuide: containerView.sizeGuideVert withName: @"itemHeight"];
        [_scrollResponsiveLine addTargetGuide: scrollView.sizeGuideVert withName: @"ScrollSize"];
        
        [_scrollResponsiveLine setCalcBlock: ^CGFloat( NSDictionary *targets ) {
            CGFloat offset, itemHeight;
            offset = [targets[@"contentOffset"] floatValue] * 0.2;
            itemHeight = [targets[@"itemHeight"] floatValue];
            min = itemHeight * -2.5;
            
            // Are we within our content offset?
            if ( Within(offset, 0.0f ,iScrollView.contentSize.height - iScrollView.frame.size.height ) == offset )
                currentDiferental = Within( currentDiferental + (lastOffset - offset), min, max );
            else if ( offset <= 0.0f )
                currentDiferental = 0.0f; // Reset to zero just incase.
            
            // Update State
            lastOffset = offset;
            return [targets[@"primary"] floatValue] + currentDiferental;
        }];
    }
    return _scrollResponsiveLine;
}

- (IonGuideLine *)interactive {
    return NULL;
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
//    IonInterfaceButton *button;
    
    containerView = [[IonView alloc] init];
    
    // Button
    // Button
    //    button = [[IonInterfaceButton alloc] initWithFileName: @"Hamburger"];
    //    [button setGuidesWithLocalHoriz: button.originGuideHoriz
    //                          localVert: button.centerGuideVert
    //                         superHoriz: containerView.leftPadding
    //                       andSuperVert: containerView.centerGuideVert];
    //    [containerView addSubview: button];
    
    // text input
    textInput = [[IonTextBar alloc] init];
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
                                  andVert: self.scrollResponsiveLine];
    
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