//
//  HFPrivilegedHelper.h
//  HexFiend_Framework
//
//  Created by Kevin Wojniak on 12/26/23.
//  Copyright © 2023 ridiculous_fish. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HFPrivilegedHelper <NSObject>
@required
- (BOOL)openFileAtPath:(const char *)path writable:(BOOL)writable fileDescriptor:(int *)outFD error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
