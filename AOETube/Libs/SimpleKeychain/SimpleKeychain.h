//
//  SimpleKeychain.h
//  TAlarm
//
//  Created by Cuong Hoang on 12/7/15.
//
//

#import <Foundation/Foundation.h>

@class SimpleKeychainUserPass;

@interface SimpleKeychain : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

@end
