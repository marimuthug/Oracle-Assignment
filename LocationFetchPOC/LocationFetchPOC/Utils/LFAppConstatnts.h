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

// user default saving keys
#define NAME_KEY @"name"
#define LATITUDE_KEY @"latitude"
#define LONGITUDE_KEY @"logitude"

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
#endif
