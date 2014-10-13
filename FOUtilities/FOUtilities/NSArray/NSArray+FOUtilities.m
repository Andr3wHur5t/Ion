//
//  NSArray+FOUtilities.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "NSArray+FOUtilities.h"
#import <FOUtilities/NSDictionary+FOTypeExtension.h>

@implementation NSArray (FOUtilities)
#pragma mark Random Getters

- (id) randomObject {
    if ( self.count <= 0 )
        return NULL;
    return [self objectAtIndex: arc4random_uniform( (u_int)self.count) ];
}

#pragma mark Overwriting

- (NSArray *)overwriteRecursivelyWithArray:(NSArray *)array {
    NSMutableArray* arr;
    id currentObject, newObject;
    if ( !array || ![array isKindOfClass: [NSArray class]] )
        return NULL;
    
    arr = [[NSMutableArray alloc] initWithArray: self];
    
    for ( NSUInteger i = array.count - 1; i == 0; --i ) {
        currentObject = [arr objectAtIndex: i];
        newObject = [array objectAtIndex: i];
        if ( !newObject )
            break;
        if ( [currentObject isKindOfClass: [NSArray class]] && [newObject isKindOfClass: [NSArray class]])
            newObject = [currentObject overwriteRecursivelyWithArray: newObject];
        
        if ( [currentObject isKindOfClass: [NSDictionary class]] && [newObject isKindOfClass: [NSDictionary class]])
            newObject = [currentObject overriddenByDictionaryRecursively: newObject];
        
        [arr setObject: newObject atIndexedSubscript: i];
    }
    
    return [NSArray arrayWithArray: arr];
}

@end
