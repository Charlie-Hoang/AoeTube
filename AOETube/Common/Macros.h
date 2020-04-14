//
//  Macros.h
//  Meema
//
//  Created by Cuong Hoang on 8/4/16.
//  Copyright © 2016 TSUNAMI. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define CNew(x)     [[x alloc] init]
#define CPush(x)    {UIViewController *vc = MNew(x); [self.navigationController pushViewController:vc animated:YES];}
#define CPushVC(vc) {[self.navigationController pushViewController:vc animated:YES];}
#define CPop        [self.navigationController popViewControllerAnimated:YES]

#define IS_IPHONE4 (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


#define XCODE_VERSION_GREATER_THAN_OR_EQUAL_TO_8    YES//__has_include(<UserNotifications/UserNotifications1.h>)
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define CAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]



#define CCOLOR_BRWON   [UIColor colorWithRed:102.f/255 green:0.f/255 blue:0.f/255 alpha:1.f]
#define CCOLOR_GREEN   [UIColor colorWithRed:0.f/255 green:102.f/255 blue:0.f/255 alpha:1.f]
#define CCOLOR_YELLOW  [UIColor yellowColor]

#define CSetting [CSettingController sharedInstance]
#define CApp    [UIApplication sharedApplication]
#endif /* Macros_h */
