//
//  LFViewController.m
//  LocationFetchPOC
//
//  Created by Marimuthu Govindasamy on 30/08/14.
//  Copyright (c) 2014 Marimuthu Govindasamy. All rights reserved.
//

#import "LFViewController.h"
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    
    
    [self.nameTxtField setText:[LFUserDataModel getName]];
    
    [self requestForCurrentLocation];
    
}


#pragma mark Location Manager Delegate


-(void)requestForCurrentLocation
{
    self.locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *currentLocation = [locations objectAtIndex:0];
    
    NSString *updatedLocation = [NSString stringWithFormat:@"%f,%f",currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
    [self.locationValueLabel setText:updatedLocation];
    
    NSLog(@"%@",updatedLocation);
  
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error %@", [error localizedDescription]);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
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
    
}

@end
