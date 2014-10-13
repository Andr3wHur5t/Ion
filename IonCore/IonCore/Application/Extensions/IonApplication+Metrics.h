//
//  IonApplication+Metrics.h
//  Ion
//
//  Created by Andrew Hurst on 8/29/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication.h"

/**
 * Records & Reports details about startup times.
 */
@interface IonApplication (Metrics)
#pragma mark Values
/** Ion Specific Values */
@property (assign, nonatomic) NSTimeInterval startupInitTime;
@property (assign, nonatomic) NSTimeInterval applicationLaunchBeginTime;
@property (assign, nonatomic) NSTimeInterval applicationLaunchEndTime;
@property (assign, nonatomic) NSTimeInterval splashDisplayCallbackTime;

/** Calculated Values*/
@property (assign, nonatomic, readonly) NSTimeInterval ionInitToSplashTime;
@property (assign, nonatomic, readonly) NSTimeInterval ionInitToLaunchTime;
@property (assign, nonatomic, readonly) NSTimeInterval ionLaunchFunctTime;
@property (assign, nonatomic, readonly) NSTimeInterval ionInitToSplashGenerationEnd;
@property (assign, nonatomic, readonly) NSTimeInterval ionLaunchToSplashDisplayTime;

#pragma mark Reporting
/**
 * Gets the current time.
 * @return {NSTimeInterval} the current time.
 */
+ (NSTimeInterval) currentTime;

/**
 * Marks startupInitTimeValue with the current time.
 */
- (void) markStartUpInit;

/**
 * Marks applicationLaunchBeginTime with the current time.
 */
- (void) markAppLaunchStart;

/**
 * Marks applicationLaunchEndTime with the current time.
 */
- (void) markAppLaunchEnd;

/**
 * Marks splashDisplayCallbackTime with the current time.
 */
- (void) markSplashDisplay;

#pragma mark Results
/**
 * Generates a dictionary of the collected startup metrics.
 * @return {NSDictionary*} the startup metrics.
 */
- (NSDictionary*) startupMetricsReport;

/**
 * Gets a startup metrics pritty report screen.
 * @return {NSString*}
 */
- (NSString*) startupMetricsReportString;

/**
 * Writes the startup metrics report to the console.
 */
- (void) logStartupMetrics;

@end
