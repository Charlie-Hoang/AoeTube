//
//  CKeyboardToolbar.h
//  AOETube
//
//  Created by Cuong Hoang on 6/23/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKeyboardToolbar : UIToolbar
- (instancetype)initWithTarget:(id)target doneAction:(SEL)doneAction;
- (instancetype)initWithDefaultsAndTarget:(id)target;
@end
