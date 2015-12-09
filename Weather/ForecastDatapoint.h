//
//  ForecastDatapoint.h
//  Weather
//
//  Created by Jonathon Francis on 9/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastDatapoint : NSObject

@property (strong, nonatomic) NSDate* time;
@property (strong, nonatomic) NSString* summary;
@property (strong, nonatomic) NSString* icon;
@property (strong, nonatomic) NSDate* sunriseTime;
@property (strong, nonatomic) NSDate* sunsetTime;
@property (strong, nonatomic) NSString* moonPhase;
@property (strong, nonatomic) NSNumber* nearestStormDistance;
@property (strong, nonatomic) NSNumber* nearestStormBearing;
@property (strong, nonatomic) NSNumber* precipIntensity;
@property (strong, nonatomic) NSNumber* precipIntensityMax;
@property (strong, nonatomic) NSNumber* precipProbability;
@property (strong, nonatomic) NSString* precipType;
@property (strong, nonatomic) NSNumber* precipAccumulation;
@property (strong, nonatomic) NSNumber* temperature;
@property (strong, nonatomic) NSNumber* temperatureMin;
@property (strong, nonatomic) NSDate* temperatureMinTime;
@property (strong, nonatomic) NSNumber* temperatureMax;
@property (strong, nonatomic) NSDate* temperatureMaxTime;
@property (strong, nonatomic) NSNumber* apparentTemperature;
@property (strong, nonatomic) NSNumber* apparentTemperatureMin;
@property (strong, nonatomic) NSDate* apparentTemperatureMinTime;
@property (strong, nonatomic) NSNumber* apparentTemperatureMax;
@property (strong, nonatomic) NSDate* apparentTemperatureMaxTime;
@property (strong, nonatomic) NSNumber* dewPoint;
@property (strong, nonatomic) NSNumber* windSpeed;
@property (strong, nonatomic) NSNumber* windBearing;
@property (strong, nonatomic) NSNumber* cloudCover;
@property (strong, nonatomic) NSNumber* humidity;
@property (strong, nonatomic) NSNumber* pressure;
@property (strong, nonatomic) NSNumber* visibility;
@property (strong, nonatomic) NSNumber* ozone;

@end
