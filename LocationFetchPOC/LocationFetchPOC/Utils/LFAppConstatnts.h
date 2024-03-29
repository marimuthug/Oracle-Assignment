//
//  LFAppConstatnts.h
//  LocationFetchPOC
//
//  Created by Marimuthu Govindasamy on 30/08/14.
//  Copyright (c) 2014 Marimuthu Govindasamy. All rights reserved.
//

#ifndef LocationFetchPOC_Header_h
#define LocationFetchPOC_Header_h


#define DEFAULT_NAME_VALUE @"John Doe"

// user default  keys
#define NAME_KEY @"name"
#define LATITUDE_KEY @"latitude"
#define LONGITUDE_KEY @"logitude"
#define LAST_UPDATED_TIMESTAMP_KEY @"lastUpdatedTimestamp"
#define FIRST_LAT_LON_UPDATE_DONE @"FIRST_LAT_LON_UPDATE_DONE"


// webservice related constants
#define LAT_LONG_POST_URL @"http://gentle-tor-1851.herokuapp.com/events"
#define POST_METHOD @"POST"
#define LAT_LONG_POST_URL_PAYLOAD_KEY @"data"
#define LAT_LONG_POST_URL_PAYLOAD_VALUE @"%@ is now at %@/%@"

#define SEVICE_AUTH_USERNAME @"marimuthu"
#define SEVICE_AUTH_PASSWORD @"phil53"

//Notification related constants
#define LAT_LONG_UPDATE_SUCCESS_NOTIFICATION @"LAT_LONG_SERVICE_SUCCESS_NOTIFICATION"
#define LAT_LONG_UPDATE_ERROR_NOTIFICATION @"LAT_LONG_UPDATE_ERROR_NOTIFICATION"


//service response constants
#define NO_INTERNET_CONNECTION_ERROR @"NO_INTERNET_CONNECTION_ERROR"
#define TIME_OUT_ERROR @"TIME_OUT_ERROR"
#define UNKNOWN_ERROR @"UNKNOWN_ERROR"


#define NAME_FIELD_EMPTY_MESSAGE @"NAME_FIELD_EMPTY_MESSAGE"


// Alertview title constatnts
#define ALERT_OK_BUTTON_TITLE @"ALERT_OK_BUTTON_TITLE"
#define ALERT_YES_BUTTON_TITLE @"ALERT_YES_BUTTON_TITLE"
#define ALERT_NO_BUTTON_TITLE @"ALERT_NO_BUTTON_TITLE"

#endif
