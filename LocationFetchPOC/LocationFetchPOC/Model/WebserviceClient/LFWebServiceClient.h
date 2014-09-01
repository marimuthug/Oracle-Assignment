//
//  LFWebServiceClient.h
//  LocationFetchPOC
//
//  Created by Marimuthu Govindasamy on 30/08/14.
//  Copyright (c) 2014 Marimuthu Govindasamy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFWebServiceClient : NSObject

/*
 Desc   : method to process the service request as per received inputs
 Args   : url -  string as NSString
          params - key/value pairs as NSDictionary
          methodType - HTTP method typa as  NSString
          successHandler - as Block object
          failureHandler - as Block object
 Return : NA
 */

+(void)processRequestWithUrl:(NSString*)url  parameters:(NSDictionary*)params methodType:(NSString*)methodType withCompletionBlockWithSuccess:(void(^)(id responseDict))successHandler andFailure:(void(^)(NSError *error))failureHandler;

@end