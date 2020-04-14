//
//  CSearchVC.m
//  AlarmA
//
//  Created by Cuong Hoang on 6/6/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CSearchVC.h"
#import "CAOETableVC.h"
#import "CAOECell.h"
#import "CAOEModel.h"

@interface CSearchVC ()<UISearchBarDelegate>{
//    IBOutlet UITextField *ol_search;
}

@end

@implementation CSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)initUI{
    [super initUI];
    [self setEmptyTableMessage:@"Hãy nhập từ khoá để tìm kiếm!"];
    //[ol_searchBar setInputAccessoryView:<#(UIView * _Nullable)#>]
//    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
//    [keyboardToolbar sizeToFit];
//    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
//                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
//                                      target:nil action:nil];
//    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
//                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                      target:self action:@selector(yourTextViewDoneButtonPressed)];
//    keyboardToolbar.items = @[flexBarButton, doneBarButton];
//    ol_search.inputAccessoryView = keyboardToolbar;
//    myToolbar = [[CKeyboardToolbar alloc] initWithDefaultsAndTarget:self];
    ol_searchBar.inputAccessoryView = myToolbar;
//    ol_search.inputAccessoryView = myToolbar;
}
- (void)initData{
    [super initData];
    if (CSetting.mAdsVideoEnable) {
        [self loadVideoAds:1];
    }
}

- (void)dismissKeyboard{
    [ol_searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)search{
    [ol_searchBar resignFirstResponder];
    NSString *_url = [NSString stringWithFormat:CURL_SEARCH_PAGE, ol_searchBar.text];
//    CAOETableVC *_vc = [CAOETableVC new];
    [self loadDataWithUrl:_url];
    [self setEmptyTableMessage:@"Không tìm thấy trận nào.\nhãy thử với keyword khác!"];
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
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
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
    
    CAOETableVC *_vc = [CAOETableVC new];
    _vc.tableType = TB_ITEM_TYPE_TABLE;
    [_vc loadDataWithUrl:item.mURL];
    CPushVC(_vc)
    
}
#pragma mark - SEARCH BAR
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self search];
}
@end
