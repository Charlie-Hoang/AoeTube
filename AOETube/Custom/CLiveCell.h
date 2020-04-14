//
//  CLiveCell.h
//  AlarmA
//
//  Created by Cuong Hoang on 5/24/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CCell.h"
@interface CLiveCellModel : NSObject
@property(strong, nonatomic)NSString *mThumbnail;
@property(strong, nonatomic)NSString *mTitle;
@property(strong, nonatomic)NSString *mURL;
@end

@interface CLiveCell : CCell
@property(strong, nonatomic)IBOutlet UIImageView *ol_thumbnail;
@property(strong, nonatomic)IBOutlet UILabel *ol_title;
@end
