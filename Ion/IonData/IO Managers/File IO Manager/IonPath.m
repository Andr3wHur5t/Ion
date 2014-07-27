//
//  IonPath.m
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonPath.h"

@implementation IonPath
#pragma mark Constructors

/**
 * The standard constructor.
 * @retutns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self )
        [self setComponentsFromURL: [[NSBundle mainBundle] bundleURL]];
    
    return self;
}

/**
 * Creates a path object from the inputted NSURL.
 * @param {NSURL*} the url to base the path off of.
 * @returns {instancetype} or NULL if invalid
 */
- (instancetype) initFromURL:(NSURL*) url {
    if ( !url )
        return NULL;
    self = [self init];
    if ( self )
        [self setComponentsFromURL: url];
    return self;
}

/**
 * Creates a copy path from the inputted path.
 * @param {IonPath*} the path to be derived from.
 * @returns {instancetype} or NULL if invalid
 */
- (instancetype) initFromPath:(IonPath*) path {
    if ( !path )
        return NULL;
    self = [self init];
    if ( self ) {
        [self setComponentsArray: path.components];
        [self normalizeComponents];
    }
    return self;
}

/**
 * Creates a path with the inputed path appended by the array of items;
 * @param {IonPath*} the path to append from
 * @param {NSArray*} the additional elements to append.
 * @returns {instancetype} or NULL if invalid
 */
- (instancetype) initPath:(IonPath*) rootPath appendedByElements:(NSArray*) pathElements {
    if ( !pathElements )
        return NULL;
    self = [self initFromPath: rootPath];
    if ( self )
        [self appendHierarchy: pathElements];
    return self;
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
    [self setComponentsArray: [self.components arrayByAddingObjectsFromArray: additional]];
    [self normalizeComponents];
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
 * Sets our componets to match a URL.
 * @returns {void}
 */
- (void) setComponentsFromURL:(NSURL*) url {
    [self setComponentsArray: [IonPath pathComponentsFromURL: url]];
    [self normalizeComponents];
}

/**
 * Gets path components from an NSURL
 * @param {NSURL} the url to get the components from.
 * @returns {NSArray*} and array of components, or NULL if invalid
 */
+ (NSArray*) pathComponentsFromURL:(NSURL*) url {
    NSString* intermediate;
    NSArray* components;
    if ( !url )
        return NULL;
    // TODO: Process
    intermediate = url.path;
    if ( !intermediate || ![intermediate isKindOfClass: [NSString class]] )
        return NULL;
    
    components = [intermediate componentsSeparatedByString: @"/"];
    if ( ![components isKindOfClass: [NSArray class]] )
        return NULL;
    return components;
}

/**
 * Normalize component strings to work with the file system.
 * @returns {void}
 */
- (void) normalizeComponents {
    NSString* component;
    NSMutableArray* currentComponents;
    NSRegularExpression* normalizationExpresion;
    NSMutableIndexSet* indexesToRemove;
    
    // Set
    indexesToRemove =  [[NSMutableIndexSet alloc] init];
    normalizationExpresion = [NSRegularExpression regularExpressionWithPattern: @"[:/]+"
                                                                       options: 0
                                                                         error: nil];
    currentComponents = [[NSMutableArray alloc] initWithArray: self.components];
    
    // Search
    for ( NSInteger i = [currentComponents count] - 1; i > 0; --i ) {
        
        component = [currentComponents objectAtIndex: i];
        if ( !component || ![component isKindOfClass: [NSString class]] ) {
            [indexesToRemove addIndex: i];
        }
        else {
            // Filter
            if ( [component isEqualToString: @"."] || [component isEqualToString: @""] ) {
                [indexesToRemove addIndex: i];
            } else if ( [component isEqualToString: @".."] ) {
                [indexesToRemove addIndex: i];
                [indexesToRemove addIndex: i + 1];
            }
            component = [normalizationExpresion stringByReplacingMatchesInString: component
                                                                         options: 0
                                                                           range: NSMakeRange(0, component.length)
                                                                    withTemplate: @"-"];
        
                [currentComponents setObject: component atIndexedSubscript: i];
            }
    }
    [currentComponents removeObjectsAtIndexes: indexesToRemove];
    // Update
    [self setComponentsArray: currentComponents];
}

/**
 * Converts to a string representation of the path.
 * @returns {NSString*}
 */
- (NSString*) toString {
    NSString* composite = @"";
    if ( self.components.count == 0 )
        return @"/";
    
    for ( NSString* component in self.components )
        composite = [composite stringByAppendingFormat:@"/%@", component];
    
    return composite;
}

#pragma mark Debug Description

/**
 * The Debug description.
 * @retuns {NSString*}
 */
- (NSString*) description {
    return [self toString];
}

@end
