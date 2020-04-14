//
//  CAOECell.m
//  AlarmA
//
//  Created by Cuong Hoang on 5/30/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CAOECell.h"
#import "CAOEModel.h"
#import "CSettingController.h"



@implementation CAOECell


- (void)setupCell:(id)cellInfo{
    CAOEModel *info = (CAOEModel*)cellInfo;
    _ol_title.text = info.mTitle;
    _ol_title.textColor = CCOLOR_BRWON;
    if (!cc_isEmpty(info.mImage)) {
        [_ol_image sd_setImageWithURL:[NSURL URLWithString:info.mImage] placeholderImage:nil];
    }else if ([info.mURL containsString:@"video-tran"]) {
        [_ol_image setImage:[UIImage imageNamed:@"video.jpg"]];
    }else{
        [_ol_image setImage:[UIImage imageNamed:@"news"]];
    }
    //fix white color on ipad
    self.backgroundColor = self.contentView.backgroundColor;
}
- (void)setupLiveCell:(CLiveModel*)cellInfo{
    [self setupCell:cellInfo];
    if (CSetting.mCoinEnable) {
        _ol_detail.hidden = NO;
        if(cellInfo.mPrice==0){
            _ol_detail.textColor = CCOLOR_GREEN;
            _ol_detail.text = @"Free";
        }else if (cellInfo.mBuy) {
            _ol_detail.textColor = CCOLOR_GREEN;
            _ol_detail.text = @"Xem";
        }else{
            _ol_detail.textColor = CCOLOR_BRWON;
            _ol_detail.text = [NSString stringWithFormat:@"%d CCoin", cellInfo.mPrice];
        }
    }else{
        _ol_detail.hidden = YES;
    }
    
}
@end
