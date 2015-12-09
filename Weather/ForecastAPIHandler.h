//
//  ForecastAPI.h
//  Weather
//
//  Created by Jonathon Francis on 10/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Datasource.h"
#import "Forecast.h"



typedef NS_ENUM(NSInteger, ForecastAPIErrorCodes) {
    ForecastAPIErrorCodeStatusError,
    ForecastAPIErrorCodeAPIResponseError
};

@interface ForecastAPIHandler : NSObject

extern NSString* const kForecastAPIErrorDomain;

@property (strong, nonatomic) Datasource* datasource;

- (NSURL*)forcastAPIURLForLatutide:(CGFloat)latitude
                         Longitude:(CGFloat)longitude
                            APIKey:(NSString *)apiKey;

- (void)forcastAPIRequestForLatutide:(CGFloat)latitude
                           Longitude:(CGFloat)longitude
                              APIKey:(NSString *)apiKey
                   completionHandler:(void (^)(NSError *err, Forecast *forecast))completionHandler;

@end
