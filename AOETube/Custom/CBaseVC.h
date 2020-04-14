//
//  CBaseVC.h
//  AlarmA
//
//  Created by Cuong Hoang on 5/25/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseDatabase;
@import Firebase;
@import GoogleMobileAds;
@import FBAudienceNetwork;
#import <AdColony/AdColony.h>
#import "CKeyboardToolbar.h"
#import "CSettingController.h"
#import "MBProgressHUD.h"
@class CAOEModel;

@interface CBaseVC : UIViewController{
    IBOutlet UIView *ol_adsView;
    CKeyboardToolbar *myToolbar;
}
@property (assign, nonatomic) BOOL addBackButton;
@property(nonatomic, strong) GADBannerView *bannerView;
- (void)initUI;
- (void)initData;
- (void)addBackground;
- (void)playYoutubeWithItem:(CAOEModel*)item;
- (void)loadBannerAds:(int)index;
- (void)loadVideoAds:(int)AdNumber;
- (IBAction)btnVideoAdsClicked:(id)sender;
- (void)showLoading;
- (void)dismissLoading;
- (void)showWebViewUrl:(NSString*)urlStr;
- (void)updateCoin;
//- (void)playYoutubeUrl:(NSString*)url;
@end
