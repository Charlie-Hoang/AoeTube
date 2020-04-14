//
//  CPlayerVC.h
//  AlarmA
//
//  Created by Cuong Hoang on 6/8/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CBaseVC.h"
#import "YTPlayerView.h"

@interface CPlayerVC : CBaseVC
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property(nonatomic, strong) IBOutlet UILabel *ol_playError;
- (id)initWithUrl:(NSString*)urlStr;
- (void)playYoutubeVideoId:(NSString*)videoId;
@end
