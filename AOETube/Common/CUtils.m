//
//  CUtils.m
//  AOETube
//
//  Created by Cuong Hoang on 6/22/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#define CKEY_ENCRYPT @"aoetube"
#import "CUtils.h"
#import "SimpleKeychain.h"

@implementation CUtils
#pragma mark - REGISTER

void cc_setMarkObject(NSString *object, NSString *key){
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:object forKey:key];[prefs synchronize];
}
NSString* cc_getMarkObject(NSString *key){
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *result = [prefs objectForKey:key];
    return([result length] == 0) ? nil : result;
}
void cc_removeMarkObject(NSString *key){
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:key];[prefs synchronize];
}

void cc_setMarkInt(int value, NSString* key){
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:value forKey:key];
    [prefs synchronize];
}
int cc_getMarkInt(NSString *key){
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger mark = [prefs integerForKey:key];
    return (int)mark;
}
void cc_setMarkBool(BOOL value, NSString *key){
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:value forKey:key];
    [prefs synchronize];
}
BOOL cc_getMarkBool(NSString *key){
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger mark = [prefs boolForKey:key];
    return (int)mark;
}
#pragma mark - open links
void cc_openFacebook(NSString *fbId){
    if ([CApp canOpenURL:[NSURL URLWithString:@"fb://"]]) {
        [CApp openURL:[NSURL URLWithString:[NSString stringWithFormat:@"fb://profile/%@", fbId]]];
    }
    else {
        cc_openURL([NSString stringWithFormat:@"https://www.facebook.com/%@", fbId]);
    }
}

void cc_openItunesApp(NSString*appId){
    NSString *_itunesLink = [NSString stringWithFormat:@"itms://itunes.apple.com/us/app/apple-store/id%@?mt=8",appId];
    cc_openURL(_itunesLink);
    
}
BOOL cc_openURL(NSString *urlStr){
    NSURL *url = [NSURL URLWithString:urlStr];
    if ([CApp canOpenURL:url]) {
        [CApp openURL:url];
        return YES;
    }
    return NO;
}

#pragma mark -
BOOL cc_isEmpty(id object){
    if (!object) {
        return YES;
    }
    if (object==[NSNull null]) {
        return YES;
    }
    if([object isKindOfClass:[NSString class]]){
        if(((NSString*)object).isEmpty)
            return YES;
    }
    if([object isKindOfClass:[NSDictionary class]]){
        if (((NSDictionary*)object).count==0) {
            return YES;
        }
    }
    if([object isKindOfClass:[NSArray class]]){
        if (((NSArray*)object).count==0) {
            return YES;
        }
    }
    return NO;
}
#pragma mark - COIN
NSString* cc_encryptString(NSString*input){
    input = [input stringByAppendingString:CKEY_ENCRYPT];
    NSData *nsdata = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    // Print the Base64 encoded string
    NSLog(@"Encoded: %@", base64Encoded);
    return base64Encoded;
    
    // Let's go the other way...
    
    // NSData from the Base64 encoded str
    
}
NSString* cc_decryptString(NSString*input){
    
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:input options:0];
    
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    NSLog(@"Decoded: %@", [base64Decoded stringByReplacingOccurrencesOfString:CKEY_ENCRYPT withString:@""]);
    if (![base64Decoded containsString:CKEY_ENCRYPT]) {
        return nil;
    }else{
        return [base64Decoded stringByReplacingOccurrencesOfString:CKEY_ENCRYPT withString:@""];
    }
}

int cc_getCoin(){
    
    NSString *_coinKey = cc_encryptString(CKEY_COIN);
    
    
    NSString *_coinEncrypted = cc_getKeychain(_coinKey);
    if (cc_isEmpty(_coinEncrypted)) {
        return 0;
    }
    
    _coinEncrypted = cc_decryptString(_coinEncrypted);
    
    return [_coinEncrypted intValue];
    
    return NO;
//    return [cc_decryptString(cc_getMarkObject(CKEY_COIN)) intValue];
}
void cc_setCoin(int coin){
    
    NSString *_coinKey = cc_encryptString(CKEY_COIN);
    NSString *_coinEncrypted = cc_encryptString([NSString stringWithFormat:@"%d", coin]);
    cc_saveKeychain(_coinKey, _coinEncrypted);
//    cc_setMarkObject(cc_encryptString([NSString stringWithFormat:@"%d", coin]), CKEY_COIN);
}
void cc_saveKeychain(NSString *key, NSString*value){
    [SimpleKeychain save:key data:value];
}
NSString* cc_getKeychain(NSString *key){
    return [SimpleKeychain load:key];
}
void cc_saveDeviceId(NSString*deviceId){
    //    KeychainItemWrapper *_keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Alarm" accessGroup:nil];
    //    [_keychainItem setObject:[deviceId stringByReplacingOccurrencesOfString:@"-" withString:@"o"] forKey:TKey_DeviceId];
    [SimpleKeychain save:CKEY_DEVICEID data:deviceId];
}
NSString* cc_getDeviceId(){
    //    KeychainItemWrapper *_keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Alarm" accessGroup:nil];
    //    return [_keychainItem objectForKey:TKey_DeviceId];
    NSString *_deviceId = [SimpleKeychain load:CKEY_DEVICEID];
    
    return _deviceId;
}
void cc_generateNewDeviceId(){
    NSString *_deviceId = cc_reateRandomString();
    cc_saveDeviceId(_deviceId);
}
void cc_deleteAccount(){
    [SimpleKeychain delete:CKEY_DEVICEID];
    NSString *_coinKey = cc_encryptString(CKEY_COIN);
    [SimpleKeychain delete:_coinKey];
    NSString *_historyKey = cc_encryptString(CKEY_TRANS);
    [SimpleKeychain delete:_historyKey];
}
const NSUInteger NUMBER_OF_CHARS = 8;
NSString * cc_reateRandomString()
{
    static char const possibleChars[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    unichar characters[NUMBER_OF_CHARS];
    for( int index=0; index < NUMBER_OF_CHARS; ++index )
    {
        characters[ index ] = possibleChars[arc4random_uniform(sizeof(possibleChars)-1)];
    }
    
    return [ NSString stringWithCharacters:characters length:NUMBER_OF_CHARS ] ;
}
BOOL cc_isBuyItem(NSString *itemId){
    if (cc_isEmpty(itemId)) {
        return NO;
    }
    NSString *_historyKey = cc_encryptString(CKEY_TRANS);
    NSString *_history = cc_getKeychain(_historyKey);
    if (cc_isEmpty(_history)) {
        _history = @"";
    }
    
    _history = cc_decryptString(_history);
    
    if (!cc_isEmpty(_history) && [_history containsString:itemId]) {
        return YES;
    }
    return NO;
}
BOOL cc_buyItem(NSString *itemId){
    if (cc_isEmpty(itemId)) {
        return NO;
    }
    NSString *_historyKey = cc_encryptString(CKEY_TRANS);
    NSString *_history = cc_getKeychain(_historyKey);
    
    if (cc_isEmpty(_history)) {
        _history = @"";
    }else{
        _history = cc_decryptString(_history);
    }
    _history = [_history stringByAppendingFormat:@";%@", itemId];
    if (_history.length>100) {
        _history = [_history substringFromIndex:(_history.length-100)];
    }
    
    _history = cc_encryptString(_history);
    cc_saveKeychain(_historyKey, _history);
    _history = [SimpleKeychain load:_historyKey];
    
    return YES;
}
void cc_deleteHistory(){
    NSString *_historyKey = cc_encryptString(CKEY_TRANS);
    [SimpleKeychain delete:_historyKey];
}
@end
