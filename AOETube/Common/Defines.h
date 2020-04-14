//
//  Defines.h
//  AlarmA
//
//  Created by Cuong Hoang on 5/30/17.
//  Copyright © 2017 Cuong Hoang. All rights reserved.
//

#ifndef Defines_h
#define Defines_h
#define ENVIRONMETN_DEBUG 0
#define ENVIRONMETN_RELEASE 1
#define ENVIRONMENT ENVIRONMETN_DEBUG


#define CHOST   1//1:cohet 2:cs

#if CHOST
    #define CURL_MAIN_PAGE      @"http://cohet.org/"
    #define CURL_SEARCH_PAGE    @"http://cohet.org/tag/%@"
#else
    #define CURL_MAIN_PAGE      @"http://chimsedinang.com"
    #define CURL_SEARCH_PAGE    @"http://chimsedinang.com/tim-kiem/?kw=%@"
#endif

#define CCOIN_START             100
#define CEMAIL_ANONYMOUS        @"firebase@gmail.com"
#define CPASSWORD_ANONYMOUS     @"123456"

//#define CADS_GG_APPID           @"ca-app-pub-7216886744183571~3504900445"
//#define CADS_GG_APPID           @"ca-app-pub-4242168753469659~4730954922"
//#define CADS_GG_UNITID_BANNER   @"ca-app-pub-7216886744183571/6458366846"
//#define CADS_GG_UNITID_BANNER   @"ca-app-pub-4242168753469659/5869610922"
//#define CADS_GG_UNITID_VIDEO    @"ca-app-pub-7216886744183571/1276130846"
//#define CADS_GG_UNITID_VIDEO    @"ca-app-pub-4242168753469659/6207688120"
//#define CADS_FB_PLACEMENTID     @"1751565961539720_1751577638205219"

#define CURL_ITUNES             @"https://itunes.apple.com/us/app/aoetube/id1251530593?ls=1&mt=8"
#define CURL_FB_PAGE            @"https://www.facebook.com/aoetube/"
#define CURL_FB_BANNER          @"https://www.facebook.com/tat.giay.tay/"
#define CFBID_PAGE              @"148654519014349"
#define CFBID_BANNER            @"1425202877737386"

#define CITUNES_APP_ID          @"1251530593"

#define CSTR_AOETUBE            @"Chế Tube"
#define CSTR_TERM_OF_SERVICE    @"Nội dung của Chế Tube được tổng hợp từ nhiều nguồn khác nhau.Sử dụng ứng dụng Chế Tube, bạn sẽ chấp nhận các điều khoản sau: \n\n 1. Báo cáo sai phạm nếu phát hiện nội dung vi phạm bản quyền \n\n 2.Báo cáo sai phạm nếu ứng dụng có dấu hiệ phản cảm, bạo lực, khiêu dâm, chống phá chính quyền và bạn có quyền gửi báo cáo sai phạm cho chúng tôi. Chúng tôi sẽ xem xét báo cáo và gỡ bỏ nội dung nếu báo cáo đúng sự thật. \n\n Xin chân thành cảm ơn!"
#define CERR_DATA_ERROR         @"Data error!"
typedef enum {
    CURL_TYPE_IN,
    CURL_TYPE_OUT
}CURL_TYPE;
typedef enum {
    ADS_NONE,
    ADS_FACEBOOK,//1
    ADS_GOOGLE,//2
}ADS_SUPPLIER;
#define CKEY_FIRST_RUN          @"first run"

#define CKEY_COIN               @"coinage"
#define CKEY_DEVICEID           @"deviceid"
#define CKEY_TRANS              @"trans"
#define CNTF_GET_SETTING_DONE   @"setting done"
#endif /* Defines_h */
