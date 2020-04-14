//
//  AppDelegate.m
//  AlarmA
//
//  Created by Cuong Hoang on 5/24/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#import "AppDelegate.h"
#import "CSettingController.h"
#import "CSwapHTMLController.h"
#import "CFDBController.h"
#import "CWebVC.h"

@import Fabric;
@import Crashlytics;
@import FirebaseMessaging;

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@import UserNotifications;
#endif

// Implement UNUserNotificationCenterDelegate to receive display notification via APNS for devices
// running iOS 10 and above.
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@interface AppDelegate () <UNUserNotificationCenterDelegate, FIRMessagingDelegate>{
    
}

@end
#else
@interface AppDelegate () <FIRMessagingDelegate>{
    
}
@end
#endif

// Copied from Apple's header in case it is missing in some cases (e.g. pre-Xcode 8 builds).
#ifndef NSFoundationVersionNumber_iOS_9_x_Max
#define NSFoundationVersionNumber_iOS_9_x_Max 1299
#endif

@implementation AppDelegate

NSString *const kGCMMessageIDKey = @"gcm.message_id";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self test];
    [self initAppSetting];
    [self setupFabric];
    [self registerNotificationPermission:application];
    [self setupGoogleServices];
    [self termOfService];
    CSetting;
    return YES;
}
- (void)initAppSetting{
//    cc_deleteAccount();
//    cc_setMarkObject(cc_encryptString([NSString stringWithFormat:@"%d", 500]), CKEY_COIN);
    if (cc_getMarkInt(CKEY_FIRST_RUN)==0) {
        cc_setMarkInt(1, CKEY_FIRST_RUN);
        
        //cc_generateNewDeviceId();
        NSString *_deviceId = cc_getDeviceId();
        if (cc_isEmpty(_deviceId)) {
            cc_generateNewDeviceId();
            cc_setCoin(100);
        }
    }else{
        NSString *_coinDescrypted = cc_getMarkObject(CKEY_COIN);
        if (!cc_isEmpty(_coinDescrypted)) {
            int _currentCoin = [cc_decryptString(_coinDescrypted) intValue];
            cc_setCoin(_currentCoin);
            cc_removeMarkObject(CKEY_COIN);
            if (cc_getDeviceId().length!=8) {
                cc_generateNewDeviceId();
            }
        }
        
    }
    
}
- (void)test{
    NSString *a = @"0";
    NSString *x = cc_encryptString(a);
    NSString *y = cc_decryptString(x);
//    [FBAdSettings setLogLevel:FBAdLogLevelLog];
//    [FBAdSettings addTestDevice:@"HASHED_ID"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self checkVersion];

}

   
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - INIT
- (void)checkVersion{
    [CSetting getUpdateSettingWithSuccess:^{
        if ([CSetting.mNewestVersion compare:CAppVersion options:NSNumericSearch] == NSOrderedDescending){
            [UIAlertView showWithTitle:CSTR_AOETUBE message:CSetting.mUpdateMessage cancelButtonTitle:CSetting.mForceUpdate?nil:@"Cancel" otherButtonTitles:@[@"Cập nhật"] tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
                if (CSetting.mForceUpdate) {
                    cc_openItunesApp(CITUNES_APP_ID);
                }else{
                    if (buttonIndex==1) {
                        cc_openItunesApp(CITUNES_APP_ID);
                    }
                }
            }];
        }
    } failure:^(NSString *errorDes) {
        
    }];
}

- (void)setupFabric{
    [Fabric with:@[[Crashlytics class]]];
}
- (void)setupGoogleServices{
    [FIRApp configure];
    
    [[FIRAuth auth] signInWithEmail:CEMAIL_ANONYMOUS password:CPASSWORD_ANONYMOUS completion:^(FIRUser *user, NSError *error) {
        
        [FIRMessaging messaging].delegate = self;
        [self setupGoogleAnalytics];
        
    }];
//    [self loginFirebase];
    NSLog(@"token : %@", FIRInstanceID.instanceID.token);
}
- (void)loginFirebase{
    
}
- (void)setupGoogleAnalytics{
    [FIRAnalytics logEventWithName:kFIREventSelectContent
                        parameters:@{
                                     kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", @"test"],
                                     kFIRParameterItemName:@"test",
                                     kFIRParameterContentType:@"image"
                                     }];
}

