//
//  LFUserDataModel.h
//  LocationFetchPOC
//
//  Created by Marimuthu Govindasamy on 30/08/14.
//  Copyright (c) 2014 Marimuthu Govindasamy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFUserDataModel : NSObject

/*
 Desc   : method to get the value from the user detaults for the name key
 Args   : NA
 Return : Name value as String
 */
-(NSString*)getName;

/*
 Desc   : method to set the passon value to the user detaults for the name key
 Args   : namevalue as String
 Return : NA
 */
-(void)setName:(NSString*)passonNameValue;

@end
