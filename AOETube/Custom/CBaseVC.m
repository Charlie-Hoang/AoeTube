//
//  CBaseVC.m
//  AlarmA
//
//  Created by Cuong Hoang on 5/25/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CBaseVC.h"
//#import "MBProgressHUD.h"
#import "CWebVC.h"
#import "CPlayerVC.h"
#import "CSettingController.h"
#import "CBarButtonItem.h"
#import "CFDBController.h"
#import "CAOEModel.h"


@interface CBaseVC ()<GADRewardBasedVideoAdDelegate, FBAdViewDelegate>{
    id viewAdsBtn;
    NSString *_adsBannerItem;
    NSString *_adsVideoItem;
    
}
@property(strong, nonatomic)UIImageView *bg;
@end

@implementation CBaseVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
}
- (void)initUI{
    myToolbar = [[CKeyboardToolbar alloc] initWithDefaultsAndTarget:self];
    [self setupTitle];
}
- (void)initData{
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.bg.frame = self.view.bounds;
}

- (void)addBackground{
    self.bg = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bg.image = [UIImage imageNamed:@"bg"];
    self.bg.alpha = 0.7f;
    [self.bg setContentMode:UIViewContentModeScaleAspectFill];
    [self.view insertSubview:self.bg atIndex:0];
    
}
- (void)setupTitle{
    UILabel* tlabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    tlabel.text=self.navigationItem.title;
    if (tlabel.text.length>10) {
        tlabel.numberOfLines = 2;
    }
    tlabel.textAlignment = NSTextAlignmentCenter;
    tlabel.textColor=CCOLOR_YELLOW;
    tlabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 20.0];
    tlabel.backgroundColor =[UIColor clearColor];
    tlabel.adjustsFontSizeToFitWidth=YES;
    self.navigationItem.titleView=tlabel;
}

- (void)pop{
    CPop;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)playYoutubeWithItem:(CAOEModel*)item{
    CPlayerVC *_playerVC = [[CPlayerVC alloc] initWithUrl:item.mURL];
    _playerVC.navigationItem.title = item.mTitle;
    CPushVC(_playerVC)
}

