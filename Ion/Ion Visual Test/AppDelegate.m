//
//  AppDelegate.m
//  Ion Visual Test
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "AppDelegate.h"

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
    IonViewController* vc = [[IonViewController alloc] initWithNibName:NULL bundle:NULL];
    
    vc.view.backgroundColor = [UIColor greenColor];
    
    
    
    // Render Debug
    UIImageView* imgView = [[UIImageView alloc] init];
    [vc.view addSubview:imgView];
    
    CGSize s = vc.view.frame.size;
    s.height = 20 + 70;
    imgView.frame = (CGRect) {CGPointZero,s};
    
    
    [imgView.layer setShadowColor:[UIColor blackColor].CGColor];
    [imgView.layer setShadowOpacity:0.5];
    [imgView.layer setShadowRadius:3.0];
    [imgView.layer setShadowOffset:CGSizeMake(0.0, 2.0)];
    
    
    // Theme Testing
    imgView.themeClass = @"secondaryStyle";
    //imgView.themeID = @"simpleStyle";
    
    vc.view.themeElementName = @"body";
    vc.view.themeClass = @"simpleStyle";
    //vc.view.themeID = @"background";
    
    /**
     * Note do this in Ion View controller and document for propriatary view controllers.
     */
    [vc.view setIonInternialSystemTheme:self.window.systemTheme];
    
    
    [self runThemeTests];
   
    
    if (finished)
        finished(vc);
}

- (void) runThemeTests {
    [self overviewThemeTest];
    [self bulkColorTest];
}

- (void) overviewThemeTest {
    NSString* logString = @"\n\nTheme Test:\n";
    
    logString = [logString stringByAppendingString:@"\nColor: %@"];
    logString = [logString stringByAppendingString:@"\nKVP: \"%@\""];
    logString = [logString stringByAppendingString:@"\nImage Ref: \"%@\""];
    logString = [logString stringByAppendingString:@"\nStyle: %@"];
    logString = [logString stringByAppendingString:@"\nGradient: %@\n"];
    
    logString = [NSString stringWithFormat:logString,
                 [self.window.systemTheme.attributes resolveColorAttrubute:@"yellow"],
                 [self.window.systemTheme.attributes resolveKVPAttribute:@"PointlessProperty"],
                 [self.window.systemTheme.attributes resolveImageAttribute:@"Image1"],
                 [self.window.systemTheme.attributes resolveStyleAttribute:@"cls_simpleStyle"],
                 [self.window.systemTheme.attributes resolveGradientAttribute:@"Royal"]];
    
    NSLog(@"%@", logString);
}

- (void) bulkColorTest {
    NSString* targetColorKey = @"yellow";
    double startTime, endTime, acumulatedTime;
    NSInteger count, failures;
    UIColor *expectedColor, *resultColor;
    
    // Setup
    expectedColor = [self.window.systemTheme.attributes resolveColorAttrubute: targetColorKey];
    acumulatedTime = 0.0f;
    failures = 0;
    count = 5000;
    
    
    // Test
    for (NSInteger i = 0; i <= count; ++i) {
        startTime =  [[NSDate date] timeIntervalSince1970];
        
        resultColor = [self.window.systemTheme.attributes resolveColorAttrubute: targetColorKey];
        
        endTime =  [[NSDate date] timeIntervalSince1970];
        
        if( ![resultColor isEqual: expectedColor] )
            ++failures;
        
        
        
        acumulatedTime += endTime - startTime;
        
        endTime = 0;
        startTime = 0;
        resultColor = NULL;
    }
    
    // Report
     NSLog(@"\nResult Avrage Time: %.4f ms, Failures %i out of %i calls\n\n", (acumulatedTime / count) * 1000, failures, count );
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
