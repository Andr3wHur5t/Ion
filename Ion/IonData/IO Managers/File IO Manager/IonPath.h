//
//  IonPath.h
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IonPath : NSObject
#pragma mark Constructors
/**
 * Creates a path object from the inputted components.
 * @param {NSArray*} the Base Components.
 * @returns {instancetype}
 */
- (instancetype) initFromComponents:(NSArray*) components;

/**
 * Creates a path object from the inputted NSURL.
 * @param {NSURL*} the url to base the path off of.
 * @returns {instancetype}
 */
- (instancetype) initFromURL:(NSURL*) url;

/**
 * Creates a copy path from the inputted path.
 * @param {IonPath*} the path to be derived from.
 * @returns {instancetype}
 */
- (instancetype) initFromPath:(IonPath*) path;

/**
 * Creates a path with the inputed path appended by the array of items;
 * @param {IonPath*} the path to append from
 * @param {NSArray*} the additional elements to append.
 * @returns {instancetype}
 */
- (instancetype) initPath:(IonPath*) rootPath appendedByElements:(NSArray*) pathElements;

#pragma mark Properties

/**
 * Components of the path.
 */
@property (strong, nonatomic, readonly) NSArray* components;

#pragma mark Management

/**
 * Appends current path with the additional hierarchy.
 * @param {NSArray*} the additional hierarchy.
 * @returns {void}
 */
- (void) appendHierarchy:(NSArray*) additional;


#pragma mark conversions

/**
 * Gets path components from an NSURL
 * @param {NSURL} the url to get the components from.
 * @returns {NSArray*} and array of components
 */
+ (NSArray*) pathComponentsFromURL:(NSURL*) url;

/**
 * Converts to a string representation of the path.
 * @returns {NSString*}
 */
- (NSString*) toString;

@end
