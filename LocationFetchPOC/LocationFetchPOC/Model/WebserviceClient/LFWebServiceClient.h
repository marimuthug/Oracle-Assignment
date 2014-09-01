//
//  LFWebServiceClient.h
//  LocationFetchPOC
//
//  Created by Marimuthu Govindasamy on 30/08/14.
//  Copyright (c) 2014 Marimuthu Govindasamy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFWebServiceClient : NSObject


+(void)processRequestWithUrl:(NSString*)url  parameters:(NSDictionary*)params methodType:(NSString*)methodType withCompletionBlockWithSuccess:(void(^)(id responseDict))successHandler andFailure:(void(^)(NSError *error))failureHandler;

@end