//
//  LFAppUtils.h
//  LocationFetchPOC
//
//  Created by Marimuthu on 02/09/14.
//  Copyright (c) 2014 Marimuthu Govindasamy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFAppUtils : NSObject

/*
 Desc   : method to Parser the error object and return user friendly message
 Args   : error object as NSErro
 Return : user friendly message as NSString
 */
+(NSString*)errorDescription:(NSError*)error;
@end
