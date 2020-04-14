//
//  CNewsVC.m
//  AlarmA
//
//  Created by Cuong Hoang on 5/24/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CNewsVC.h"
#import "CSwapHTMLController.h"
#import "CWebVC.h"
#import "CAOETableVC.h"
#import "CAOECell.h"
#import "CAOEModel.h"
#import "CFDBController.h"
#import "CBarButtonItem.h"
#import "CSettingController.h"
#import "CTabbarVC.h"
@import FirebaseDatabase;
@import Firebase;
@interface CNewsVC ()

@property (strong, nonatomic) IBOutlet UITextField *txt;
@end

@implementation CNewsVC

//- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        if (IS_OS_7_OR_LATER) {
////            [self.tabBarItem setImage:[[UIImage imageNamed:@"tabbar_off_0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
////            [self.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_on_0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//        }
//    }
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)initData{
    [super initData];
//    [self showLoading];
    [MBProgressHUD showHUDAddedTo:[self tabbarVC].view animated:YES];
    [self enableRefresh];
    
    [self checkCoinEnable];
    [self fetchData];
}
- (void)initUI{
    [super initUI];
}
- (CTabbarVC*)tabbarVC{
    return (CTabbarVC*)[[[UIApplication sharedApplication] delegate] window].rootViewController;
}
- (void)dismissLoading{
    [MBProgressHUD hideHUDForView:[self tabbarVC].view animated:NO];
    [self tabbarVC];
}
- (void)checkAds{
    [CSetting getAdsSettingWithSuccess:^{
        if (CSetting.mAdsBannerEnable || CSetting.mAdsVideoEnable) {
            [GADMobileAds configureWithApplicationID:CSetting.mAdsBannerAppId];
            NSLog(@"appid:%@", CSetting.mAdsBannerAppId);
        }
//        if (CSetting.mAdsBannerEnable) {
//            [self loadBannerAds];
//        }
        if (CSetting.mAdsVideoEnable){
            [self loadVideoAds:1];
        }
        [self getPopup];
        [self dismissLoading];
    } failure:^(NSString *errorDes) {
        [self dismissLoading];
        ;
    }];
}
- (void)checkCoinEnable{
    [CSetting getSettingWithSuccess:^{
        if (CSetting.mCoinEnable) {
            [self updateCoin];
            [self checkAds];
        }else{
            [self dismissLoading];
        }
    } failure:^(NSString *errorDes) {
        [self dismissLoading];
    }];

}

- (void)fetchData{
//    [self showLoading];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [[CSwapHTMLController sharedInstance] getNewsWithSuccess:^(NSArray *response) {
        _arrData = [NSMutableArray arrayWithArray:response];
        dispatch_group_leave(group);
    } failure:^(NSString *errorDes) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.ol_tableView reloadData];
//        [self dismissLoading];
    });
}
- (void)getPopup{
    
    [[CFDBController sharedInstance] getPopupMesseageWithSuccess:^(NSDictionary *response) {
        if ([response[@"enable"] intValue]==1) {
            [UIAlertView showWithTitle:response[@"title"] message:response[@"message"] cancelButtonTitle:@"Cancel" otherButtonTitles:@[response[@"okbtnTitle"]] tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
                if (buttonIndex==1) {
                    if ([response[@"opensafari"] intValue]==0) {
                        [self showWebViewUrl:response[@"url"]];
                    }else{
                        cc_openURL(response[@"url"]);
                    }
                }
                
            }];
        }
        
        [self dismissLoading];
        
    } failure:^(NSString *errorDes) {
        [self dismissLoading];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)writeFirebase:(id)sender{
    //[_ref setValue:@[@"item1", @"item2"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CAOEModel *item = _arrData[indexPath.row];
    if (![item.mURL containsString:@"video-tran"]) {
        if (!CSetting.mReview) {
            CWebVC *_webVC = [CWebVC new];
            _webVC.url = item.mURL;
            _webVC.loadType = CWEBVIEW_TYPE_LOAD_HTMLSTR;
            //        [_webVC loadHtmlContentWithURL:item.mURL];
            CPushVC(_webVC)

        }else{
            [UIAlertView showWithTitle:CSTR_AOETUBE message:item.mTitle cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
                ;
            }];
        }
//        [[CFDBController sharedInstance] getSettingWithSuccess:^(NSDictionary *response) {
//            if ([response[@"review"] intValue]==0) {
//                CWebVC *_webVC = [CWebVC new];
//                _webVC.url = item.mURL;
//                _webVC.loadType = CWEBVIEW_TYPE_LOAD_HTMLSTR;
//                //        [_webVC loadHtmlContentWithURL:item.mURL];
//                CPushVC(_webVC)
//            }else{
//                [UIAlertView showWithTitle:CSTR_AOETUBE message:item.mTitle cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
//                    ;
//                }];
//            }
//        } failure:^(NSString *errorDes) {
//            ;
//        }];
    }else{
        CAOETableVC *_vc = [CAOETableVC new];
        _vc.navigationItem.title = item.mTitle;
        
        _vc.tableType = TB_ITEM_TYPE_TABLE;
        [_vc loadDataWithUrl:item.mURL];
        CPushVC(_vc)

    }
}
@end
