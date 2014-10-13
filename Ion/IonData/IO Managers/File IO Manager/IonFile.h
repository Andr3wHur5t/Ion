//
//  IonFile.h
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IonDirectory;

@interface IonFile : NSObject
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
              andParentDirectory:(IonDirectory*) directory;

/**
 * Constructs the file object with the files' name, and directory.
 * @param {NSString*} the files' name.
 * @param {IonDirectory*} the files' parent directory.
 * @returns {instancetype}
 */
- (instancetype) initWithFileName:(NSString*) name
              andParentDirectory:(IonDirectory*) directory;


/**
 * Constructs the file based off of another file.
 * @param {IonFile*} the file to be based off of.
 * @retutns {instancetype}
 */
- (instancetype) initWithFile:(IonFile*) file;

#pragma mark Properties
/** The files' content data.
 */
@property (strong, nonatomic) NSMutableData* content;

/** The files' name, as it appears in the file system.
 */
@property (strong, nonatomic) NSString* name;

/** The files' directory, if it has one.
 */
@property (strong, nonatomic) IonDirectory* directory;

#pragma mark Data Set Utilities

/**
 * Sets the data content to a string.
 * @param {NSString*} string
 
 */
- (void) setDataWithString:(NSString*) string;

#pragma mark Data Get Utilities

/**
 * Gets the content as a string.
 * @returns {NSString*}
 */
- (NSString*) contentAsString;

@end
