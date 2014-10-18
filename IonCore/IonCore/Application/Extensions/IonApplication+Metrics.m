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
 * @return {NSTimeInterval} the current time.
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
 * @return {NSTimeInterval}
 */
- (NSTimeInterval) ionInitToSplashTime {
    return self.splashDisplayCallbackTime - self.startupInitTime;
}

/**
 * Gets our application init to launch time.
 * @return {IonInitToSplashTime}
 */
- (NSTimeInterval) ionInitToLaunchTime {
    return self.applicationLaunchBeginTime - self.startupInitTime;
}

/**
 * Gets our application launch function time.
 * @return {IonInitToSplashTime}
 */
- (NSTimeInterval) ionLaunchFunctTime {
    return self.applicationLaunchEndTime - self.applicationLaunchBeginTime;
}

/**
 * Gets our applications' init to splash generation completion.
 * @return {IonInitToSplashTime}
 */
- (NSTimeInterval) ionInitToSplashGenerationEnd {
    return self.applicationLaunchEndTime - self.startupInitTime;
}

/**
 * Gets our launch to display time.
 * @return {NSTimeInterval}
 */
- (NSTimeInterval) ionLaunchToSplashDisplayTime {
    return self.splashDisplayCallbackTime - self.applicationLaunchEndTime;
}

#pragma mark Report Generation
/**
 * Generates a dictionary of the collected startup metrics.
 * @return {NSDictionary*} the raw startup metrics.
 */
- (NSDictionary*) startupMetricsReport {
    return @{};
}

/**
 * Gets a startup metrics pritty report screen.
 * @return {NSString*}
 */
- (NSString*) startupMetricsReportString {
    NSString* report;
    
    // Generate the report
    report = [@"\n" stringByAppendingString:      @"Time from init to launch: %.2f ms (Shared with OS)\n"];
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

+ (BOOL) automaticallyNotifiesObserversOfStartupInitTime { return FALSE; }

- (void) setStartupInitTime:(NSTimeInterval) startupInitTime {
    [self willChangeValueForKey: @"startupInitTime"];
    [self.categoryVariables setObject: [NSNumber numberWithDouble: startupInitTime]
                               forKey: sIonApplication_Metrics_StartupInitTime];
    [self didChangeValueForKey: @"startupInitTime"];
}

- (NSTimeInterval) startupInitTime {
    return [[self.categoryVariables numberForKey: sIonApplication_Metrics_StartupInitTime] doubleValue];
}

#pragma mark ApplicationLaunchBeginTime

+ (BOOL) automaticallyNotifiesObserversOfApplicationLaunchBeginTime { return FALSE; }

- (void) setApplicationLaunchBeginTime:(NSTimeInterval) applicationLaunchBeginTime {
    [self willChangeValueForKey: @"applicationLaunchBeginTime"];
    [self.categoryVariables setObject: [NSNumber numberWithDouble: applicationLaunchBeginTime]
                               forKey: sIonApplication_Metrics_ApplicationLaunchBeginTime];
    [self didChangeValueForKey: @"applicationLaunchBeginTime"];
}

- (NSTimeInterval) applicationLaunchBeginTime {
    return [[self.categoryVariables numberForKey: sIonApplication_Metrics_ApplicationLaunchBeginTime] doubleValue];
}

#pragma mark ApplicationLaunchEndTime

+ (BOOL) automaticallyNotifiesObserversOfApplicationLaunchEndTime { return FALSE; }

- (void) setApplicationLaunchEndTime:(NSTimeInterval) applicationLaunchEndTime {
    [self willChangeValueForKey: @"applicationLaunchEndTime"];
    [self.categoryVariables setObject: [NSNumber numberWithDouble: applicationLaunchEndTime]
                               forKey: sIonApplication_Metrics_ApplicationLaunchEndTime];
    [self didChangeValueForKey: @"applicationLaunchEndTime"];
}

- (NSTimeInterval) applicationLaunchEndTime {
    return [[self.categoryVariables numberForKey: sIonApplication_Metrics_ApplicationLaunchEndTime] doubleValue];
}

#pragma mark ApplicationLaunchEndTime
+ (BOOL) automaticallyNotifiesObserversOfSplashDisplayCallbackTime { return FALSE; }

- (void) setSplashDisplayCallbackTime:(NSTimeInterval) splashDisplayCallbackTime {
    [self willChangeValueForKey: @"splashDisplayCallbackTime"];
    [self.categoryVariables setObject: [NSNumber numberWithDouble: splashDisplayCallbackTime]
                               forKey: sIonApplication_Metrics_SplashDisplayCallbackTime];
    [self didChangeValueForKey: @"splashDisplayCallbackTime"];
}

- (NSTimeInterval) splashDisplayCallbackTime {
    return [[self.categoryVariables numberForKey: sIonApplication_Metrics_SplashDisplayCallbackTime] doubleValue];
}

@end
