//
//  C2LabelCell.m
//  AOETube
//
//  Created by Cuong Hoang on 6/20/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "C2LabelCell.h"

@implementation C2LabelCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setupCell:(id)cellInfo{
    NSArray *_info = (NSArray*)cellInfo;
    self.ol_title.text = _info[0];
    self.ol_value.text = _info[1];
    self.ol_title.textColor = CCOLOR_BRWON;
    self.ol_value.textColor = CCOLOR_BRWON;
    //fix white color on ipad
    self.backgroundColor = self.contentView.backgroundColor;
//    self.tintColor = CCOLOR_GREEN;
}
@end
