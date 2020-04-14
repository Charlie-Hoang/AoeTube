//
//  CWebVC.m
//  AlarmA
//
//  Created by Cuong Hoang on 5/25/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CWebVC.h"
#import "CSwapHTMLController.h"


@interface CWebVC (){
    
}

@end

@implementation CWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (!cc_isEmpty(self.url)) {
        if (self.loadType==CWEBVIEW_TYPE_LOAD_URL) {
            NSURLRequest *_req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
            [self.ol_webview loadRequest:_req];
        }else if(self.loadType==CWEBVIEW_TYPE_LOAD_HTMLSTR){
            [self loadHtmlContentWithURL:self.url];
        }
    }
    [self loadBannerAds:0];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.tabBarController.tabBar.hidden = NO;
    [super viewWillAppear:animated];
}

//- (void)openWithURL:(NSString*)urlStr{
//    url = urlStr;
////    [[CSwapHTMLController sharedInstance] getTableAsHtml:url success:^(NSString *response) {
////        [self.ol_webview loadHTMLString:response baseURL:[NSURL URLWithString:url]];
////    } failure:^(NSString *errorDes) {
////        ;
////    }];
//}
- (void)loadHtmlContentWithURL:(NSString*)urlStr{
    __block NSString *_htmContent;
    [self showLoading];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [[CSwapHTMLController sharedInstance] getNewsHtmlContent:urlStr success:^(NSString *response) {
        _htmContent = response;
        dispatch_group_leave(group);
    } failure:^(NSString *errorDes) {
        dispatch_group_leave(group);
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.ol_webview loadHTMLString:_htmContent baseURL:[NSURL URLWithString:urlStr]];
        [self dismissLoading];
    });
}
#pragma mark - UIWebViewDelegate
//------------------------------------------------------------------------------


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   
    // show activity
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    [self showLoading];
    
    return YES;
}

//	webview load finish
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //	stop activity
    CGSize contentSize = webView.scrollView.contentSize;
    CGSize viewSize = webView.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    webView.scrollView.minimumZoomScale = rw;
    webView.scrollView.maximumZoomScale = 2;
    webView.scrollView.zoomScale = rw;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    [self dismissLoading];
}

// webview load error
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // not internet
    if (error.code == NSURLErrorNotConnectedToInternet){
        // stop load request
        [self.ol_webview stopLoading];
        
        // show alert
        NSLog(NSLocalizedString(@"Error connection failed!", nil));
        
        // timeout
    }else if (error.code == NSURLErrorTimedOut){
        // stop load request
        [self.ol_webview stopLoading];
        
        // show alert
        NSLog(NSLocalizedString(@"Error connection failed!", nil));
    }
    
    //	stop activity
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    [self dismissLoading];
}

@end