- (void)registerNotificationPermission:(UIApplication*)application{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        // iOS 7.1 or earlier. Disable the deprecation warnings.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIRemoteNotificationType allNotificationTypes =
        (UIRemoteNotificationTypeSound |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeBadge);
        [application registerForRemoteNotificationTypes:allNotificationTypes];
#pragma clang diagnostic pop
    } else {
        // iOS 8 or later
        // [START register_for_notifications]
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
            UIUserNotificationType allNotificationTypes =
            (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
            UIUserNotificationSettings *settings =
            [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        } else {
            // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
            // For iOS 10 display notification (sent via APNS)
            [UNUserNotificationCenter currentNotificationCenter].delegate = self;
            UNAuthorizationOptions authOptions =
            UNAuthorizationOptionAlert
            | UNAuthorizationOptionSound
            | UNAuthorizationOptionBadge;
            [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
            }];
#endif
        }
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        // [END register_for_notifications]
    }
    
}
- (void)showTermOfService:(NSString*)message{
    [UIAlertView showWithTitle:@"Điều khoản sử dụng" message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
        ;
    }];
}
- (void)termOfService{
    NSString *key_terms = @"TERMS_OF_SERVICE";
    if (cc_getMarkInt(key_terms)!=1) {
        cc_setMarkInt(1, key_terms);
        [CSetting getSettingWithSuccess:^{
            if (CSetting.mReview==1) {
                [self showTermOfService:CSTR_TERM_OF_SERVICE];
            }
        } failure:^(NSString *errorDes) {
            [self showTermOfService:CSTR_TERM_OF_SERVICE];
        }];
    }
}
#pragma mark - Remote Notification
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    // If you are receiving a notification message while your app is in the background,
//    // this callback will not be fired till the user taps on the notification launching the application.
//    // TODO: Handle data of notification
//    
//    // With swizzling disabled you must let Messaging know about the message, for Analytics
//    // [[Messaging messaging] appDidReceiveMessage:userInfo];
//    
//    // Print message ID.
//    if (userInfo[kGCMMessageIDKey]) {
//        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
//    }
//    
//    // Print full message.
//    NSLog(@"%@", userInfo);
//}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[Messaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
//- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
//
//    [[FIRMessaging messaging] subscribeToTopic:@"news"];
//    NSLog(@"Subscribed to news topic");
//}
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// Handle incoming notification messages while app is in the foreground.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[Messaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionNone);
}

// Handle notification messages after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler();
}
#endif
// [END ios_10_message_handling]

// [START refresh_token]
- (void)messaging:(nonnull FIRMessaging *)messaging didRefreshRegistrationToken:(nonnull NSString *)fcmToken {
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSLog(@"FCM registration token: %@", fcmToken);
    
    // TODO: If necessary send token to application server.
}
// [END refresh_token]

// [START ios_10_data_message]
// Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
// To enable direct data messages, you can set [Messaging messaging].shouldEstablishDirectChannel to YES.
- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
    NSLog(@"Received data message: %@", remoteMessage.appData);
}
// [END ios_10_data_message]

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Unable to register for remote notifications: %@", error);
}

// This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
// If swizzling is disabled then this function must be implemented so that the APNs device token can be paired to
// the FCM registration token.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"APNs device token retrieved: %@", deviceToken);
//    [[FIRMessaging messaging] setAPNSToken:deviceToken type:FIRMessagingAPNSTokenTypeSandbox];
//    [[FIRMessaging messaging] setAPNSToken:deviceToken type:FIRMessagingAPNSTokenTypeProd];
    [[FIRMessaging messaging] setAPNSToken:deviceToken];
    // With swizzling disabled you must set the APNs device token here.
    // [Messaging messaging].APNSToken = deviceToken;
}
@end
