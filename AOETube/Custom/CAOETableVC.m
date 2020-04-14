//
//  CAOETableVC.m
//  AlarmA
//
//  Created by Cuong Hoang on 5/30/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CAOETableVC.h"
#import "CAOECell.h"
#import "CAOEModel.h"
#import "CSwapHTMLController.h"
#import "CWebVC.h"
#import "CPlayerVC.h"


@interface CAOETableVC (){
    BOOL _isLoadAds;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ol_lay_tableBottom;

@end

@implementation CAOETableVC
- (id)initWithArrData:(NSArray*)arr{
    self = [super init];
    if(self){
        _arrData = [NSMutableArray arrayWithArray:arr];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"Your TiTle Text";
}
- (void)initUI{
    [super initUI];
    self.ol_tableView.tableFooterView = [UIView new];
    self.ol_tableView.showsVerticalScrollIndicator = NO;
    self.ol_tableView.showsHorizontalScrollIndicator = NO;
}
- (void)initData{
//    [self loadBannerAds:1];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.ol_tableView reloadData];
    if (CSetting.mAdsBannerEnable && !_isLoadAds) {
        if (self.ol_tableView.contentSize.height<([UIScreen mainScreen].bounds.size.height-64-49-50)) {
            [self loadBannerAds:0];
            _isLoadAds = YES;
            _ol_lay_tableBottom.constant = 49+50;
            [self.view setNeedsLayout];
        }
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - TABLE VIEW
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cell = @"CAOECell";
    
    CAOECell *cell = (CAOECell*)[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:Cell owner:self options:nil];
        cell = (CAOECell *)[nib objectAtIndex:0];
    }
    [cell setupCell:_arrData[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 5, 0, 5)];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CAOEModel *item = _arrData[indexPath.row];
    if(self.tableType==TB_ITEM_TYPE_TABLE){
        if ([item.mURL isContainString:@"video-aoe"]) {
            [self playYoutubeWithItem:item];
        }else{
            CAOETableVC *_vc = [CAOETableVC new];
            _vc.tableType = TB_ITEM_TYPE_TABLE;
            _vc.navigationItem.title = item.mTitle;
            [_vc loadDataWithUrl:item.mURL];
            CPushVC(_vc)
        }
    }else{
        [self showWebViewUrl:item.mURL];
    }
}
@end
