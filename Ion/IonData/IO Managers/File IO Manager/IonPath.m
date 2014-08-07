//
//  IonPath.m
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonPath.h"

#define BackDirectoryKey @".."
#define DirectoryDelemiter @"/"
#define CurrentDirectoryKey @"."
#define InvalidCharReplacementString @"-"

@implementation IonPath


#pragma mark Constructors

/**
 * The standard constructor.
 * @retutns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self )
        _components = [NSArray array];
    return self;
}

/**
 * Creates a path object from the inputted components.
 * @param {NSArray*} the Base Components.
 * @returns {instancetype}
 */
- (instancetype) initFromComponents:(NSArray*) components {
    if ( !components )
        return NULL;
    self = [self init];
    if ( self ) {
        [self setComponentsArray: [IonPath normalizeComponents: components]];
    }
    
    return self;
}

/**
 * Creates a path object from the inputted NSURL.
 * @param {NSURL*} the url to base the path off of.
 * @returns {instancetype} or NULL if invalid
 */
- (instancetype) initFromURL:(NSURL*) url {
    return [self initFromComponents: [IonPath componentsFromURL: url]];
}

/**
 * Creates a copy path from the inputted path.
 * @param {IonPath*} the path to be derived from.
 * @returns {instancetype} or NULL if invalid
 */
- (instancetype) initFromPath:(IonPath*) path {
    return [self initFromComponents: path.components];
}

/**
 * Creates a path with the inputed path appended by the array of items;
 * @param {IonPath*} the path to append from
 * @param {NSArray*} the additional elements to append.
 * @returns {instancetype} or NULL if invalid
 */
- (instancetype) initWithPath:(IonPath*) rootPath appendedByElements:(NSArray*) pathElements {
    if ( !pathElements )
        return NULL;
    self = [self initFromPath: rootPath];
    if ( self )
        [self appendHierarchy: pathElements];
    return self;
}

/**
 * Constructs a path matching the inputted path.
 * @param {IonPath*} the construct from.
 * @returns {IonPath*} the resulting path
 */
+ (IonPath*) pathFromPath:(IonPath*) path  {
    IonPath* newPath;
    if ( !path || ![path isKindOfClass: [IonPath class]] )
        return NULL;
    
    newPath = [[IonPath alloc] initFromPath: path];
    
    return newPath;
}

/**
 * Constructs a path from the specified url.
 * @param {NSURL*} the url to construct from.
 * @returns {instancetype}
 */
+ (IonPath*) pathFromURL:(NSURL*) url {
    return [[IonPath alloc] initFromURL: url];
}

/**
 * Constructs a path in the temporary directory.
 */
+ (IonPath*) documentsDirectory {
    return [IonPath pathFromURL: [IonPath urlForDirectory: NSDocumentDirectory]];
}

/**
 * Constructs a path in the temporary directory.
 */
+ (IonPath*) cacheDirectory {
    return [IonPath pathFromURL: [IonPath urlForDirectory: NSCachesDirectory]];
}

#pragma mark Utilities

/**
 * Gets the current items name.
 * @returns {NSString*} the string of the current item, or NULL if invalid.
 */
- (NSString*) itemName {
    NSString* item;
    item = [_components lastObject];
    if ( ![item isKindOfClass: [NSString class]] )
        return NULL;
    
    return item;
}

/**
 * Gets the current path with the additional path component.
 * @param {NSString*} the additional path component.
 * @returns {IonPath*}
 */
- (IonPath*) pathAppendedByElement:(NSString*) component {
    return [self pathAppendedByElements: @[ component ]];
}

/**
 * Gets the current path with the additional path components.
 * @param {NSArray*} the additional path component.
 * @returns {IonPath*}
 */
- (IonPath*) pathAppendedByElements:(NSArray*) components {
    IonPath* newPath;
    if ( !components || ![components isKindOfClass: [NSArray class]] )
        return NULL;
    
    newPath = [IonPath pathFromPath: self];
    [newPath appendHierarchy: components];
    
    return newPath;
}

/**
 * Gets the parent path.
 * @retruns {IonPath*} a copy instance of the parent path.
 */
- (IonPath*) parentPath {
    return [self pathAppendedByElement: BackDirectoryKey];
}
#pragma mark Management

/**
 * Appends current path with the additional hierarchy.
 * @param {NSArray*} the additional hierarchy.
 * @returns {void}
 */
- (void) appendHierarchy:(NSArray*) additional {
    if ( !additional )
        return;
    [self setComponentsArray: [IonPath normalizeComponents:
                               [self.components arrayByAddingObjectsFromArray: additional]]];
}

/**
 * Sets the components array.
 * @param {NSArray*} the new components array to make a copy of.
 * @returns {void}
 */
- (void) setComponentsArray:(NSArray *)components {
    _components = [[NSArray alloc] initWithArray: components];
}


#pragma mark conversions

/**
 * Sets our components to match a URL.
 * @returns {void}
 */
- (void) setComponentsFromURL:(NSURL*) url {
    [self setComponentsArray: [IonPath normalizeComponents: [IonPath pathComponentsFromURL: url]]];
}

/**
 * Gets path components from an NSURL
 * @param {NSURL} the url to get the components from.
 * @returns {NSArray*} and array of components, or NULL if invalid
 */
