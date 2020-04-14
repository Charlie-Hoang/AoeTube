//
//  NSString+C.h
//  AlarmA
//
//  Created by Cuong Hoang on 5/29/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(C)
- (BOOL)isEmpty;
- (NSString*)subStringFromString:(NSString*)subStr;
- (NSString*)subStringToString:(NSString*)subStr;
- (NSString*)subStringFromString:(NSString *)fromStr toString:(NSString*)toStr;
- (BOOL)isContainString:(NSString*)searchStr;
- (NSString *)youtubeIdFromLink;
@end
