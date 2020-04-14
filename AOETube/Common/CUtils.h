//
//  CUtils.h
//  AOETube
//
//  Created by Cuong Hoang on 6/22/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CUtils : NSObject
//Register
void cc_setMarkObject(NSString *object, NSString *key);
NSString* cc_getMarkObject(NSString *key);
void cc_removeMarkObject(NSString *key);
void cc_setMarkInt(int value, NSString* key);
int cc_getMarkInt(NSString *key);
void cc_setMarkBool(BOOL value, NSString *key);
BOOL cc_getMarkBool(NSString *key);
//open facebook
void cc_openFacebook(NSString *fbId);
void cc_openItunesApp(NSString*appId);
BOOL cc_openURL(NSString *urlStr);
//coin
NSString* cc_encryptString(NSString*input);
NSString* cc_decryptString(NSString*input);
int cc_getCoin();
void cc_setCoin(int coin);
NSString* cc_getDeviceId();
void cc_generateNewDeviceId();
BOOL cc_isBuyItem(NSString *itemId);
BOOL cc_buyItem(NSString *itemId);
void cc_deleteHistory();
void cc_deleteAccount();
//
BOOL cc_isEmpty(id object);
@end
