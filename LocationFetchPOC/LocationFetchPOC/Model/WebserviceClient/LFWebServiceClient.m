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
    
    NSURLCredential *credential = [NSURLCredential credentialWithUser:@"marimuthu" password:@"phil53" persistence:NSURLCredentialPersistenceNone];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:methodType URLString:url    parameters:params error:NULL];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCredential:credential];
    [operation setResponseSerializer:[AFJSONResponseSerializer alloc]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        successHandler(responseObject);
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureHandler(error);
        NSLog(@"Failure: %@", error);
    }];
    [manager.operationQueue addOperation:operation];
}
@end
