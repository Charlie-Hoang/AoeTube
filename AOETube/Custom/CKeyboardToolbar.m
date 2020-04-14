//
//  CKeyboardToolbar.m
//  AOETube
//
//  Created by Cuong Hoang on 6/23/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CKeyboardToolbar.h"

@implementation CKeyboardToolbar

- (instancetype)initWithTarget:(id)target doneAction:(SEL)doneAction
{
    self = [super init];
    if (self) {
        self.barStyle = UIBarStyleDefault;
        [self sizeToFit];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:target action:nil];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Hide"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:target
                                                                      action:doneAction];
        
        [self setItems:@[flexSpace, doneButton] animated:YES];
    }
    
    return self;
}

- (instancetype)initWithDefaultsAndTarget:(id)target
{
    return [self initWithTarget:target
                     doneAction:NSSelectorFromString(@"dismissKeyboard")];
}

@end
