//
//  CAOECell.h
//  AlarmA
//
//  Created by Cuong Hoang on 5/30/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CCell.h"
//@interface CLiveCellModel : NSObject
//@property(strong, nonatomic)NSString *mThumbnail;
//@property(strong, nonatomic)NSString *mTitle;
//@property(strong, nonatomic)NSString *mURL;
//@end
@class CLiveModel;
@interface CAOECell : CCell
@property(strong, nonatomic)IBOutlet UIImageView *ol_image;
@property(strong, nonatomic)IBOutlet UILabel *ol_title;
@property(strong, nonatomic)IBOutlet UILabel *ol_detail;
- (void)setupLiveCell:(CLiveModel*)cellInfo;
@end
