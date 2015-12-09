//
//  Forecast.m
//  Weather
//
//  Created by Jonathon Francis on 9/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import "Forecast.h"

// Simple object mapping third party library:
// https://github.com/dchohfi/KeyValueObjectMapping
#import <DCKeyValueObjectMapping.h>
#import <DCArrayMapping.h>
#import <DCParserConfiguration.h>

@implementation Forecast

+ (Forecast *)forecastFromDictionary:(NSDictionary *)dict {
    
    
    
    DCParserConfiguration *config = [DCParserConfiguration configuration];
    
    DCArrayMapping *datapointMapper = [DCArrayMapping mapperForClassElements:[ForecastDatapoint class] forAttribute:@"data" onClass:[ForecastDatablock class]];
    [config addArrayMapper:datapointMapper];
    
    DCArrayMapping *flagsMapper = [DCArrayMapping mapperForClassElements:[ForecastFlags class] forAttribute:@"flags" onClass:[Forecast class]];
    [config addArrayMapper:flagsMapper];
    
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass: [self class] andConfiguration:config];
    
    Forecast * datapoint = [parser parseDictionary:dict];
    
    return datapoint;
}


@end
