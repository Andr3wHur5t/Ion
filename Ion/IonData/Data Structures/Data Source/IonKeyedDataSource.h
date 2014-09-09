//
//  IonRawDataSource.h
//  Ion
//
//  Created by Andrew Hurst on 7/29/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//


#ifndef Ion_RawDataSource
#define Ion_RawDataSource

/**
 * The Data Source Options.
 */
typedef enum : short {
    IonDataSourceLocationRam =      1,
    IonDataSourceLocationStorage =  2,
    IonDataSourceLocationOffsite =  3
} IonDataSourceLocation;

/**
 * The data return block for the data source.
 * @prama {id} the resulting object for the call.
 * @returns {void}
 */
typedef void(^IonRawDataSourceResultBlock)( id object );

/**
 * The completion block for the data source.
 * @prama {NSError*} the resulting error object for the call if any.
 * @returns {void}
 */
typedef void(^IonRawDataSourceCompletion)( NSError* error );

@protocol IonKeyedDataSource <NSObject>

/**
 * Gets the object with the specified key, or returns NULL.
 * @param {NSString*} the key to get the object for.
 * @param {IonRawDataSourceResultBlock} the block where the result will be returned.
 * @returns {void}
 */
- (void) objectForKey:(NSString*) key withResultBlock:(IonRawDataSourceResultBlock) result;

/**
 * Sets the object for the specified key.
 * @param {NSString*} the key for the object to set.
 * @param {id} the object to put in the data system.
 * @param {IonRawDataSourceCompletion} the completion.
 * @returns {void} returns false if the operation isn't valid.
 */
- (void) setObject:(id) object forKey:(NSString*) key withCompletion:(IonRawDataSourceCompletion) completion;

/**
 * Removes an object for the specified key.
 * @param {NSString*} the key to remove the object for.
 * @param {IonRawDataSourceCompletion} the completion.
 * @returns {void}
 */
- (void) removeObjectForKey:(NSString*) key withCompletion:(IonRawDataSourceCompletion) completion;

/**
 * Removes all objects for data source.
 * @param {IonRawDataSourceCompletion} the completion.
 * @returns {void}
 */
- (void) removeAllObjects:(IonRawDataSourceCompletion) completion;

/**
 * The data sources options.
 * @returns {IonDataSourceLocation} the location of the data source.
 */
- (IonDataSourceLocation) location;

@end


#pragma mark GCD Utilities

/**
 * The Ion Standard Dispatch Queue token.
 */
static const char* ionStandardDispatchQueue_label = "com.ion.standardDispatch";

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"
/**
 * Gets the Standard Dispatch Queue.
 * @returns {dispatch_queue_t}
 */
static dispatch_queue_t ionStandardDispatchQueue () {
    static dispatch_queue_t ionStandardDispatchQueue_Queue;
    static dispatch_once_t ionStandardDispatchQueue_OnceToken;
    
    dispatch_once(&ionStandardDispatchQueue_OnceToken, ^{
        ionStandardDispatchQueue_Queue = dispatch_queue_create( ionStandardDispatchQueue_label, NULL );
    });
    
    return ionStandardDispatchQueue_Queue;
}
#pragma clang diagnostic pop

#endif // Ion_RawDataSource