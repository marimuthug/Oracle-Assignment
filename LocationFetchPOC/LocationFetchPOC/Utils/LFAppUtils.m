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

    if ([error code] == kCFURLErrorNotConnectedToInternet ) {
        return NSLocalizedString(NO_INTERNET_CONNECTION_ERROR, nil) ;
    }
    else if ( [error code] == kCFURLErrorTimedOut){
         return NSLocalizedString(TIME_OUT_ERROR, nil) ;
    }
    else{
       return NSLocalizedString(UNKNOWN_ERROR, nil) ;
    }
    
}
@end
