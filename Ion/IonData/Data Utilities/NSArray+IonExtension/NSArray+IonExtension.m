//
//  NSArray+IonExtension.m
//  Ion
//
//  Created by Andrew Hurst on 8/3/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "NSArray+IonExtension.h"
#import "NSDictionary+IonTypeExtension.h"

@implementation NSArray (IonExtention)

/**
 * Dose a recursive overwrite
 * @param {NSArray*} the array to do the shallow overwrite with.
 * @returns {NSArray*} the resulting array of the overwrite.
 */
- (NSArray*) overwriteRecursivelyWithArray:(NSArray*) array {
    NSMutableArray* arr;
    id currentObject, newObject;
    if ( !array || ![array isKindOfClass: [NSArray class]] )
        return NULL;
    
    arr = [[NSMutableArray alloc] initWithArray: self];
    
    for ( NSInteger i = array.count - 1; i >= 0; --i ) {
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
