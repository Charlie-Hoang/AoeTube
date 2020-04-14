//
//  CSettingVC.m
//  AlarmA
//
//  Created by Cuong Hoang on 6/14/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CSettingVC.h"
#import "C2LabelCell.h"
#import "Appirater.h"
#import <MobileCoreServices/MobileCoreServices.h>
@import Social;
static NSString *const AppGroupId = @"group.com.chick";
@interface CSettingVC (){
    NSArray *_arrAbout;
    
}

@end

@implementation CSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrAbout = @[@[@"Facebook", @"facebook.com/aoetube"], @[@"User ID", cc_getDeviceId()], @[@"Review App",@""], @[@"Chia sẻ ứng dụng",@""], @[@"Version",CAppVersion]];
//    _arrData = [NSMutableArray arrayWithArray:@[]];
}
- (void)initData{
    [super initData];
    if (CSetting.mAdsVideoEnable) {
        [self loadVideoAds:2];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TABLEVIEW
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrAbout.count;
}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UILabel *_header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
//    
//    _header.text = @"Thông tin";
//    _header.textColor = CCOLOR_GREEN;
//    return _header;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 20.f;
//}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (section==0) {
//        return @"Thông tin";
//    }
//    return nil;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cell = @"C2LabelCell";
    
    C2LabelCell *cell = (C2LabelCell*)[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:Cell owner:self options:nil];
        cell = (C2LabelCell *)[nib objectAtIndex:0];
    }
    [cell setupCell:_arrAbout[indexPath.row]];
    if (indexPath.row==_arrAbout.count-1) {
        cell.userInteractionEnabled = NO;
    }else{
        cell.userInteractionEnabled = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            cc_openFacebook(CFBID_PAGE);
            break;
        case 1:
            
            [self copyUserId];
            break;
        case 2:
            [self reviewApp];
            break;
        case 3:
            [self share];
            break;
        default:
            break;
    }
}
- (void)copyUserId{
    [UIAlertView showWithTitle:nil message:@"Copy User ID" cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Copy"] tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
        if (buttonIndex==1) {
            NSString *_userId = _arrAbout[1][1];
            UIPasteboard *pb = [UIPasteboard generalPasteboard];
            [pb setString:_userId];
        }
    }];
}
- (IBAction)bannerClicked:(id)sender{
    cc_openFacebook(CFBID_BANNER);
}
- (void)share{
    NSString *textToShare = [NSString stringWithFormat:@"Xem video và livestream miễn phí với %@", CSTR_AOETUBE];
    NSURL *myWebsite = [NSURL URLWithString:CURL_ITUNES];
    UIImage *image = [UIImage imageNamed:@"icon"];
    
    NSArray *objectsToShare = @[textToShare, myWebsite, image];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypePrint,
                                   UIActivityTypePostToVimeo,
                                   UIActivityTypePostToWeibo,
                                   UIActivityTypeOpenInIBooks,
                                   UIActivityTypePostToTencentWeibo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}
- (void)reviewApp{
    // Setup app rate
    [Appirater setAppId:@"1251530593"];
    
    /* --- Condition---
     */
    // has been used 7 days
    //[Appirater setDaysUntilPrompt:7];
    //[Appirater setUsesUntilPrompt:1];
    
    
    // time reminding when click rate later
    [Appirater setTimeBeforeReminding:30];
    
    [Appirater setDebug:YES];
    [Appirater appLaunched:YES];
}
@end
