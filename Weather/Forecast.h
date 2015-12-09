//
//  Forecast.h
//  Weather
//
//  Created by Jonathon Francis on 9/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForecastDatapoint.h"
#import "ForecastDatablock.h"
#import "ForecastAlert.h"
#import "ForecastFlags.h"



@interface Forecast : NSObject

@property (strong, nonatomic) NSNumber* latitude;
@property (strong, nonatomic) NSNumber* longitude;
@property (strong, nonatomic) NSString* timezone;
@property (strong, nonatomic) NSNumber* offset;
@property (strong, nonatomic) ForecastDatapoint* currently;
@property (strong, nonatomic) ForecastDatablock* minutely;
@property (strong, nonatomic) ForecastDatablock* hourly;
@property (strong, nonatomic) ForecastDatablock* daily;
@property (strong, nonatomic) NSArray<ForecastAlert*>* alerts;
@property (strong, nonatomic) ForecastFlags* flags;

+ (Forecast *)forecastFromDictionary:(NSDictionary *)dict;


@end
