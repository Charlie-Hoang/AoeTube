//
//  CLiveCell.m
//  AlarmA
//
//  Created by Cuong Hoang on 5/24/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CLiveCell.h"
#import "UIImageView+WebCache.h"
@implementation CLiveCellModel
@end

@implementation CLiveCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setupCell:(id)cellInfo{
    CLiveCellModel *info = (CLiveCellModel*)cellInfo;
    _ol_title.text = info.mTitle;
}
@end
