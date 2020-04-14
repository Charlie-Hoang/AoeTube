//
//  CTabbarVC.m
//  AlarmA
//
//  Created by Cuong Hoang on 6/13/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CTabbarVC.h"

@interface CTabbarVC ()

@end

@implementation CTabbarVC
+ (void)initialize
{
    //the color for the text for unselected tabs
    [UITabBarItem.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : CCOLOR_BRWON}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : CCOLOR_GREEN}
                                             forState:UIControlStateSelected];
    //the color for selected icon
    //[[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAppearence];
}
- (void)setupAppearence{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.tabBar.barStyle=UIBarStyleDefault;
        self.tabBar.translucent = YES;
    }
//    NSArray *_tabbarTitles = @[@"News", @"Live", @"Gammer", @"Search", @"Setting"];
    for (UITabBarItem *item in self.tabBar.items) {
        NSInteger _index = [self.tabBar.items indexOfObject:item];
//        [item setTitle:_tabbarTitles[_index]];
        [item setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_off_%ld", (long)_index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item setSelectedImage:[[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_on_%ld", (long)_index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    
}


@end
