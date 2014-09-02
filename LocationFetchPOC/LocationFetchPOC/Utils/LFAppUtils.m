//
//  LFAppUtils.m
//  LocationFetchPOC
//
//  Created by Marimuthu on 02/09/14.
//  Copyright (c) 2014 Marimuthu Govindasamy. All rights reserved.
//

#import "LFAppUtils.h"

@implementation LFAppUtils
+(NSString*)errorDescription:(NSError*)error{
    if (([error code] == kCFURLErrorCannotConnectToHost) || ([error code] == kCFURLErrorTimedOut) || ([error code] == kCFURLErrorBadURL) || ([error code] == kCFURLErrorUnsupportedURL) || ([error code] == kCFURLErrorCannotFindHost) || [error code] == kCFURLErrorNotConnectedToInternet || [error code] == kCFURLErrorNetworkConnectionLost) {
        if (([error code]==kCFURLErrorNetworkConnectionLost) | kCFURLErrorNotConnectedToInternet) {
            return NO_INTERNET_CONNECTION_ERROR ;
        }
        else if ([error code] == kCFURLErrorTimedOut){
            return TIME_OUT_ERROR;
        }
    }
    return UNKNOWN_ERROR;
}
@end
