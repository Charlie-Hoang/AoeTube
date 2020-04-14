//
//  CMatchCell.m
//  AlarmA
//
//  Created by Cuong Hoang on 5/29/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CMatchCell.h"

@implementation CMatchCell
- (void)setupCell:(id)cellInfo{
    CMatchCellModel *info = (CMatchCellModel*)cellInfo;
    _ol_title.text = info.mTitle;
}
@end