+ (NSArray*) pathComponentsFromURL:(NSURL*) url {
    NSString* intermediate;
    NSArray *components ;
    if ( !url )
        return NULL;
    
    intermediate = [url.path substringWithRange: NSMakeRange ( 1, url.path.length - 1 )];
    if ( !intermediate || ![intermediate isKindOfClass: [NSString class]] )
        return NULL;
    
    components = [intermediate componentsSeparatedByString: DirectoryDelemiter];
    if ( ![components isKindOfClass: [NSArray class]] )
        return NULL;
    return components;
}

/**
 * Normalize component strings to work with the file system.
 * @param {NSArray*} the components to normalize.
 * @returns {NSArray*} the normalizes array.
 */
+ (NSArray*) normalizeComponents:(NSArray*) components {
    NSString* component;
    NSMutableArray* currentComponents;
    NSRegularExpression* normalizationExpresion;
    NSMutableIndexSet* indexesToRemove;
    
    // Set
    indexesToRemove =  [[NSMutableIndexSet alloc] init];
    normalizationExpresion = [NSRegularExpression regularExpressionWithPattern: @"[:/]+"
                                                                       options: 0
                                                                         error: nil];
    currentComponents = [[NSMutableArray alloc] initWithArray: components];
    
    // Go through all items
    for ( NSInteger i = [currentComponents count] - 1; i > 0; --i ) {
        component = [currentComponents objectAtIndex: i];
        
        // Check if it is a valid type
        if ( !component || ![component isKindOfClass: [NSString class]] ) {
            [indexesToRemove addIndex: i];
        }
        else {
            // Tag symbols and empty items so we can remove them
            if ( [component isEqualToString: CurrentDirectoryKey] || [component isEqualToString: @""] ) {
                [indexesToRemove addIndex: i];
            } else if ( [component isEqualToString: BackDirectoryKey] ) {
                [indexesToRemove addIndex: i];
                [indexesToRemove addIndex: i - 1];
            }
            // Filter out any control characters
            component = [normalizationExpresion stringByReplacingMatchesInString: component
                                                                         options: 0
                                                                           range: NSMakeRange(0, component.length)
                                                                    withTemplate: InvalidCharReplacementString];
            // Set the filtered object
            [currentComponents setObject: component atIndexedSubscript: i];
        }
    }
    
    // Remove Taged components
    [currentComponents removeObjectsAtIndexes: indexesToRemove];
    
    // Return Results
    return [NSArray arrayWithArray:currentComponents] ;
}

/**
 * Converts to a string representation of the path.
 * @returns {NSString*}
 */
- (NSString*) toString {
    return [IonPath stringFromComponents: self.components isRelative: FALSE];
}

#pragma mark Utilities

/**
 * Converts an array of components into a string.
 * @param {NSArray*} the components to generate from.
 * @param {BOOL} states if the path is relative or not.
 * @returns {NSString} the path.
 */
+ (NSString*) stringFromComponents:(NSArray*) components isRelative:(BOOL) isRelative {
    NSString *resultingPath;
    NSArray *normalizedComponents;
    BOOL isFirstItem;
    
    resultingPath = isRelative ? @"" : DirectoryDelemiter;
    // Check if we have valid components
    if ( !components || ![components isKindOfClass: [NSArray class]])
        return resultingPath;
    else if ( components.count == 0)
        return resultingPath;
    
    // Normalize Components
    normalizedComponents = [IonPath normalizeComponents: components];
    
    
    // Compile Components
    isFirstItem = TRUE;
    for ( NSString* component in normalizedComponents ) {
        resultingPath = [resultingPath stringByAppendingFormat:@"%@%@", isFirstItem ? @"" : DirectoryDelemiter, component];
        isFirstItem = FALSE;
    }
    
    return resultingPath;
}

/**
 * Gets path components from an NSURL
 * @param {NSURL} the url to get the components from.
 * @returns {NSArray*} array of components, or NULL if invalid.
 */
+ (NSArray*) componentsFromURL:(NSURL*) url {
    if ( !url || ![url isKindOfClass: [NSURL class]] )
        return NULL;
    return [IonPath componentsFromString: url.path];
}

/**
 * Gets path components from an delimited string
 * @param {NSString} the string to get the components from.
 * @returns {NSArray*} array of components, or NULL if invalid.
 */
+ (NSArray*) componentsFromString:(NSString*) string {
    NSString* intermediate;
    NSArray *components;
    if ( !string || ![string isKindOfClass: [NSString class]] )
        return NULL;
    
    intermediate = string;
    if ( [string characterAtIndex: 0] == '/' )
        intermediate = [intermediate stringByReplacingCharactersInRange: NSMakeRange( 0, 1 ) withString: @""];
    
    intermediate = [intermediate substringWithRange: NSMakeRange( 0, intermediate.length  )];
    if ( !intermediate )
        return NULL;
    
    components = [intermediate componentsSeparatedByString: DirectoryDelemiter];
    if ( ![components isKindOfClass: [NSArray class]] )
        return NULL;
    
    return components;
}

#pragma mark Debug Description

/**
 * The Debug description.
 * @retuns {NSString*}
 */
- (NSString*) description {
    return [self toString];
}


/**
 * Gets a URL for the specified base directory, and creates it if it doesn't already exists.
 * @param {NSSearchPathDirectory} the base directory identifier.
 * @returns {NSURL the resulting url}
 */
+ (NSURL*) urlForDirectory:(NSSearchPathDirectory) directorySearchPath  {
    return [[NSFileManager defaultManager] URLForDirectory: directorySearchPath
                                                  inDomain: NSUserDomainMask
                                         appropriateForURL: nil
                                                    create: YES
                                                     error: nil];
}

@end
