//
//  CAds.h
//  AOETube
//
//  Created by Cuong Hoang on 7/12/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CADS_GOOGLE,
    CADS_FACEBOOK,
    CADS_ADCOLONY
}CADS_SUPPLIER;

@protocol CAdsDelegate;

@interface CAds : NSObject
@property (assign, nonatomic)CADS_SUPPLIER mAdsVideoSupplier;
@property (strong, nonatomic)NSString *mAdsVideoAppId;
@property (strong, nonatomic)NSArray *mAdsVideoItems;

@property (nonatomic, weak) id<CAdsDelegate> delegate;
+(instancetype)sharedInstance;
@end


@protocol CAdsDelegate <NSObject>
@optional
@end
