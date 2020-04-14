//
//  CWebVC.h
//  AlarmA
//
//  Created by Cuong Hoang on 5/25/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//
typedef enum {
    CWEBVIEW_TYPE_LOAD_URL,
    CWEBVIEW_TYPE_LOAD_HTMLSTR
}CWEBVIEW_TYPE_LOAD;
#import "CBaseVC.h"

@interface CWebVC : CBaseVC
@property(strong, nonatomic)IBOutlet UIWebView *ol_webview;
@property(assign, nonatomic)CWEBVIEW_TYPE_LOAD loadType;
@property(strong, nonatomic)NSString *url;
//- (void)openWithURL:(NSString*)urlStr;
//- (void)loadHtmlContentWithURL:(NSString*)urlStr;
@end
