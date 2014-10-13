//
//  NSData+FOCrypto.h
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (FOCrypto)
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//                        Asymmetric Encryption
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
#pragma mark RSA


// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//                        Symmetric Encryption
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
#pragma mark AES


// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//                                Hashes
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
#pragma mark SHA
/**
 * Gets the SHA1 has of the data.
 * @returns the SHA1 signature.
 */
- (NSData*) SHA1Hash;
/**
 * Gets the SHA256 has of the data.
 * @returns the SHA256 signature.
 */
- (NSData*) SHA256Hash;

/**
 * Gets the SHA512 has of the data.
 * @returns the SHA512 signature.
 */
- (NSData*) SHA512Hash;

@end
