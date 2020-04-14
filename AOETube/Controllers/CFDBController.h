//
//  CFDBController.h
//  AOETube
//
//  Created by Cuong Hoang on 6/20/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//
@import Firebase;
#import <Foundation/Foundation.h>
typedef void (^CRestSuccess)();
typedef void (^CRestSuccessSnapshot)(FIRDataSnapshot*snapshot);
typedef void (^CRestSuccessArray)(NSArray*response);
typedef void (^CRestSuccessString)(NSString*response);
typedef void (^CRestSuccessDictionary)(NSDictionary*response);
typedef void (^CRestFailure)(NSString *errorDes);

@interface CFDBController : NSObject
+(instancetype)sharedInstance;
- (void)getPopupMesseageWithSuccess:(CRestSuccessDictionary)success failure:(CRestFailure)failure;
- (void)getUpdateVersionWithSuccess:(CRestSuccessDictionary)success failure:(CRestFailure)failure;
- (void)getSettingWithSuccess:(CRestSuccessDictionary)success failure:(CRestFailure)failure;
- (void)getAdsSettingWithSuccess:(CRestSuccessDictionary)success failure:(CRestFailure)failure;
//- (void)getGiftWithSuccess:(CRestSuccessArray)success failure:(CRestFailure)failure;

- (void)getLivesWithSuccess:(CRestSuccessArray)success failure:(CRestFailure)failure;
- (void)getGamersWithSuccess:(CRestSuccessArray)success failure:(CRestFailure)failure;

@end
