//
//  CTableVC.h
//  AlarmA
//
//  Created by Cuong Hoang on 5/25/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CBaseVC.h"

@interface CTableVC : CBaseVC{
    NSMutableArray *_arrData;
}
@property(strong, nonatomic)IBOutlet UITableView *ol_tableView;
@property(strong, nonatomic)NSString *mCellName;
- (void)setEmptyTableMessage:(NSString*)msg;
- (void)enableRefresh;
- (void)loadDataWithUrl:(NSString*)urlStr;
@end
