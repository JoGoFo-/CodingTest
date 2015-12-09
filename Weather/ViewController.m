//
//  ViewController.m
//  Weather
//
//  Created by Jonathon Francis on 9/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MBProgressHUD.h>
#import "ForecastAPIHandler.h"
#import "config.h"

@interface ViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *weatherConditionsLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempLabel;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;

@property (strong, nonatomic) Forecast* forecast;
@property (strong, nonatomic) CLLocationManager* locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.weatherConditionsLabel.text = @"";
    self.tempLabel.text = @"";
}

- (void)viewWillAppear:(BOOL)animated {
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestLocation];
}


-(void)setForecast:(Forecast *)forecast {
    _forecast = forecast;
    
    self.tempLabel.text = [NSString stringWithFormat:@"%li°C", (long)[forecast.currently.temperature integerValue]];
    self.weatherConditionsLabel.text = forecast.currently.summary;
}


- (void)loadDataForLocation:(CLLocationCoordinate2D)location {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    ForecastAPIHandler* apiHandler = [[ForecastAPIHandler alloc] init];
    apiHandler.datasource = [[Datasource alloc] init];
    
    __weak typeof(self) weakSelf = self;
    
    [apiHandler forcastAPIRequestForLatutide:location.latitude Longitude:location.longitude APIKey:kForecastIoAPIKey completionHandler:^(NSError *err, Forecast *forecast) {
        [hud hide:YES];
        
        if (err) {
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                           message:err.localizedDescription
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf loadDataForLocation:location];
            }]];
            [weakSelf presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        weakSelf.forecast = forecast;
        
        
    }];
    
}

#pragma mark - CLLocationManager Delegate methods

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (CLLocationManager.authorizationStatus != kCLAuthorizationStatusAuthorizedAlways
        && CLLocationManager.authorizationStatus != kCLAuthorizationStatusAuthorizedWhenInUse
        && CLLocationManager.authorizationStatus != kCLAuthorizationStatusNotDetermined) {
        self.errorLabel.hidden = NO;
    } else {
        self.errorLabel.hidden = YES;
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation* location = [locations lastObject];
    [self loadDataForLocation:location.coordinate];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {

}

@end
