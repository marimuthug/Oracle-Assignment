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
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*)getLatitude{
    return [[NSUserDefaults standardUserDefaults] objectForKey:LATITUDE_KEY];
}

+(void)setLatitude:(NSString*)passonLatValue{
    [[NSUserDefaults standardUserDefaults]  setObject:passonLatValue forKey:LATITUDE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+(NSString*)getLongitude{
    return [[NSUserDefaults standardUserDefaults] objectForKey:LONGITUDE_KEY];
}

+(void)setLongitude:(NSString*)passonLongValue{
    [[NSUserDefaults standardUserDefaults]  setObject:passonLongValue forKey:LONGITUDE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
