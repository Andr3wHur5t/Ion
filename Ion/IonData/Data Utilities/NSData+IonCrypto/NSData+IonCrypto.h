//
//  NSData+IonCrypto.h
//  Ion
//
//  Created by Andrew Hurst on 8/6/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (IonCrypto)

/** ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
 *                          Asymmetric Encryption
 *  ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== */
#pragma mark RSA


/** ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
 *                          Symmetric Encryption
 *  ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== */
#pragma mark AES


/** ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
 *                                Hashes
 *  ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ====*/
#pragma mark SHA

/**
 * Gets the SHA1 has of the data.
 * @returns {NSData*} the SHA1 signature.
 */
- (NSData*) SHA1Hash;
/**
 * Gets the SHA256 has of the data.
 * @returns {NSData*} the SHA256 signature.
 */
- (NSData*) SHA256Hash;
/**
 * Gets the SHA512 has of the data.
 * @returns {NSData*} the SHA512 signature.
 */
- (NSData*) SHA512Hash;

@end
