//
//  CAOEModel.h
//  AlarmA
//
//  Created by Cuong Hoang on 5/30/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CModel.h"

@interface CAOEModel : CModel
@property(assign, nonatomic)BOOL mEnable;
@property(strong, nonatomic)NSString *mTitle;
@property(strong, nonatomic)NSString *mURL;
@property(strong, nonatomic)NSString *mImage;
@property(strong, nonatomic)NSString *mDescription;
@end

@interface CLiveModel : CAOEModel
@property(strong, nonatomic)NSString *mId;
@property(assign, nonatomic)int mPrice;
@property(assign, nonatomic)BOOL mBuy;
@end

@interface CGamerModel : CAOEModel

@end
