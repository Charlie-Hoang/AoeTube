//
//  CSwapHTMLController.m
//  AlarmA
//
//  Created by Cuong Hoang on 5/29/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "CSwapHTMLController.h"
#import "NSString+C.h"
#import "CAOEModel.h"

@implementation CSwapHTMLController
#pragma mark - INIT
+(instancetype)sharedInstance{
    static CSwapHTMLController *_sharedInstace = nil;
    static dispatch_once_t  _onceToken;
    dispatch_once(&_onceToken, ^{
        _sharedInstace = [[CSwapHTMLController alloc] init];
    });
    return _sharedInstace;
}
- (void)getNewsWithSuccess:(CRestSuccessArray)success failure:(CRestFailure)failure{
    NSMutableArray *_result = [NSMutableArray new];
//    NSURL *URL = [NSURL URLWithString:CURL_MAIN_PAGE];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:CURL_MAIN_PAGE] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *_webData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!_webData) {
            failure(@"No data");
        }
        NSString *_tmp = [_webData subStringFromString:@"<div class=\"tophot\">"];
        _tmp = [_tmp subStringToString:@"</div>"];
        NSArray *_items = [_tmp componentsSeparatedByString:@"<b><p"];
        for (NSString *item in _items) {
            if ([item isContainString:@"top-post-item"]) {
                CAOEModel *_model = [CAOEModel new];
                _model.mTitle = [item subStringFromString:@"title=\"" toString:@"\" href"];
                _model.mURL = [item subStringFromString:@"href=\"" toString:@"\">"];
                [_result addObject:_model];
            }
        }
        success(_result);
        //NSLog(@"_result : %@",_result);
    }]resume];
}

- (void)getMatch:(NSString*)url success:(CRestSuccessArray)success failure:(CRestFailure)failure{
    NSMutableArray *_result = [NSMutableArray new];
    //    NSURL *URL = [NSURL URLWithString:CURL_MAIN_PAGE];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *_webData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!_webData) {
            failure(@"No data");
        }
        NSString *_tmp = [_webData subStringFromString:@"table table-striped tablecat"];
        _tmp = [_tmp subStringToString:@"</table>"];
        NSArray *_items = [_tmp componentsSeparatedByString:@"<tr>"];
        for (NSString *item in _items) {
            if ([item isContainString:@"vtip"]) {
                CAOEModel *_model = [CAOEModel new];
                _model.mTitle = [item subStringFromString:@"title=\"" toString:@"\" href"];
                _model.mURL = [item subStringFromString:@"href=\"" toString:@"\">"];
                _model.mImage = [item subStringFromString:@"original=\"" toString:@"\" class"];
                [_result addObject:_model];
            }
        }
        success(_result);
        //NSLog(@"_result : %@",_result);
    }]resume];
}
- (void)getMatch2:(NSString*)url success:(CRestSuccessArrayWithLoadMore)success failure:(CRestFailure)failure{
    NSMutableArray *_result = [NSMutableArray new];
    //    NSURL *URL = [NSURL URLWithString:CURL_MAIN_PAGE];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *_webData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!_webData) {
            failure(@"No data");
        }
        NSString *_tmp = [_webData subStringFromString:@"table table-striped tablecat"];
        _tmp = [_tmp subStringToString:@"</table>"];
        NSArray *_items = [_tmp componentsSeparatedByString:@"<tr>"];
        for (NSString *item in _items) {
            if ([item isContainString:@"vtip"]) {
                CAOEModel *_model = [CAOEModel new];
                _model.mTitle = [item subStringFromString:@"title=\"" toString:@"\" href"];
                _model.mURL = [item subStringFromString:@"href=\"" toString:@"\">"];
                _model.mImage = [item subStringFromString:@"original=\"" toString:@"\" class"];
                [_result addObject:_model];
            }
        }
        success(_result, 1);
        //NSLog(@"_result : %@",_result);
    }]resume];
}
- (void)getTableAsHtml:(NSString*)url success:(CRestSuccessString)success failure:(CRestFailure)failure{
    __block NSString *_result;
    //    NSURL *URL = [NSURL URLWithString:CURL_MAIN_PAGE];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *_webData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!_webData) {
            failure(@"No data");
        }
        NSString *_tmp = [_webData subStringFromString:@"<table"];
        _tmp = [_tmp subStringToString:@"</table>"];
        _result = [NSString stringWithFormat:@"<html>%@</html>", _tmp];
        success(_result);
        //NSLog(@"_result : %@",_result);
    }]resume];
}
- (void)getYoutubeLink:(NSString*)url success:(CRestSuccessString)success failure:(CRestFailure)failure{
    __block NSString *_result;
    //    NSURL *URL = [NSURL URLWithString:CURL_MAIN_PAGE];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *_webData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!_webData) {
            failure(@"No data");
        }
        _result = [_webData subStringFromString:@"frameview\" src=\""];
        _result = [_result subStringToString:@"\" frameborder"];
        success(_result);
        //NSLog(@"_result : %@",_result);
    }]resume];
}
- (void)getNewsHtmlContent:(NSString*)url success:(CRestSuccessString)success failure:(CRestFailure)failure{
    __block NSString *_result;
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *_webData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!_webData) {
            failure(@"No data");
        }
        NSString *_tmp = [_webData subStringFromString:@"<div class=\"wappost\">"];
        _tmp = [_tmp subStringToString:@"</div>"];
        _result = [NSString stringWithFormat:@"<html>%@</html>", _tmp];
        success(_result);
        //NSLog(@"_result : %@",_result);
    }]resume];
}
@end
