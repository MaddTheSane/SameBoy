#import <Cocoa/Cocoa.h>

@class HFController;

/*! Returns the first index where the strings differ.  If the strings do not differ in any characters but are of different lengths, returns the smaller length; if they are the same length and do not differ, returns NSUIntegerMax */
static inline NSUInteger HFIndexOfFirstByteThatDiffers(const unsigned char *a, NSUInteger len1, const unsigned char *b, NSUInteger len2) {
    NSUInteger endIndex = MIN(len1, len2);
    for (NSUInteger i = 0; i < endIndex; i++) {
        if (a[i] != b[i]) return i;
    }
    if (len1 != len2) return endIndex;
    return NSUIntegerMax;
}

/*! Returns the last index where the strings differ.  If the strings do not differ in any characters but are of different lengths, returns the larger length; if they are the same length and do not differ, returns NSUIntegerMax */
static inline NSUInteger HFIndexOfLastByteThatDiffers(const unsigned char *a, NSUInteger len1, const unsigned char *b, NSUInteger len2) {
    if (len1 != len2) return MAX(len1, len2);
    NSUInteger i = len1;
    while (i--) {
        if (a[i] != b[i]) return i;
    }
    return NSUIntegerMax;
}

static inline unsigned long long llmin(unsigned long long a, unsigned long long b) {
    return a < b ? a : b;
}

PRIVATE_EXTERN NSImage *HFImageNamed(NSString *name);

/*! Returns an NSData from an NSString containing hexadecimal characters.  Characters that are not hexadecimal digits are silently skipped.  Returns by reference whether the last byte contains only one nybble, in which case it will be returned in the low 4 bits of the last byte. */
PRIVATE_EXTERN NSData *HFDataFromHexString(NSString *string, BOOL* isMissingLastNybble);

PRIVATE_EXTERN NSString *HFHexStringFromData(NSData *data);

/*! Modifies \c F_NOCACHE for a given file descriptor */
PRIVATE_EXTERN void HFSetFDShouldCache(int fd, BOOL shouldCache);

PRIVATE_EXTERN NSString *HFDescribeByteCountWithPrefixAndSuffix(const char *stringPrefix, unsigned long long count, const char *stringSuffix);
