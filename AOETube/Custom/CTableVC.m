//
//  CTableVC.m
//  AlarmA
//
//  Created by Cuong Hoang on 5/25/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CTableVC.h"
#import "CAOECell.h"
#import "CSwapHTMLController.h"
#import "UITableView+DynamicCell.h"

@interface CTableVC ()<UITableViewDynamicDelegate>{
    
}
@property(strong, nonatomic)UILabel *lb_empty;
@end

@implementation CTableVC
@synthesize mCellName;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
- (void)initUI{
    [super initUI];
    [self addBackground];
    self.ol_tableView.tableFooterView = [UIView new];
    self.ol_tableView.backgroundColor = [UIColor clearColor];
}
- (void)initData{
    [super initData];
    _arrData = [NSMutableArray new];
}
- (void)fetchData{
    
}
- (void)fetchLoadMore:(CRestSuccess)success{
    
}
- (void)enableRefresh{
    self.ol_tableView.refreshDelegate = self;
    self.ol_tableView.enabledRefresh = YES;
}
- (void)enableLoadMore{
    self.ol_tableView.enabledLoadMore = YES;
}
- (void)setEmptyTableMessage:(NSString*)msg{
    if (self.lb_empty) {
        [self.lb_empty removeFromSuperview];
    }
    self.lb_empty = [UILabel autoLayoutView];
    self.lb_empty.text = msg;
    self.lb_empty.numberOfLines = 2;
    self.lb_empty.textAlignment = NSTextAlignmentCenter;
    self.lb_empty.textColor = CCOLOR_BRWON;
    self.lb_empty.font = [UIFont systemFontOfSize:16.f];
    
    [self.view insertSubview:self.lb_empty aboveSubview:self.ol_tableView];
    [self.lb_empty centerInContainer];
    self.lb_empty.hidden = YES;
}
#pragma mark - LOAD DATA
- (void)loadDataWithUrl:(NSString*)urlStr{
    [self showLoading];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [[CSwapHTMLController sharedInstance] getMatch:urlStr success:^(NSArray *response) {
        _arrData = [NSMutableArray arrayWithArray:response];
        dispatch_group_leave(group);
    } failure:^(NSString *errorDes) {
        dispatch_group_leave(group);
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.ol_tableView reloadData];
        [self dismissLoading];
    });
}
#pragma mark - TABLEVIEW
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.lb_empty) {
        if (_arrData.count==0) {
            self.lb_empty.hidden = NO;
        }else{
            self.lb_empty.hidden = YES;
        }
    }
    
    return _arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cell = @"CAOECell";
    
    CAOECell *cell = (CAOECell*)[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:Cell owner:self options:nil];
        cell = (CAOECell *)[nib objectAtIndex:0];
    }
    [cell setupCell:_arrData[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - TABLE REFRESH
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.ol_tableView scrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.ol_tableView checkToReload];
}
-(void)refreshData:(UITableView *)tableView completion:(RefreshCompletion)completion{
    
    //TODO:do some task needs many time to finish. After finish it, call completion block
    
    //Some codes below is an example
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self fetchData];
        completion();
    });
}
-(void)loadMoreData:(UITableView *)tableView completion:(RefreshCompletion)completion{
    
    //TODO:do some task needs many time to finish. After finish it, call completion block
    
    //Some codes below is an example
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self fetchLoadMore:^{
            completion();
        }];
    });
}
@end
