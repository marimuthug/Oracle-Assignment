//
//  LFUserDataModel.m
//  LocationFetchPOC
//
//  Created by Marimuthu Govindasamy on 30/08/14.
//  Copyright (c) 2014 Marimuthu Govindasamy. All rights reserved.
//

#import "LFUserDataModel.h"

@implementation LFUserDataModel

-(NSString*)getName{
    NSString *nameValue = [[NSUserDefaults standardUserDefaults] valueForKey:NAME_KEY];
    if (nameValue) {
        return nameValue;
    }
    return DEFAULT_NAME_VALUE;
}



-(void)setName:(NSString*)passonNameValue{
    [[NSUserDefaults standardUserDefaults]  setValue:passonNameValue forKey:DEFAULT_NAME_VALUE];
}
@end
