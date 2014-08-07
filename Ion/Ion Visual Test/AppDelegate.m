//
//  AppDelegate.m
//  Ion Visual Test
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "AppDelegate.h"

#import "IonVisualTestViewController.h"

@interface AppDelegate ()
            

@end

@implementation AppDelegate

#pragma mark Init Hooks

/**
 * This is where we initilize all non visual elements of our application.
 * @returns {void}
 */
- (void) setupApplication {
    NSLog(@"externial application startup called");
}


#pragma mark Controller Init

/**
 * This configures the first real view controller.
 * @peram { ^(UIViewController* frvc) } frvc is the "First Real View Conroller" to be presented.
 * @returns {void}
 */
- (void) configureFirstRealViewController:(void(^)( IonViewController* frvc )) finished {
    // configure the default first root view controller here.
    IonVisualTestViewController* vc = [[IonVisualTestViewController alloc] init];
    

    
    //sc.manifestWillPersist = FALSE;
    //[sc deleteWithCompletion:^(NSError *error) {
    //    NSLog(@"Deleted Cache!");
    //}];
    
    //[self asyncABGMapTest];
    
    /**
     * This is to debug the theme system.
     */
    //[self runThemeTests];
   
    // Test transisions between themes
    //[self testTransision: NULL];
    
    if (finished)
        finished(vc);
}

/**
 * Tests file IO.
 */
- (void) testFileIO {
    
}

/**
 * This runs all of our theme tests, Note Should move these to unit tests.
 */
- (void) runThemeTests {
    [self overviewThemeTest];
}

/**
 * This reads out the metrics, and the results of diffrent attributes.
 */
- (void) overviewThemeTest {
    NSString* logString = @"\nTheme Test:";
    UIColor                                 *resultColor;
    IonKeyValuePair                         *resultKVP;
    IonImageRef                             *resultImageRef;
    IonStyle                                *resultStyle;
    IonGradientConfiguration                *resultGradient;
    // Metrics
    double  colorStart, colorEnd,
            kvpStart, kvpEnd,
            imageStart, imageEnd,
            styleStart, styleEnd,
            gradientStart, gradientEnd;
    // Test
    colorStart = [[NSDate date] timeIntervalSince1970];
    resultColor = [self.window.systemTheme resolveColorAttribute:@"yellow"];
    colorEnd = [[NSDate date] timeIntervalSince1970];
    
    kvpStart = [[NSDate date] timeIntervalSince1970];
    resultKVP = [self.window.systemTheme resolveKVPAttribute:@"PointlessProperty"];
    kvpEnd = [[NSDate date] timeIntervalSince1970];
    
    imageStart = [[NSDate date] timeIntervalSince1970];
    resultImageRef = [self.window.systemTheme resolveImageAttribute:@"Image1"];
    imageEnd = [[NSDate date] timeIntervalSince1970];
    
    styleStart = [[NSDate date] timeIntervalSince1970];
    resultStyle = [self.window.systemTheme resolveStyleAttribute:@"cls_simpleStyle"];
    styleEnd = [[NSDate date] timeIntervalSince1970];
    
    gradientStart = [[NSDate date] timeIntervalSince1970];
    resultGradient = [self.window.systemTheme resolveGradientAttribute:@"Royal"];
    gradientEnd = [[NSDate date] timeIntervalSince1970];
    
    // Reporting
    logString = [logString stringByAppendingString:@"\nColor: %@ \nTook: %.4f ms\n"];
    logString = [logString stringByAppendingString:@"\nKVP: \"%@\" \nTook: %.4f ms\n"];
    logString = [logString stringByAppendingString:@"\nImage Ref: \"%@\" \nTook: %.4f ms\n"];
    logString = [logString stringByAppendingString:@"\nStyle: %@ \nTook: %.4f ms\n"];
    logString = [logString stringByAppendingString:@"\nGradient: %@Took: %.4f ms \n\n"];
    
    logString = [NSString stringWithFormat:logString,
                 [resultColor toHex], (colorEnd - colorStart) * 1000,
                 resultKVP, (kvpEnd - kvpStart) * 1000,
                 resultImageRef,  (imageEnd - imageStart) * 1000,
                 resultStyle, (styleEnd - styleStart) * 1000,
                 resultGradient, (gradientEnd - gradientStart) * 1000];
    
    NSLog(@"%@", logString);
}

/**
 * This is the transision Test
 */
- (void) testTransision:(IonTheme*) theme {
    if ( !theme ) {
        IonTheme* newtheme = [[IonTheme alloc] initWithFileName:@"TestStyle"];
        if ( !newtheme )
            return;
        // Execute after delay to show diffrence
        [self performSelector:@selector(testTransision:) withObject:newtheme afterDelay:1.5];
        return;
    }
    
    self.window.systemTheme = theme;
}

/**
 * This is the rapid splash view that will be used when the application has already been opened in the system once before.
 * *subclassed for customization*
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController*) rapidSplash {
    IonRapidStartViewController* vc = [[IonRapidStartViewController alloc] init];
    
    vc.view.backgroundColor = [UIColor magentaColor];
    
    return vc;
}

/**
 * This is the rapid splash view that will be used when the application has not been opened in the system once before.
 * You should return a on boarding controller here.
 * *subclassed for customization*
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController*) onBoardingRapidSplash {
    IonRapidStartViewController* vc = [[IonRapidStartViewController alloc] init];
    
    vc.view.backgroundColor = [UIColor yellowColor];
    
    return vc;
}


#pragma mark Configuration

/**
 * We set our propriatary manifest here
 * @returns {managerManifest}
 */
- (bool) loadManagerManifest {
    NSLog(@"Load Manifest called");
    return true;
}


/**
 * This gets the on boarding screen version string.
 * @returns {NSString*}
 */
- (NSString*) currentOnBoardingScreenVersion {
    return NULL;
}

/**
 * This states if we use the demo window which displays touch points or not.
 * @returns {bool}
 */
- (bool) isInDemoMode {
    return false;
}



@end
