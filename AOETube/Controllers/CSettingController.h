//
//  CSettingController.h
//  AlarmA
//
//  Created by Cuong Hoang on 6/14/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GoogleMobileAds;
@import FBAudienceNetwork;
#import "CFDBController.h"

@interface CSettingController : NSObject
//ads
@property(assign, nonatomic)BOOL mAdsBannerEnable;
@property(assign, nonatomic)ADS_SUPPLIER mAdsBannerSupplier;
@property(assign, nonatomic)int mAdsVideoReward;
@property(strong, nonatomic)NSString *mAdsBannerAppId;
@property(strong, nonatomic)NSString *mAdsBannerItem1;
@property(strong, nonatomic)NSString *mAdsBannerItem2;

@property(assign, nonatomic)BOOL mAdsVideoEnable;
@property(assign, nonatomic)ADS_SUPPLIER mAdsVideoSupplier;
@property(strong, nonatomic)NSString *mAdsVideoAppId;
@property(strong, nonatomic)NSString *mAdsVideoItem1;
@property(strong, nonatomic)NSString *mAdsVideoItem2;
//update
@property(assign, nonatomic)NSString *mNewestVersion;
@property(assign, nonatomic)NSString *mUpdateMessage;
@property(assign, nonatomic)NSString *mForceUpdate;
//setting
@property(assign, nonatomic)BOOL mCoinEnable;
@property(assign, nonatomic)BOOL mReview;
+(instancetype)sharedInstance;
- (void)getAdsSettingWithSuccess:(CRestSuccess)success failure:(CRestFailure)failure;
- (void)getSettingWithSuccess:(CRestSuccess)success failure:(CRestFailure)failure;
- (void)getUpdateSettingWithSuccess:(CRestSuccess)success failure:(CRestFailure)failure;
@end
