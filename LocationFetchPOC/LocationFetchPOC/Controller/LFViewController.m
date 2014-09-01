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


@interface LFViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationValueLabel;

@property (strong, nonatomic) CLLocationManager *locationManager;

- (IBAction)btnActionSubmit:(id)sender;

@end

@implementation LFViewController

#pragma mark Viewcontroller life cycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
    
}


// method to initialize loaction manager and start the manager for receiving loction data
-(void)requestForCurrentLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *currentLocation = [locations objectAtIndex:0];
    
    NSString *updatedLocation = [NSString stringWithFormat:@"%f,%f",currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
    [self.locationValueLabel setText:updatedLocation];
    
    [LFUserDataModel setLatitude:[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude]];
    [LFUserDataModel setLongitude:[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude]];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error %@", [error localizedDescription]);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"status %d", status);
}


#pragma mark Textfield delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSString *extractedNameValue = [[self.nameTxtField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([extractedNameValue length] > 0){
        [LFUserDataModel setName:extractedNameValue];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark button actions

- (IBAction)btnActionSubmit:(id)sender {
    [self.nameTxtField resignFirstResponder];
    
    // do update lat long in server
    [LFLatLongUpdateServiceHelper updateLatAndLongInService];
}


#pragma mark service response notification handler methods
-(void)handleSuccessUpdate:(NSNotification*)notification{
    [self.lastUpdatedLabel setText:[NSString stringWithFormat:@"%@",[NSDate date]]];
}

-(void)handleErrorUpdate:(NSNotification*)notification{
    
}
@end