- (void)showLoading{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)dismissLoading{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
}
#pragma mark - ACTIONS
- (IBAction)bannerClicked:(id)sender{
    cc_openFacebook(CFBID_BANNER);
}
- (IBAction)btnVideoAdsClicked:(id)sender{
    [self confirmSeeVideoAd];
}
- (BOOL)confirmSeeVideoAd{
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [UIAlertView showWithTitle:@"Thu thập CCoin" message:[NSString stringWithFormat:@"Xem hết video để nhận được %d CCoin", CSetting.mAdsVideoReward] cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Xem"] tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
            if (buttonIndex==1) {
                [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
            }
        }];
        return YES;
    }else{
        [UIAlertView showWithTitle:@"Thu thập CCoin" message:@"Hiện tại không còn coin để thu thập" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
            ;
            [self loadGoogleVideoAd];
        }];
        return NO;
    }
}
#pragma mark - ADS
- (void)loadBannerAds:(int)index{
    if (!CSetting.mAdsBannerEnable) {
        return;
    }
    switch (CSetting.mAdsBannerSupplier) {
        case ADS_FACEBOOK:
            [self loadFacebookBannerAd:index?CSetting.mAdsBannerItem2:CSetting.mAdsBannerItem1];
            break;
        case ADS_GOOGLE:
            [self loadGoogleBannerAd:index?CSetting.mAdsBannerItem2:CSetting.mAdsBannerItem1];
            break;
        default:
            [self loadFacebookBannerAd:index?CSetting.mAdsBannerItem2:CSetting.mAdsBannerItem1];
            break;
    }
    
}
- (void)loadGoogleBannerAd:(NSString*)AdUnitId{
    self.bannerView = [[GADBannerView alloc]
                       initWithAdSize:GADAdSizeFromCGSize(ol_adsView.frame.size)];
    [ol_adsView addSubview:self.bannerView];
    self.bannerView.adUnitID = AdUnitId;// CADS_GG_UNITID_BANNER;
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
}
- (void)loadFacebookBannerAd:(NSString*)AdUnitId{
    FBAdView *adView = [[FBAdView alloc] initWithPlacementID:AdUnitId
                                                      adSize:kFBAdSize320x50
                                          rootViewController:self];
    adView.backgroundColor = [UIColor clearColor];
    //    FBAdView *adView =
    //    [[FBAdView alloc] initWithPlacementID:@"1907505446197455_1907511459530187"
    //                                   adSize:kFBAdSize320x50
    //                       rootViewController:self];
    adView.frame = CGRectMake(0, 0, adView.bounds.size.width, adView.bounds.size.height);
    
    //[ol_adsView addSubview:adView];
    adView.delegate = self;
    [FBAdSettings setLogLevel:FBAdLogLevelLog];
    [FBAdSettings addTestDevice:@"b602d594afd2b0b327e07a06f36ca6a7e42546d0"];
    [adView loadAd];
    //    [self.view addSubview:adView];
}
//video ads
- (void)loadVideoAds:(int)AdNumber{
    if (CSetting.mAdsVideoEnable) {
        [GADRewardBasedVideoAd sharedInstance].delegate = self;
        _adsVideoItem = AdNumber==1?CSetting.mAdsVideoItem1:CSetting.mAdsVideoItem2;
        [self loadGoogleVideoAd];
        [self updateCoin];
    }
}
- (void)loadFacebookVideoAd{
//    if (![[GADRewardBasedVideoAd sharedInstance] isReady]) {
//        GADRequest *_req = [GADRequest request];
//        [[GADRewardBasedVideoAd sharedInstance] loadRequest:_req
//                                               withAdUnitID:_adsVideoItem];
//    }
}
- (void)loadGoogleVideoAd{
    if (![[GADRewardBasedVideoAd sharedInstance] isReady]) {
        GADRequest *_req = [GADRequest request];
        [[GADRewardBasedVideoAd sharedInstance] loadRequest:_req
                                               withAdUnitID:_adsVideoItem];
    }
}
- (void)loadAdColony{
    [AdColony configureWithAppID:CSetting.mAdsVideoAppId zoneIDs:@[_adsVideoItem] options:nil completion:^(NSArray<AdColonyZone *> * _Nonnull zones) {
        ;
    }];
}
#pragma mark -
- (void)updateCoin{
    self.navigationItem.rightBarButtonItems = [CBarButtonItem coin:cc_getCoin() withtarget:self viewAdAction:@selector(btnVideoAdsClicked:)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)showWebViewUrl:(NSString*)urlStr{
    CWebVC *_webVC = [CWebVC new];
    _webVC.url = urlStr;
    _webVC.loadType = CWEBVIEW_TYPE_LOAD_URL;
//    [_webVC openWithURL:urlStr];
    CPushVC(_webVC)
}
//- (void)playYoutubeUrl:(NSString*)url{
//    
//    CPlayerVC *_vc = [CPlayerVC new];
//    [_vc playYoutubeVideoId:[url youtubeIdFromLink]];
//    [self.navigationController pushViewController:_vc animated:YES];
//}

#pragma mark - FB ADS DELEGATE
- (void)adView:(FBAdView *)adView didFailWithError:(NSError *)error
{
    NSLog(@"Ad failed to load");
}

- (void)adViewDidLoad:(FBAdView *)adView
{
    NSLog(@"Ad was loaded and ready to be displayed");
}

#pragma mark - GG ADS DELEGATE
- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward{
    int _coin = cc_getCoin();
    _coin+=CSetting.mAdsVideoReward;
    cc_setCoin(_coin);
    [self updateCoin];
}
///// Tells the delegate that the reward based video ad failed to load.
- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error{
    
}

/// Tells the delegate that a reward based video ad was received.
- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd{
    
}

///// Tells the delegate that the reward based video ad opened.
//- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd;
//
///// Tells the delegate that the reward based video ad started playing.
//- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd;
//
/// Tells the delegate that the reward based video ad closed.
- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd{
    
    [self loadGoogleVideoAd];
}

///// Tells the delegate that the reward based video ad will leave the application.
//- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd;


@end
