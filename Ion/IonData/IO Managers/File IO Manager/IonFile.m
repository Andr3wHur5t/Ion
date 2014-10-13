//
//  IonFile.m
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonFile.h"
#import <FOUtilities/FOUtilities.h>

@implementation IonFile
#pragma mark Constructors

/**
 * Constructs the file object with the files' content, name, and directory.
 * @param {NSData*} the files' content.
 * @param {NSString*} the files' name.
 * @param {IonDirectory*} the files' parent directory.
 * @returns {instancetype}
 */
- (instancetype) initWithContent:(NSData*) content
                        fileName:(NSString*) name
              andParentDirectory:(IonDirectory*) directory {
    self = [self init];
    if ( self ) {
        self.content = [[NSMutableData alloc] initWithData: content];
        self.name = name;
        self.directory = directory;
    }
    return self;
}

/**
 * Constructs the file object with the files' name, and directory.
 * @param {NSString*} the files' name.
 * @param {IonDirectory*} the files' parent directory.
 * @returns {instancetype}
 */
- (instancetype) initWithFileName:(NSString*) name
               andParentDirectory:(IonDirectory*) directory {
    return [self initWithContent: NULL fileName: name andParentDirectory: directory];
}

/**
 * Constructs the file based off of another file.
 * @param {IonFile*} the file to be based off of.
 * @retutns {instancetype}
 */
- (instancetype) initWithFile:(IonFile*) file {
    return [self initWithContent: file.content fileName: file.name andParentDirectory: file.directory];
}

#pragma mark Data Set Utilities

/**
 * Sets the data content to a string.
 * @param {NSString*} string
 
 */
- (void) setDataWithString:(NSString*) string {
    [_content setData: [NSData dataFromString: string]];
}

#pragma mark Data Get Utilities

/**
 * Gets the content as a string.
 * @returns {NSString*}
 */
- (NSString*) contentAsString {
    return [_content toString];
}

#pragma mark Debug Description

/**
 * The debug description.
 * @retuns {NSString*}
 */
- (NSString*) description {
    return [NSString stringWithFormat: @"File Name: %@ with length: %lu", _name, (unsigned long)_content.length];
}

@end
