//
//  IonApplication+Metrics.m
//  Ion
//
//  Created by Andrew Hurst on 8/29/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication+Metrics.h"

/**
 * Keys for our variables.
 */
static NSString* sIonApplication_Metrics_StartupInitTime = @"Metrics_StartupInitTime";
static NSString* sIonApplication_Metrics_ApplicationLaunchBeginTime = @"Metrics_ApplicationLaunchBeginTime";
static NSString* sIonApplication_Metrics_ApplicationLaunchEndTime = @"Metrics_ApplicationLaunchEndTime";
static NSString* sIonApplication_Metrics_SplashDisplayCallbackTime = @"Metrics_SplashDisplayCallbackTime";

@implementation IonApplication (Metrics)
#pragma mark Reporting
/**
 * Gets the current time.
 * @returns {NSTimeInterval} the current time.
 */
+ (NSTimeInterval) currentTime {
    return [NSDate timeIntervalSinceReferenceDate];
}

/**
 * Marks startupInitTimeValue with the current time.
 */
- (void) markStartUpInit {
    self.startupInitTime = [[self class] currentTime];
}

/**
 * Marks applicationLaunchBeginTime with the current time.
 */
- (void) markAppLaunchStart {
    self.applicationLaunchBeginTime = [[self class] currentTime];
}

/**
 * Marks applicationLaunchEndTime with the current time.
 */
- (void) markAppLaunchEnd {
    self.applicationLaunchEndTime = [[self class] currentTime];
}

/**
 * Marks splashDisplayCallbackTime with the current time.
 */
- (void) markSplashDisplay {
    self.splashDisplayCallbackTime = [[self class] currentTime];
}

#pragma mark Calculated Reporting
/**
 * Gets our init to splash time.
 * @returns {NSTimeInterval}
 */
- (NSTimeInterval) ionInitToSplashTime {
    return self.splashDisplayCallbackTime - self.startupInitTime;
}

/**
 * Gets our application init to launch time.
 * @returns {IonInitToSplashTime}
 */
- (NSTimeInterval) ionInitToLaunchTime {
    return self.applicationLaunchBeginTime - self.startupInitTime;
}

/**
 * Gets our application launch function time.
 * @returns {IonInitToSplashTime}
 */
- (NSTimeInterval) ionLaunchFunctTime {
    return self.applicationLaunchEndTime - self.applicationLaunchBeginTime;
}

/**
 * Gets our applications' init to splash generation completion.
 * @returns {IonInitToSplashTime}
 */
- (NSTimeInterval) ionInitToSplashGenerationEnd {
    return self.applicationLaunchEndTime - self.startupInitTime;
}

/**
 * Gets our launch to display time.
 * @returns {NSTimeInterval}
 */
- (NSTimeInterval) ionLaunchToSplashDisplayTime {
    return self.splashDisplayCallbackTime - self.applicationLaunchEndTime;
}

#pragma mark Report Generation
/**
 * Generates a dictionary of the collected startup metrics.
 * @returns {NSDictionary*} the startup metrics.
 */
- (NSDictionary*) startupMetricsReport {
    return @{};
}

/**
 * Gets a startup metrics pritty report screen.
 * @returns {NSString*}
 */
- (NSString*) startupMetricsReportString {
    NSString* report;
    
    // Generate the report
    report = [@"" stringByAppendingString:      @"Time from init to launch: %.2 ms (Shared with OS)\n"];
    report = [report stringByAppendingString:   @"Time spent launching: %.2f ms\n"];
    report = [report stringByAppendingString:   @"Time generating rapid splash: %.2f ms\n"];
    report = [report stringByAppendingString:   @"Time To first rapid splash render: %.2f ms\n"];
    
    // Fill out the report
    report = [NSString stringWithFormat: report,
              SecondsToMilliseconds( self.ionInitToLaunchTime ),
              SecondsToMilliseconds( self.ionLaunchFunctTime ),
              SecondsToMilliseconds( self.ionInitToSplashGenerationEnd ),
              SecondsToMilliseconds( self.ionLaunchToSplashDisplayTime )];
    
    // Send the report
    return report;
}

/**
 * Writes the startup metrics report to the console.
 */
- (void) logStartupMetrics {
    NSLog( @"%@", [self startupMetricsReportString] );
}

/** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                              Value Setters & Getters
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

#pragma mark StartupInitTime
/**
 * Switches startupInitTimes' KVO mode to manual.
 */
+ (BOOL) automaticallyNotifiesObserversOfStartupInitTime { return FALSE; }

/**
 * Sets the startup init time.
 * @param {NSTimeInterval} the new time.
 */
- (void) setStartupInitTime:(NSTimeInterval) startupInitTime {
    [self willChangeValueForKey: @"startupInitTime"];
    [self.catagoryVariables setObject: [NSNumber numberWithDouble: startupInitTime]
                               forKey: sIonApplication_Metrics_StartupInitTime];
    [self didChangeValueForKey: @"startupInitTime"];
}

/**
 * Gets the current value for startup init time.
 * @returns {NSTimeInterval} the value, or 0 if not set.
 */
- (NSTimeInterval) startupInitTime {
    return [[self.catagoryVariables numberForKey: sIonApplication_Metrics_StartupInitTime] doubleValue];
}

#pragma mark ApplicationLaunchBeginTime
/**
 * Switches ApplicationLaunchBeginTimes' KVO mode to manual.
 */
+ (BOOL) automaticallyNotifiesObserversOfApplicationLaunchBeginTime { return FALSE; }

/**
 * Sets the Application Launch Begin time.
 * @param {NSTimeInterval} the new time.
 */
- (void) setApplicationLaunchBeginTime:(NSTimeInterval) applicationLaunchBeginTime {
    [self willChangeValueForKey: @"applicationLaunchBeginTime"];
    [self.catagoryVariables setObject: [NSNumber numberWithDouble: applicationLaunchBeginTime]
                               forKey: sIonApplication_Metrics_ApplicationLaunchBeginTime];
    [self didChangeValueForKey: @"applicationLaunchBeginTime"];
}

/**
 * Gets the current value for startup init time.
 * @returns {NSTimeInterval} the value, or 0 if not set.
 */
- (NSTimeInterval) applicationLaunchBeginTime {
    return [[self.catagoryVariables numberForKey: sIonApplication_Metrics_ApplicationLaunchBeginTime] doubleValue];
}

#pragma mark ApplicationLaunchEndTime
/**
 * Switches ApplicationLaunchBeginTimes' KVO mode to manual.
 */
+ (BOOL) automaticallyNotifiesObserversOfApplicationLaunchEndTime { return FALSE; }

/**
 * Sets the Application Launch Begin time.
 * @param {NSTimeInterval} the new time.
 */
- (void) setApplicationLaunchEndTime:(NSTimeInterval) applicationLaunchEndTime {
    [self willChangeValueForKey: @"applicationLaunchEndTime"];
    [self.catagoryVariables setObject: [NSNumber numberWithDouble: applicationLaunchEndTime]
                               forKey: sIonApplication_Metrics_ApplicationLaunchEndTime];
    [self didChangeValueForKey: @"applicationLaunchEndTime"];
}

/**
 * Gets the current value for startup init time.
 * @returns {NSTimeInterval} the value, or 0 if not set.
 */
- (NSTimeInterval) applicationLaunchEndTime {
    return [[self.catagoryVariables numberForKey: sIonApplication_Metrics_ApplicationLaunchEndTime] doubleValue];
}

#pragma mark ApplicationLaunchEndTime
/**
 * Switches ApplicationLaunchBeginTimes' KVO mode to manual.
 */
+ (BOOL) automaticallyNotifiesObserversOfSplashDisplayCallbackTime { return FALSE; }

/**
 * Sets the Application Launch Begin time.
 * @param {NSTimeInterval} the new time.
 */
- (void) setSplashDisplayCallbackTime:(NSTimeInterval) splashDisplayCallbackTime {
    [self willChangeValueForKey: @"splashDisplayCallbackTime"];
    [self.catagoryVariables setObject: [NSNumber numberWithDouble: splashDisplayCallbackTime]
                               forKey: sIonApplication_Metrics_SplashDisplayCallbackTime];
    [self didChangeValueForKey: @"splashDisplayCallbackTime"];
}

/**
 * Gets the current value for startup init time.
 * @returns {NSTimeInterval} the value, or 0 if not set.
 */
- (NSTimeInterval) splashDisplayCallbackTime {
    return [[self.catagoryVariables numberForKey: sIonApplication_Metrics_SplashDisplayCallbackTime] doubleValue];
}

@end
