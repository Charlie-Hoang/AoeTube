//
//  CGamerVC.m
//  AlarmA
//
//  Created by Cuong Hoang on 5/30/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CGamerVC.h"
#import "CAOEModel.h"
#import "CAOECell.h"
#import "CAOETableVC.h"
#import "CSwapHTMLController.h"
#import "CFDBController.h"

@interface CGamerVC ()

@end

@implementation CGamerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchData];
    [self enableRefresh];
}
- (void)initData{
    [super initData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadAds) name:CNTF_GET_SETTING_DONE object:nil];
    if (CSetting.mAdsVideoEnable) {
        [self loadVideoAds:1];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
- (void)fetchData{
    [_arrData removeAllObjects];
    [[CFDBController sharedInstance] getGamersWithSuccess:^(NSArray *response) {
        _arrData = [NSMutableArray arrayWithArray:response];
        [self.ol_tableView reloadData];
    } failure:^(NSString *errorDes) {
        [self.ol_tableView reloadData];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CAOEModel *item = _arrData[indexPath.row];
    
    CAOETableVC *_vc = [CAOETableVC new];
    _vc.navigationItem.title = item.mTitle;
    _vc.tableType = TB_ITEM_TYPE_TABLE;
    [_vc loadDataWithUrl:item.mURL];
    [self.navigationController pushViewController:_vc animated:YES];

}
@end
