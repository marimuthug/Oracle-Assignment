//
//  LFWebServiceClient.m
//  LocationFetchPOC
//
//  Created by Marimuthu Govindasamy on 30/08/14.
//  Copyright (c) 2014 Marimuthu Govindasamy. All rights reserved.
//

#import "LFWebServiceClient.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"


@implementation LFWebServiceClient


+(void)processRequestWithUrl:(NSString*)url  parameters:(NSDictionary*)params methodType:(NSString*)methodType withCompletionBlockWithSuccess:(void(^)(id responseDict))successHandler andFailure:(void(^)(NSError *error))failureHandler{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // set up credentials for basic authetication
    
    NSURLCredential *credential = [NSURLCredential credentialWithUser:SEVICE_AUTH_USERNAME password:SEVICE_AUTH_PASSWORD persistence:NSURLCredentialPersistenceNone];
    
    // prepare web service request
    NSMutableURLRequest *request = [manager.requestSerializer
                                    requestWithMethod:methodType
                                    URLString:url
                                    parameters:params
                                    error:NULL];
    
    // create operation wih url request and add into operation queue for execution
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCredential:credential];
    [operation setResponseSerializer:[AFJSONResponseSerializer alloc]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        successHandler(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureHandler(error);
    }];
    
    [manager.operationQueue addOperation:operation];
}
@end
