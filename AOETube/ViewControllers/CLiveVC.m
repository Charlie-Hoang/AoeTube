//
//  CLiveVC.m
//  AlarmA
//
//  Created by Cuong Hoang on 5/24/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CLiveVC.h"
#import "CAOECell.h"
#import "CAOEModel.h"
#import "CWebVC.h"
#import "CFDBController.h"
#import "CSettingController.h"


@interface CLiveVC ()<UIAlertViewDelegate>{
//    NSMutableArray *_arrBuy;
//    CLiveModel *_selectedModel;
    
}

@end

@implementation CLiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)initUI{
    [super initUI];
    
    [self enableRefresh];
    [self setEmptyTableMessage:@"Hiện tại không có kèo đấu nào.\nVào mục \"Hot\" để xem thông tin kèo đấu!"];
}
- (void)initData{
    [super initData];
    [self fetchData];
    if (CSetting.mAdsVideoEnable) {
        [self loadVideoAds:2];
    }
//    NSString *_htmContent = @"<html><body><script type=\"text/javascript\" src = \"http://free-shoutbox.net/app/webroot/shoutbox/sb.php?shoutbox=79033388\"></script></body></html>";
//    [self.ol_webview loadHTMLString:_htmContent baseURL:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)fetchData{
    
    [[CFDBController sharedInstance] getLivesWithSuccess:^(NSArray *response) {
        _arrData = [NSMutableArray arrayWithArray:response];
        _arrData = [self updateBuyState:_arrData];
//        [self checkCoinEnable];
        [self.ol_tableView reloadData];
    } failure:^(NSString *errorDes) {
        [self.ol_tableView reloadData];
    }];
}
- (NSMutableArray*)updateBuyState:(NSMutableArray*)inputArr{
    if (CSetting.mCoinEnable) {
        for (int i= 0; i<inputArr.count; i++) {
            CLiveModel *item = inputArr[i];
            if (cc_isBuyItem(item.mId)) {
                item.mBuy = YES;
                [inputArr replaceObjectAtIndex:i withObject:item];
            }
        }
    }
    return inputArr;
}
- (void)checkCoinEnable{
    if (CSetting.mCoinEnable) {
        for (int i= 0; i<_arrData.count; i++) {
            CLiveModel *item = _arrData[i];
            item.mBuy = YES;
            [_arrData replaceObjectAtIndex:i withObject:item];
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    [self performSelector:@selector(pushDetail)];
}
#pragma mark = ACTION
//- (IBAction)chat:(id)sender{
////    NSString *_chatUrl = @"http://www.free-shoutbox.net/app/webroot/shoutbox/viewshoutbox.php?shoutbox=79033388&amp;disable=0&amp;width=320&amp;height=480&amp;samples=0&amp;transparency=100&amp;scroll=1&amp;radius=110";
////    [self showWebViewUrl:_chatUrl];
//    CChatVC *_chatVC = [CChatVC new];
//    CPushVC(_chatVC);
//    
//}
#pragma mark - TABLEVIEW
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cell = @"CAOECell";
    
    CAOECell *cell = (CAOECell*)[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:Cell owner:self options:nil];
        cell = (CAOECell *)[nib objectAtIndex:0];
    }
    [cell setupLiveCell:_arrData[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLiveModel *_item = _arrData[indexPath.row];
    void (^buy)(void) = ^(void){
        int coin = cc_getCoin();
        if (coin<_item.mPrice) {
            //ko du coin
            [UIAlertView showWithTitle:CSTR_AOETUBE message:@"Bạn không còn đủ coin! ^^" cancelButtonTitle:@"Cancel" otherButtonTitles:nil tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
                
            }];
        }else{
            coin-=_item.mPrice;
            cc_setCoin(coin);
            [self updateCoin];
            _item.mBuy = YES;
            cc_buyItem(_item.mId);
            [_arrData replaceObjectAtIndex:indexPath.row withObject:_item];
            [self.ol_tableView reloadData];
        }
        
    };
    void (^watchLive)(void) = ^(void){
        if ([_item.mURL containsString:@"youtube.com"]) {
            [self playYoutubeWithItem:_item];
        }else{
            CWebVC *_webVC = [CWebVC new];
            _webVC.url = _item.mURL;
            _webVC.loadType = CWEBVIEW_TYPE_LOAD_URL;
            [self.navigationController pushViewController:_webVC animated:YES];
            
        }
    };
    if (_item.mBuy||_item.mPrice<=0) {
        watchLive();
    }else{
        [UIAlertView showWithTitle:CSTR_AOETUBE message:[NSString stringWithFormat:@"Xem kèo này sẽ mất %d CCoin", _item.mPrice] cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Mua"] tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
            if (buttonIndex==1) {
                buy();
            }
        }];
    }
//    dispatch_async(dispatch_get_main_queue(),^{
//        [UIAlertView showWithTitle:CSTR_AOETUBE message:[NSString stringWithFormat:@"Xem kèo này sẽ mất %d CCoin", _item.mPrice] cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Xem"] tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
//            if (buttonIndex==1) {
////                [self performSelector:@selector(pushDetail)];
////                watchLive();
//            }
//        }];
//    });
    
    
//    watchLive();
//    if ([_arrEnableAds[indexPath.row] isEqualToString:@"1"]) {
//        watchLive();
//    }else{
//        if ([self showVideoAd]) {
//            [UIAlertView showWithTitle:CSTR_AOETUBE message:@"Xem video quảng cáo trước khi xem kèo?" cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Xem"] tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
//                if (buttonIndex==1) {
//                    [self showVideoAd];
//                    [_arrEnableAds replaceObjectAtIndex:indexPath.row withObject:@"1"];
//                }
//            }];
//        }else{
//            watchLive();
//        }
//    }
}

@end
