//
//  TestForcaseAPIHandler.m
//  Weather
//
//  Created by Jonathon Francis on 10/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ForecastAPIHandler.h"
#import "DatasourceStub.h"

@interface TestForcaseAPIHandler : XCTestCase

@property (strong, nonatomic) ForecastAPIHandler* apiHandler;
@property (strong, nonatomic) DatasourceStub* datasource;

@end

@implementation TestForcaseAPIHandler

- (void)setUp {
    [super setUp];
    
    self.apiHandler = [[ForecastAPIHandler alloc] init];
    self.datasource = [[DatasourceStub alloc] init];
    self.apiHandler.datasource = self.datasource;
}

- (void)tearDown {
    
    self.apiHandler.datasource = nil;
    self.apiHandler = nil;
    
    self.datasource = nil;
    
    [super tearDown];
}

- (void)testURLBuilder {
    NSURL* url = [self.apiHandler forcastAPIURLForLatutide:2.342356 Longitude:-4.23423 APIKey:@"abcdefg123456"];
    
    XCTAssert([url.absoluteString isEqualToString:@"https://api.forecast.io/forecast/abcdefg123456/2.342356,-4.234230?units=si"]);
}

- (void)testSuccessAPICall {
    
    self.datasource.responseJSONToInject = @"{\"latitude\":37.8267,\"longitude\":-122.423,\"timezone\":\"America/Los_Angeles\",\"offset\":-8,\"currently\":{\"time\":1449655735,\"summary\":\"Mostly Cloudy\",\"icon\":\"partly-cloudy-night\",\"nearestStormDistance\":3,\"nearestStormBearing\":108,\"precipIntensity\":0,\"precipProbability\":0,\"temperature\":55.83,\"apparentTemperature\":55.83,\"dewPoint\":54.13,\"humidity\":0.94,\"windSpeed\":1.75,\"windBearing\":170,\"visibility\":4.51,\"cloudCover\":0.93,\"pressure\":1021.07,\"ozone\":270.9},\"minutely\":{\"summary\":\"Mostly cloudy for the hour.\",\"icon\":\"partly-cloudy-night\",\"data\":[{\"time\":1449655680,\"precipIntensity\":0,\"precipProbability\":0}]}}";
    
    [self.apiHandler forcastAPIRequestForLatutide:0 Longitude:0 APIKey:@"0987654321" completionHandler:^(NSError *err, Forecast *forecast) {
        
        XCTAssertNil(err);
        XCTAssertNotNil(forecast);
        XCTAssert([forecast.currently.temperature isEqual:@55.83]);
        
    }];
    
}

- (void)testFailAPICallBadStatusCode {
    self.datasource.responseJSONToInject = @"{\"latitude\":37.8267,\"longitude\":-122.423,\"timezone\":\"America/Los_Angeles\",\"offset\":-8,\"currently\":{\"time\":1449655735,\"summary\":\"Mostly Cloudy\",\"icon\":\"partly-cloudy-night\",\"nearestStormDistance\":3,\"nearestStormBearing\":108,\"precipIntensity\":0,\"precipProbability\":0,\"temperature\":55.83,\"apparentTemperature\":55.83,\"dewPoint\":54.13,\"humidity\":0.94,\"windSpeed\":1.75,\"windBearing\":170,\"visibility\":4.51,\"cloudCover\":0.93,\"pressure\":1021.07,\"ozone\":270.9},\"minutely\":{\"summary\":\"Mostly cloudy for the hour.\",\"icon\":\"partly-cloudy-night\",\"data\":[{\"time\":1449655680,\"precipIntensity\":0,\"precipProbability\":0}]}}";
    
    self.datasource.responseCodeToInject = 404;
    
    [self.apiHandler forcastAPIRequestForLatutide:0 Longitude:0 APIKey:@"0987654321" completionHandler:^(NSError *err, Forecast *forecast) {
        XCTAssertNotNil(err);
        XCTAssertNil(forecast);
        XCTAssertEqual(err.code, ForecastAPIErrorCodeStatusError);
    }];
}

- (void)testFailAPICallBadResponse {
    self.datasource.responseJSONToInject = @"{\"code\":400,\"error\":\"The given location is invalid.\"}";
    
    [self.apiHandler forcastAPIRequestForLatutide:0 Longitude:0 APIKey:@"0987654321" completionHandler:^(NSError *err, Forecast *forecast) {
        XCTAssertNotNil(err);
        XCTAssertNil(forecast);
        XCTAssertEqual(err.code, ForecastAPIErrorCodeAPIResponseError);
        XCTAssert([err.localizedDescription isEqualToString:@"The given location is invalid."]);
    }];
}

@end
