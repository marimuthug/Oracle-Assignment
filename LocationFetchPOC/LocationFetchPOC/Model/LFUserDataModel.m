//
//  LFUserDataModel.m
//  LocationFetchPOC
//
//  Created by Marimuthu Govindasamy on 30/08/14.
//  Copyright (c) 2014 Marimuthu Govindasamy. All rights reserved.
//

#import "LFUserDataModel.h"

@implementation LFUserDataModel

+(NSString*)getName{
    NSString *nameValue = [[NSUserDefaults standardUserDefaults] objectForKey:NAME_KEY];
    if (nameValue) {
        return nameValue;
    }
    return DEFAULT_NAME_VALUE;
}

+(void)setName:(NSString*)passonNameValue{
    [[NSUserDefaults standardUserDefaults]  setObject:passonNameValue forKey:NAME_KEY];
}
@end
