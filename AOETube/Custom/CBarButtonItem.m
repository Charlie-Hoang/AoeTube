//
//  CBarButtonItem.m
//  AOETube
//
//  Created by Cuong Hoang on 6/22/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CBarButtonItem.h"

@implementation CBarButtonItem
- (instancetype)initWithButtonImage:(UIImage*)image target:(id)target action:(SEL)action
{
    UIButton* _bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [_bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [_bt setImage:image forState:UIControlStateNormal];
    self = [super initWithCustomView:_bt];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithButtonString:(NSString*)str target:(id)target action:(SEL)action
{
    UIButton* _bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 25)];
    [_bt setTitleColor:CCOLOR_YELLOW forState:UIControlStateNormal];
    _bt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [_bt setTitle:str forState:UIControlStateNormal];
    [_bt sizeToFit];
    self = [super initWithCustomView:_bt];
    if (self) {
        
    }
    return self;
}
- (instancetype)initCointNumberButton:(int)coin target:(id)target action:(SEL)action
{
    NSString* str = [NSString stringWithFormat:@"%d", coin];
    self = [self initWithButtonString:str target:target action:action];
    if (self) {
        
    }
    return self;
}

- (instancetype)initCoinButtontarget:(id)target action:(SEL)action
{
    UIImage* searchImage = [UIImage imageNamed:@"coin"];
    self = [self initWithButtonImage:searchImage target:target action:action];
    if (self) {
        
    }
    return self;
}
+ (NSArray*)coin:(int)coin withtarget:(id)target viewAdAction:(SEL)viewAdAction
{
    CBarButtonItem *_coin = [[CBarButtonItem alloc]  initCointNumberButton:coin target:target action:viewAdAction];
    CBarButtonItem *_img = [[CBarButtonItem alloc] initCoinButtontarget:target action:viewAdAction];
    CBarButtonItem* gap = [[CBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    MMBarButtonItem* notificationItem = [[MMBarButtonItem alloc] initNotificationButtontarget:target action:notifyAction];
//    MMBarButtonItem* gap1 = [[MMBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    gap1.width = 20.0f;
//    MMBarButtonItem* gap2 = [[MMBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    gap2.width = 5.0f;
//    if (blind) {
//        [target performSelector:@selector(blindCoin:) withObject:_img afterDelay:0.5];
//    }
    return @[_img, _coin];
}

@end
