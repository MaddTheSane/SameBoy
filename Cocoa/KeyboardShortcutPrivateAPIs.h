#ifndef KeyboardShortcutPrivateAPIs_h
#define KeyboardShortcutPrivateAPIs_h

#import <AppKit/AppKit.h>

/* These are private APIs, but they are a very simple and comprehensive way
   to convert a key equivalent to its display name. */

@interface NSKeyboardShortcut : NSObject <NSCopying>

+ (instancetype)shortcutWithPreferencesEncoding:(NSString *)encoding;
+ (instancetype)shortcutWithKeyEquivalent:(NSString *)key_equivalent modifierMask:(NSEventModifierFlags)mask;
- (instancetype)initWithKeyEquivalent:(NSString *)key_equivalent modifierMask:(NSEventModifierFlags)mask;

@property(readonly) NSEventModifierFlags modifierMask;
@property(readonly, copy) NSString *keyEquivalent;
@property(readonly, copy) NSString *preferencesEncoding;
@property(readonly, copy) NSString *localizedModifierMaskDisplayName;
@property(readonly, copy) NSString *localizedKeyEquivalentDisplayName;
@property(readonly, copy) NSString *localizedDisplayName;

@end

@interface NSPrefPaneUtils : NSObject
+ (id)stringForVirtualKey:(unsigned int)key modifiers:(unsigned int)flags;
@end

#endif
