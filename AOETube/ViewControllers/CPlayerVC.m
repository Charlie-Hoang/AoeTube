//
//  CPlayerVC.m
//  AlarmA
//
//  Created by Cuong Hoang on 6/8/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CPlayerVC.h"
#import "CSwapHTMLController.h"

@interface CPlayerVC ()<YTPlayerViewDelegate>{
    NSString *_pageUrl;
    NSString *_videoId;
}

@end

@implementation CPlayerVC
- (id)initWithUrl:(NSString*)urlStr{
    self = [super init];
    if (self) {
        _pageUrl = urlStr;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBannerAds:1];
    self.playerView.delegate = self;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadYoutubeVideo];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.tabBarController.tabBar.hidden = NO;
    [super viewWillAppear:animated];
}
- (void)loadYoutubeVideo{
    if ([_pageUrl containsString:@"youtube.com"]) {
        _videoId = [_pageUrl youtubeIdFromLink];
        [self playYoutubeVideoId:_videoId];
    }else{
        [self showLoading];
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_enter(group);
        [[CSwapHTMLController sharedInstance] getYoutubeLink:_pageUrl success:^(NSString *response) {
            _videoId = [response youtubeIdFromLink];
            dispatch_group_leave(group);
        } failure:^(NSString *errorDes) {
            dispatch_group_leave(group);
        }];
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            if (!cc_isEmpty(_videoId)) {
                [self playYoutubeVideoId:_videoId];
            }
            [self dismissLoading];
        });
    }
}
- (void)playYoutubeVideoId:(NSString*)videoId{
//    [self.playerView loadWithVideoId:_videoId playerVars:@{@"playsinline" : @YES,}];

    [self.playerView loadWithVideoId:_videoId];
}
- (void)playerView:(YTPlayerView *)playerView receivedError:(YTPlayerError)error{
    NSLog(@"play video error: %ld", (long)error);
    _ol_playError.hidden = NO;
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
