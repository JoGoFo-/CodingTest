//
//  ForecastModelTests.m
//  Weather
//
//  Created by Jonathon Francis on 9/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Forecast.h"

@interface ForecastModelTests : XCTestCase

@end

@implementation ForecastModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObjectMapping {
    
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *resource = [bundle pathForResource:@"TestForecastData" ofType:@"json"];
    
    NSInputStream *inputStream = [NSInputStream inputStreamWithFileAtPath:resource];
    [inputStream open];
        
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithStream:inputStream options:0 error:nil];
    
    Forecast* forecast = [Forecast forecastFromDictionary:dict];
    
    XCTAssertNotNil(forecast);
    
    // Tests are not exhaustive, just a few examples
    
    XCTAssert([forecast.latitude isEqual:@37.8267]);
    XCTAssert([forecast.timezone isEqualToString:@"America/Los_Angeles"]);
    

    XCTAssert([forecast.currently.nearestStormDistance isEqual:@3]);
    XCTAssert([forecast.currently.humidity isEqual:@0.94]);
    
}

@end
