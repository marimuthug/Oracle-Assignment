//
//  LFViewController.m
//  LocationFetchPOC
//
//  Created by Marimuthu Govindasamy on 30/08/14.
//  Copyright (c) 2014 Marimuthu Govindasamy. All rights reserved.
//

#import "LFViewController.h"
#import "LFLatLongUpdateServiceHelper.h"
#import "LFUserDataModel.h"
#import "NSDate+TimeAgo.h"

#define NAME_VALIDATION_ERROR_ALERT 1000

@interface LFViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationValueLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *serviceActivityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) UIAlertView *nameValidationErrorAlert;
@property (strong, nonatomic) CLLocationManager *locationManager;


- (IBAction)btnActionSubmit:(id)sender;

@end

@implementation LFViewController

#pragma mark Viewcontroller life cycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // adding observer for lat long update success and error
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleSuccessUpdate:)
                                                 name:LAT_LONG_UPDATE_SUCCESS_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleErrorUpdate:)
                                                 name:LAT_LONG_UPDATE_ERROR_NOTIFICATION
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self setupUIPresentationWithData];
    
    
}

-(void)dealloc {
    // remove observers for notification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LAT_LONG_UPDATE_SUCCESS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LAT_LONG_UPDATE_ERROR_NOTIFICATION object:nil];
}

#pragma mark


// method to prepare and do the UI presentation
-(void)setupUIPresentationWithData{
    
    // Present location and name static text with underline
    
    NSMutableAttributedString *attributeStringForNameTip = [[NSMutableAttributedString alloc] initWithString:[self.nameTipLabel text]];
    [attributeStringForNameTip addAttribute:NSUnderlineStyleAttributeName
                                      value:[NSNumber numberWithInt:1]
                                      range:(NSRange){0,[attributeStringForNameTip length]}];
    
    NSMutableAttributedString *attributeStringForLocationTip = [[NSMutableAttributedString alloc] initWithString:[self.locationTipLabel text]];
    [attributeStringForLocationTip addAttribute:NSUnderlineStyleAttributeName
                                          value:[NSNumber numberWithInt:1]
                                          range:(NSRange){0,[attributeStringForLocationTip length]}];
    
    
    [self.nameTipLabel setAttributedText:attributeStringForNameTip];
    [self.locationTipLabel setAttributedText:attributeStringForLocationTip];
    
    
    // update name textfield as per user defaults value
    [self.nameTxtField setText:[LFUserDataModel getName]];
    
    
    // start loction service to fetch the location data
    [self requestForCurrentLocation];
    
    [self.submitBtn setEnabled:NO];
}


// method to initialize loaction manager and start the manager for receiving loction data
-(void)requestForCurrentLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
}

// method to update last updated label for every second
-(void)updateLastUpdatedLabel:(NSTimer *)timer{
    NSString *relativeTime = [[LFUserDataModel getLastUpdatedTimestamp] timeAgo];
    [self.lastUpdatedLabel setText:[NSString stringWithFormat:@"Last submitted %@",relativeTime]];
}

// method to update entered name value in user default
-(void)updateNameValueinUserDataModel:(NSString*)nameValue{
    NSString *extractedNameValue = [nameValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [LFUserDataModel setName:extractedNameValue];    
}

// method call to update lat/long and name value in server
-(void)doUpdateLatlongInserver{
    
    // do update lat and long in server
    [LFLatLongUpdateServiceHelper updateLatAndLongInServer];
    
    [self.serviceActivityIndicator startAnimating];
    [self.submitBtn setEnabled:NO];
}


#pragma mark Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *currentLocation = [locations objectAtIndex:0];
    
    NSString *updatedLocation = [NSString stringWithFormat:@"%f,%f",currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
    [self.locationValueLabel setText:updatedLocation];
    
    [LFUserDataModel setLatitude:[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude]];
    [LFUserDataModel setLongitude:[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude]];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:FIRST_LAT_LON_UPDATE_DONE]) {
        if ([[LFUserDataModel getName] length] > 0) {
            [self.submitBtn setEnabled:NO];
            [self doUpdateLatlongInserver];
            
        }
        else{
            [self.submitBtn setEnabled:YES];
            [self showNameValidationErrorAlert];
        }
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:FIRST_LAT_LON_UPDATE_DONE];

    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error %@", [error localizedDescription]);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status==kCLAuthorizationStatusDenied) {
        [self.locationValueLabel setText:@"Enable location service to submit."];
    }
    NSLog(@"status %d", status);
}


