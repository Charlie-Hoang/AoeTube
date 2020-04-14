//
//  NSString+C.m
//  AlarmA
//
//  Created by Cuong Hoang on 5/29/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "NSString+C.h"

@implementation NSString(C)
- (BOOL)isEmpty
{
    return ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0);
}
- (NSString*)subStringFromString:(NSString*)subStr{
    NSRange range = [self rangeOfString:subStr];
    if (range.location != NSNotFound) {
        NSString *_tmp = [self substringFromIndex:range.location+range.length];
        return _tmp;
    } else {
        return nil;
    }
}
- (NSString*)subStringToString:(NSString*)subStr{
    NSRange range = [self rangeOfString:subStr];
    if (range.location != NSNotFound) {
        return [self substringToIndex:range.location];
    } else {
        return nil;
    }
}
- (NSString*)subStringFromString:(NSString *)fromStr toString:(NSString*)toStr{
    return [[self subStringFromString:fromStr] subStringToString:toStr];
}
- (BOOL)isContainString:(NSString*)searchStr{
    NSRange range = [self rangeOfString:searchStr];
    if (range.location != NSNotFound) {
        return YES;
    }else{
        return NO;
    }
}
- (NSString *)youtubeIdFromLink{
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    
    NSArray *array = [regExp matchesInString:self options:0 range:NSMakeRange(0,self.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
        return [self substringWithRange:result.range];
    }
    return nil;
}
@end
