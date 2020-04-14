//
//  CNavigationVC.m
//  AlarmA
//
//  Created by Cuong Hoang on 6/13/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CNavigationVC.h"

@interface CNavigationVC ()

@end

@implementation CNavigationVC
+ (void)initialize
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav"]
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:
    @{NSForegroundColorAttributeName:CCOLOR_BRWON}];
    
    
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].barStyle = UIBarStyleBlackOpaque;

}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.hidesBarsWhenKeyboardAppears = YES;
    self.hidesBarsWhenVerticallyCompact = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