#pragma mark Textfield delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string length]>0) {
        [self updateNameValueinUserDataModel:[[textField text] stringByAppendingString:string]];
    }
    else {
        [self updateNameValueinUserDataModel:[textField.text substringWithRange:(NSRange){0, [textField.text length]-1}]];
        
    }
    
    return YES;
}

#pragma mark button actions

- (IBAction)btnActionSubmit:(id)sender {
    
    [self.nameTxtField resignFirstResponder];
    
    if (!([[LFUserDataModel getName] length] > 0)) {
        
        //prompt user for empty name value
        [self showNameValidationErrorAlert];
        return;
    }
    
    // do update lat long in server
    [LFLatLongUpdateServiceHelper updateLatAndLongInServer];
    
    //start activity indicator
    [self.serviceActivityIndicator startAnimating];
    [self.submitBtn setEnabled:NO];}


#pragma mark service response notification handler methods
-(void)handleSuccessUpdate:(NSNotification*)notification{
    
    // update current time stamp as recent update and save it in userdefaults
    NSDate *currentDate = [NSDate date];
    [LFUserDataModel setLastUpdatedTimestamp:currentDate];
    
    //calculate relative time
    NSString *relativeTime = [[LFUserDataModel getLastUpdatedTimestamp] timeAgo];
    
    // update the UI and present to user
    [self.lastUpdatedLabel setText:[NSString stringWithFormat:@"Last submitted %@",relativeTime]];
    [self.lastUpdatedLabel setHidden:NO];
    
    // trigger updateing label once per second
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLastUpdatedLabel:) userInfo:nil repeats:YES];
    
    //stop activity indicator
    [self.serviceActivityIndicator setHidden:YES];
    [self.serviceActivityIndicator stopAnimating];
    [self.submitBtn setEnabled:YES];
    
}

-(void)handleErrorUpdate:(NSNotification*)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    NSError *error = [userInfo objectForKey:@"responseError"];
    
    
    //parse error
    NSString *message = [LFAppUtils errorDescription:error];


    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@""
                                                message:message
                                               delegate:nil
                                               cancelButtonTitle:NSLocalizedString(ALERT_OK_BUTTON_TITLE,
                                                                                   nil)
                                      otherButtonTitles:nil, nil];
    [errorAlert show];
    

    //stop activity indicator
    [self.serviceActivityIndicator stopAnimating];
    [self.submitBtn setEnabled:YES];
    
}


#pragma mark Alertview display and delegate method

-(void)showNameValidationErrorAlert{
    
    // alert user
    
    if (!self.nameValidationErrorAlert) {
        self.nameValidationErrorAlert =  [[UIAlertView alloc] initWithTitle:@""
                                                                    message:NSLocalizedString(NAME_FIELD_EMPTY_MESSAGE,
                                                                                              nil)
                                                                   delegate:self
                                                          cancelButtonTitle:NSLocalizedString(ALERT_NO_BUTTON_TITLE,
                                                                                               nil)
                                                          otherButtonTitles:NSLocalizedString(ALERT_YES_BUTTON_TITLE,
                                                                                              nil), nil];
    }
    
    
    [self.nameValidationErrorAlert setTag:NAME_VALIDATION_ERROR_ALERT];
    if (!self.nameValidationErrorAlert.visible) {
        [self.nameValidationErrorAlert show];
    }


}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
 
    switch ([alertView tag]) {
        case NAME_VALIDATION_ERROR_ALERT:
            if (buttonIndex == 0) {
              // do nothing
            }
            else{
                //update default name vaue in textfield , data model
                [self.nameTxtField setText:DEFAULT_NAME_VALUE];
                [LFUserDataModel setName:DEFAULT_NAME_VALUE];
                
                [self doUpdateLatlongInserver];
            }
            break;
            
        default:
            break;
    }
}

@end
