//
//  CFDBController.m
//  AOETube
//
//  Created by Cuong Hoang on 6/20/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CFDBController.h"
#import "NSString+C.h"
#import "CAOEModel.h"


@interface CFDBController()
//@property (strong, nonatomic) FIRDatabaseReference *ref;
@end




@implementation CFDBController
#pragma mark - INIT
+(instancetype)sharedInstance{
    static CFDBController *_sharedInstace = nil;
    static dispatch_once_t  _onceToken;
    dispatch_once(&_onceToken, ^{
        _sharedInstace = [[CFDBController alloc] init];
    });
    return _sharedInstace;
}
- (void)getDictionaryWithKey:(NSString*)key withSuccess:(CRestSuccessDictionary)success failure:(CRestFailure)failure{
    FIRDatabaseReference *_ref = [[[FIRDatabase database] reference] child:key];
    [_ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!cc_isEmpty(snapshot.value)) {
                success(snapshot.value);
            }else{
                failure(CERR_DATA_ERROR);
            }
            [_ref removeAllObservers];
        });
    }];
}
- (void)getArrayWithKey:(NSString*)key withSuccess:(CRestSuccessArray)success failure:(CRestFailure)failure{
    FIRDatabaseReference *_ref = [[[FIRDatabase database] reference] child:key];
    [_ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!cc_isEmpty(snapshot.value)) {
                success(snapshot.value);
            }else{
                failure(CERR_DATA_ERROR);
            }
            [_ref removeAllObservers];
        });
    }];
}

- (void)getPopupMesseageWithSuccess:(CRestSuccessDictionary)success failure:(CRestFailure)failure{
    [self getDictionaryWithKey:@"popup" withSuccess:^(NSDictionary *response) {
        success(response);
    } failure:^(NSString *errorDes) {
        failure(errorDes);
    }];
}
- (void)getUpdateVersionWithSuccess:(CRestSuccessDictionary)success failure:(CRestFailure)failure{
    [self getDictionaryWithKey:@"update" withSuccess:^(NSDictionary *response) {
        success(response);
    } failure:^(NSString *errorDes) {
        failure(errorDes);
    }];
}
- (void)getAdsSettingWithSuccess:(CRestSuccessDictionary)success failure:(CRestFailure)failure{
    [self getDictionaryWithKey:@"ads" withSuccess:^(NSDictionary *response) {
        success(response);
    } failure:^(NSString *errorDes) {
        failure(errorDes);
    }];
}
- (void)getSettingWithSuccess:(CRestSuccessDictionary)success failure:(CRestFailure)failure{
    [self getDictionaryWithKey:@"setting" withSuccess:^(NSDictionary *response) {
        success(response);
    } failure:^(NSString *errorDes) {
        failure(errorDes);
    }];
}
#pragma mark - Main Views
- (void)getGamersWithSuccess:(CRestSuccessArray)success failure:(CRestFailure)failure{
    NSMutableArray *_result = [NSMutableArray new];
    [self getArrayWithKey:@"gamers" withSuccess:^(NSArray *response) {
        for (NSDictionary *item in response) {
            //NSLog(@"item: %@", item);
            CGamerModel *model = [CGamerModel new];
            model.mTitle = item[@"name"];
            model.mURL = item[@"url"];
            model.mImage = item[@"pic"];
            [_result addObject:model];
        }
        success(_result);
    } failure:^(NSString *errorDes) {
        failure(errorDes);
    }];
}
- (void)getLivesWithSuccess:(CRestSuccessArray)success failure:(CRestFailure)failure{
    NSMutableArray *_result = [NSMutableArray new];
    [self getArrayWithKey:@"lives" withSuccess:^(NSArray *response) {
        for (NSDictionary *item in response) {
            //NSLog(@"item: %@", item);
            if ([item[@"enable"] boolValue]) {
                CLiveModel *model = [CLiveModel new];
                model.mEnable = YES;
                model.mId = item[@"id"];
                model.mTitle = item[@"title"];
                model.mImage = item[@"pic"];
                model.mPrice = [item[@"price"] intValue];
                model.mURL = item[@"url"];
                [_result addObject:model];
            }
        }
        success(_result);
    } failure:^(NSString *errorDes) {
        failure(errorDes);
    }];
}

@end
