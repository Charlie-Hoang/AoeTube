//
//  CAOETableVC.h
//  AlarmA
//
//  Created by Cuong Hoang on 5/30/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//
typedef enum{
    TB_ITEM_TYPE_URL=0,
    TB_ITEM_TYPE_TABLE
}TB_ITEM_TYPE;

#import "CTableVC.h"

@interface CAOETableVC : CTableVC
- (id)initWithArrData:(NSArray*)arr;
@property(assign, nonatomic)TB_ITEM_TYPE tableType;
@end
