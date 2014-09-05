//
//  LFLatLongUpdateServiceHelper.m
//  LocationFetchPOC
//
//  Created by Marimuthu Govindasamy on 02/09/14.
//  Copyright (c) 2014 Marimuthu Govindasamy. All rights reserved.
//

#import "LFLatLongUpdateServiceHelper.h"
#import "LFWebServiceClient.h"
#import "LFUserDataModel.h"

@implementation LFLatLongUpdateServiceHelper

+(void)updateLatAndLongInServer{
    
    // get lat and long value from data model
    NSString *latitude = [LFUserDataModel getLatitude];
    NSString *longitude = [LFUserDataModel getLongitude];
    
    if (latitude && longitude) {
        
        // prepare parameters for the service request
        NSDictionary *serviceParamList = @{LAT_LONG_POST_URL_PAYLOAD_KEY: [NSString stringWithFormat:LAT_LONG_POST_URL_PAYLOAD_VALUE,[LFUserDataModel getName],latitude,longitude]};
        NSLog(@"Params Dict ==> %@",serviceParamList);
        __block NSMutableDictionary* userInfoDict = [[NSMutableDictionary alloc] init];
        
        // make service call and handle response
        [LFWebServiceClient processRequestWithUrl:LAT_LONG_POST_URL
                                       parameters:serviceParamList
                                       methodType:POST_METHOD
                   withCompletionBlockWithSuccess:^(id responseDict) {
                       
                       // post notification with response data
                       
                       if (responseDict) {
                           [userInfoDict setValue:responseDict forKey:@"responseDict"];
                       }
                       [[NSNotificationCenter defaultCenter] postNotificationName:LAT_LONG_UPDATE_SUCCESS_NOTIFICATION
                                                                           object:self
                                                                         userInfo:userInfoDict];
                   } andFailure:^(NSError *error) {
                       if (error) {
                           // post notification with error
                           [userInfoDict setValue:error forKey:@"responseError"];
                       }
                       [[NSNotificationCenter defaultCenter] postNotificationName:LAT_LONG_UPDATE_ERROR_NOTIFICATION
                                                                           object:self
                                                                         userInfo:userInfoDict];
                       
                   }];
        
    }
    
}
@end
