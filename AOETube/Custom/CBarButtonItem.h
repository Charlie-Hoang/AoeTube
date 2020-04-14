//
//  CBarButtonItem.h
//  AOETube
//
//  Created by Cuong Hoang on 6/22/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBarButtonItem : UIBarButtonItem
+ (NSArray*)coin:(int)coin withtarget:(id)target viewAdAction:(SEL)viewAdAction;
@end
