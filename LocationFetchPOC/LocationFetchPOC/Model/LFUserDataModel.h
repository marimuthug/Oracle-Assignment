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
+(NSString*)getName;

/*
 Desc   : method to set the passon value to the user detaults for the name key
 Args   : namevalue as String
 Return : NA
 */
+(void)setName:(NSString*)passonNameValue;

/*
 Desc   : method to get the value from the user detaults for the latitude key
 Args   : NA
 Return : Latitude value as String
 */
+(NSString*)getLatitude;

/*
 Desc   : method to set the passon value to the user detaults for the latitude key
 Args   : latitudevalue as String
 Return : NA
 */
+(void)setLatitude:(NSString*)passonLatValue;

/*
 Desc   : method to get the value from the user detaults for the longitude key
 Args   : NA
 Return : Name value as String
 */
+(NSString*)getLongitude;

/*
 Desc   : method to set the passon value to the user detaults for the longitude key
 Args   : longitudevalue as String
 Return : NA
 */
+(void)setLongitude:(NSString*)passonLongValue;


/*
 Desc   : method to get the value from the user detaults for the last updated timestamp key
 Args   : NA
 Return : Last updated timestamp value as NSDate
 */
+(NSDate*)getLastUpdatedTimestamp;

/*
 Desc   : method to set the passon value to the user detaults for the last updated timestamp key
 Args   : last updatedTimestamp as NSDate
 Return : NA
 */
+(void)setLastUpdatedTimestamp:(NSDate*)passonLastUpdatedTimestamp;
@end
