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
- (instancetype) initWithPath:(IonPath*) rootPath appendedByElements:(NSArray*) pathElements;

/**
 * Constructs a path matching the inputted path.
 * @param {IonPath*} the construct from.
 * @returns {IonPath*} the resulting path
 */
+ (IonPath*) pathFromPath:(IonPath*) path;

/**
 * Constructs a path from the specified url.
 * @param {NSURL*} the url to construct from.
 * @returns {instancetype}
 */
+ (IonPath*) pathFromURL:(NSURL*) url;

/**
 * Constructs a path in the temporary directory.
 */
+ (IonPath*) documentsDirectory ;
/**
 * Constructs a path in the temporary directory.
 */
+ (IonPath*) cacheDirectory;


#pragma mark Utilities

/**
 * Gets the current items name.
 * @returns {NSString*} the string of the current item, or NULL if invalid.
 */
- (NSString*) itemName;

/**
 * Gets the current path with the additional path element.
 * @param {NSString*} the additional path component.
 * @returns {IonPath*}
 */
- (IonPath*) pathAppendedByElement: (NSString*) component;

/**
 * Gets the current path with the additional path elements.
 * @param {NSArray*} the additional path component.
 * @returns {IonPath*}
 */
- (IonPath*) pathAppendedByElements: (NSArray*) components;

/**
 * Gets the parent path.
 * @retruns {IonPath*} a copy instance of the parent path.
 */
- (IonPath*) parentPath;

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
 * @returns {NSArray*} array of components, or NULL if invalid.
 */
+ (NSArray*) componentsFromURL:(NSURL*) url;

/**
 * Gets path components from an delimited string
 * @param {NSString} the string to get the components from.
 * @returns {NSArray*} array of components, or NULL if invalid.
 */
+ (NSArray*) componentsFromString:(NSString*) string;

/**
 * Normalize component strings to work with the file system.
 * @param {NSArray*} the components to normilize.
 * @returns {NSArray*} the normilizes array.
 */
+ (NSArray*) normalizeComponents:(NSArray*) components;

/**
 * Converts an array of components into a string.
 * @param {NSArray*} the components to generate from.
 * @param {BOOL} states if the path is relative or not.
 * @returns {NSString} the path.
 */
+ (NSString*) stringFromComponents:(NSArray*) components isRelative:(BOOL) isRelative;

/**
 * Converts to a string representation of the path.
 * @returns {NSString*}
 */
- (NSString*) toString;

@end
