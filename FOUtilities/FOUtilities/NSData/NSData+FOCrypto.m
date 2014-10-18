//
//  NSData+FOCrypto.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "NSData+FOCrypto.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (FOCrypto)
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//                        Asymmetric Encryption
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
#pragma mark RSA


// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//                        Symmetric Encryption
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
#pragma mark AES
// This needs major testing...


// * Gets the AES256 encrypted copy of the data using the inputed key 32 bytes long.
// * @param {NSString*} the 32 byte key to use, if not it will be null padded.
// * @returns {NSData*} the encrypted data.
- (NSData *)AES256EncryptWithKey:(NSString *)key {
    NSUInteger keySize = kCCKeySizeAES256;
    CCAlgorithm algorithim = kCCAlgorithmAES128;
    BOOL patchNeeded;
    char keyPtr[ keySize + 1 ];
    if ( !key || ![key isKindOfClass:[NSString class]] )
        return NULL;
    
    // Zerro Out Key
    bzero( keyPtr, sizeof(keyPtr) );
    patchNeeded = ( [key length] > keySize );
    
    // Patch
    if (patchNeeded)
        key = [key substringToIndex: kCCKeySizeAES256]; // Ensure that the key isn't longer than what's needed (kCCKeySizeAES256)
    
    // fetch key data
    [key getCString: keyPtr maxLength: sizeof(keyPtr) encoding: NSUTF8StringEncoding];
    
    if ( patchNeeded )
        keyPtr[0] = '\0';  // Previous iOS version than iOS7 set the first char to '\0' if the key was longer than the key size
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + keySize;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, algorithim, kCCOptionPKCS7Padding,
                                          keyPtr, keySize,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess)
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    
    free(buffer); //free the buffer;
    return nil;
}

- (NSData *)AES256DecryptWithKey:(NSString *)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}


// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//                                Hashes
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
#pragma mark SHA
- (NSData *)SHA1Hash {
    unsigned char hash[CC_SHA1_DIGEST_LENGTH];
    if ( CC_SHA512( [self bytes], (CC_LONG)[self length], hash) )
        return [NSData dataWithBytes: hash length: CC_SHA1_DIGEST_LENGTH];
    
    return NULL;
}

- (NSData *)SHA256Hash {
    unsigned char hash[CC_SHA256_DIGEST_LENGTH];
    if ( CC_SHA256( [self bytes], (CC_LONG)[self length], hash) )
        return [NSData dataWithBytes: hash length: CC_SHA256_DIGEST_LENGTH];
    
    return NULL;
}

- (NSData *)SHA512Hash {
    unsigned char hash[CC_SHA512_DIGEST_LENGTH];
    if ( CC_SHA512( [self bytes], (CC_LONG)[self length], hash) )
        return [NSData dataWithBytes: hash length: CC_SHA512_DIGEST_LENGTH];
    
    return NULL;
}

@end
