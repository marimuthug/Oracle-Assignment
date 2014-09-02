## LocationFetchPOC 02.09.2014
Work done by Marimuthu


## Functionality

    The latitude/longitude on the screen will continuously update based on the device's location when the app is in the foreground.
    The name field will be default to "John Doe", but the user is allowed to edit it. If edited, the name value will be stored in userdefault so that it persists between app restarts.
    The last submitted line will show a relative time of when the information was last submitted to the server.
    When the user taps the SUBMIT button OR the app first starts OR the app goes into the background, the app will make a HTTP request and update the name, latitude, and longitude in server


## Third party frameworkes used 
1. AFNetworking - for web service connection
2. NSDate+TimeAgo Category - for calculating relative time
