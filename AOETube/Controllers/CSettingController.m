//
//  CSettingController.m
//  AlarmA
//
//  Created by Cuong Hoang on 6/14/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CSettingController.h"
//#import "CFDBController.h"

@implementation CSettingController
+(instancetype)sharedInstance{
    static CSettingController *_sharedInstace = nil;
    static dispatch_once_t  _onceToken;
    dispatch_once(&_onceToken, ^{
        _sharedInstace = [[CSettingController alloc] init];
//        [_sharedInstace getAdsBannerSupplier];
        _sharedInstace.mReview = YES;
    });
    return _sharedInstace;
}
//- (void)getAdsBannerSupplier{
//    [[CFDBController sharedInstance] getAdsSettingWithSuccess:^(NSDictionary *response) {
//        self.mAdsSupplier = [response[@"banner"][@"supplier"] intValue];
//       self.adsReward = [response[@"video"][@"reward"] intValue];
//    } failure:^(NSString *errorDes) {
//        self.mAdsSupplier = ADS_FACEBOOK;
//    }];
//}
//- (void)getReview{
//    [[CFDBController sharedInstance] getSettingWithSuccess:^(NSDictionary *response) {
//        if ([response[@"review"] intValue]==0) {
//            self.review = NO;
//            
//        }
//    } failure:^(NSString *errorDes) {
//        
//    }];
//}

- (void)getAdsSettingWithSuccess:(CRestSuccess)success failure:(CRestFailure)failure{
    [[CFDBController sharedInstance] getAdsSettingWithSuccess:^(NSDictionary *response) {
        self.mAdsBannerEnable = [response[@"banner"][@"enable"] boolValue];
        if(self.mAdsBannerEnable){
            self.mAdsBannerSupplier = [response[@"banner"][@"supplier"] intValue];
            if (self.mAdsBannerSupplier==ADS_FACEBOOK) {
                self.mAdsBannerItem1 = response[@"banner"][@"ads_fb"][@"item1"];
                self.mAdsBannerItem2 = response[@"banner"][@"ads_fb"][@"item2"];
            }else{
                self.mAdsBannerAppId = response[@"banner"][@"ads_gg"][@"app_id"];
                self.mAdsBannerItem1 = response[@"banner"][@"ads_gg"][@"item1"];
                self.mAdsBannerItem2 = response[@"banner"][@"ads_gg"][@"item2"];
            }
        }
        self.mAdsVideoEnable = [response[@"video"][@"enable"] boolValue];
        if(self.mAdsVideoEnable){
            self.mAdsVideoReward = [response[@"video"][@"reward"] intValue];
            self.mAdsVideoSupplier = [response[@"video"][@"supplier"] intValue];
            if (self.mAdsVideoSupplier==ADS_FACEBOOK) {
                self.mAdsVideoItem1 = response[@"video"][@"ads_fb"][@"item1"];
                self.mAdsVideoItem2 = response[@"video"][@"ads_fb"][@"item2"];
            }else{
                self.mAdsVideoItem1 = response[@"video"][@"ads_gg"][@"item1"];
                self.mAdsVideoItem2 = response[@"video"][@"ads_gg"][@"item2"];
            }
        }
        success();
    } failure:^(NSString *errorDes) {
        self.mAdsBannerEnable = NO;
        self.mAdsBannerSupplier = ADS_FACEBOOK;
        self.mAdsVideoEnable = NO;
        self.mAdsVideoReward = 0;
        failure(errorDes);
    }];
}
- (void)getSettingWithSuccess:(CRestSuccess)success failure:(CRestFailure)failure{
    [[CFDBController sharedInstance] getSettingWithSuccess:^(NSDictionary *response) {
        self.mReview = [response[@"review"] boolValue];
        self.mCoinEnable = [response[@"coin_enable"] boolValue];
        success();
    } failure:^(NSString *errorDes) {
        self.mReview = YES;
        failure(errorDes);
    }];
}
- (void)getUpdateSettingWithSuccess:(CRestSuccess)success failure:(CRestFailure)failure{
    [[CFDBController sharedInstance] getUpdateVersionWithSuccess:^(NSDictionary *response) {
        self.mNewestVersion = response[@"version"];
        self.mUpdateMessage = response[@"message"];
        self.mForceUpdate = response[@"force_update"];
        success();
    } failure:^(NSString *errorDes) {
        self.mNewestVersion = @"1.0";
        self.mUpdateMessage = @"";
        self.mForceUpdate = NO;
        failure(errorDes);
    }];
}
@end
