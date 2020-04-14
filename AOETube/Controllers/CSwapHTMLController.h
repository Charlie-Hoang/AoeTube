//
//  CSwapHTMLController.h
//  AlarmA
//
//  Created by Cuong Hoang on 5/29/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CRestSuccess)();
typedef void (^CRestSuccessArray)(NSArray*response);
typedef void (^CRestSuccessArrayWithLoadMore)(NSArray*response, int nextPage);
typedef void (^CRestSuccessString)(NSString*response);
typedef void (^CRestFailure)(NSString *errorDes);

@interface CSwapHTMLController : NSObject
+(instancetype)sharedInstance;
- (void)getNewsWithSuccess:(CRestSuccessArray)success failure:(CRestFailure)failure;
- (void)getMatch:(NSString*)url success:(CRestSuccessArray)success failure:(CRestFailure)failure;
- (void)getTableAsHtml:(NSString*)url success:(CRestSuccessString)success failure:(CRestFailure)failure;
- (void)getYoutubeLink:(NSString*)url success:(CRestSuccessString)success failure:(CRestFailure)failure;
- (void)getNewsHtmlContent:(NSString*)url success:(CRestSuccessString)success failure:(CRestFailure)failure;
@end
