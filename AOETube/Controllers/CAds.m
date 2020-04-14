//
//  CAds.m
//  AOETube
//
//  Created by Cuong Hoang on 7/12/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CAds.h"
#import <AdColony/AdColony.h>
@interface CAds(){
    AdColonyInterstitial *_ad;
}
@end
@implementation CAds
+(instancetype)sharedInstance{
    static CAds *_sharedInstace = nil;
    static dispatch_once_t  _onceToken;
    dispatch_once(&_onceToken, ^{
        _sharedInstace = [[CAds alloc] init];
    });
    return _sharedInstace;
}
- (void)configureAdsVideo{
    if (self.mAdsVideoSupplier==CADS_ADCOLONY) {
        [AdColony configureWithAppID:self.mAdsVideoAppId
                             zoneIDs:self.mAdsVideoItems
                             options:nil
                          completion:nil
         ];
    }
}
- (void)requesAdsVideo:(int)index{
    [AdColony requestInterstitialInZone:self.mAdsVideoItems[index] options:nil success:^(AdColonyInterstitial *ad) {
        _ad = ad;
    }failure:nil];
}
- (void)showAdsVideo:(UIViewController*)viewController{
    [_ad showWithPresentingViewController:viewController];
}
@end
