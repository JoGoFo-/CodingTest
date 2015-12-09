//
//  ForecastAPI.m
//  Weather
//
//  Created by Jonathon Francis on 10/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import "ForecastAPIHandler.h"
#import "config.h"

@implementation ForecastAPIHandler

NSString* const kForecastAPIErrorDomain = @"kForecastAPIErrorDomain";

- (NSURL*)forcastAPIURLForLatutide:(CGFloat)latitude
                         Longitude:(CGFloat)longitude
                            APIKey:(NSString *)apiKey {
    
    NSURLComponents* urlComponents = [[NSURLComponents alloc] init];
    urlComponents.scheme = @"https";
    urlComponents.host = kForecastIoURL;
    urlComponents.path = [NSString stringWithFormat:@"/%@/%@/%f,%f", kForecastIoForecastPath, apiKey, latitude, longitude];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"units" value:@"si"]];
    
    return urlComponents.URL;
    
}

- (void)forcastAPIRequestForLatutide:(CGFloat)latitude
                           Longitude:(CGFloat)longitude
                              APIKey:(NSString *)apiKey
                   completionHandler:(void (^)(NSError *err, Forecast *forecast))completionHandler {
    
    Request* req = [[Request alloc] init];
    
    req.url = [self forcastAPIURLForLatutide:latitude Longitude:longitude APIKey:apiKey];
    req.completionHandler = ^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        
        if (connectionError) {
            return completionHandler(connectionError, nil);
        }
        
        NSError* parseError;
        NSDictionary* dict;
        
        if (data && data.length > 0) {
        
            dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            
            if (parseError) {
                return completionHandler(parseError, nil);
            }
        }
        
        if (dict[@"error"]) {
            return completionHandler([self apiResponseError:dict[@"error"]], nil);
        }
        
        NSError* responseCodeError = [self checkResponseForErrors:response];
        if (responseCodeError) {
            return completionHandler(responseCodeError, nil);
        }
        
        Forecast* forecast = [Forecast forecastFromDictionary:dict];
        
        return completionHandler(nil, forecast);
        
    };
    
    [self.datasource submitRequest:req];
    
}

- (NSError *)checkResponseForErrors:(NSURLResponse*)response {
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
        
        if (httpResponse.statusCode < 200 || httpResponse.statusCode > 299) {
            return [self httpStatusError:httpResponse.statusCode];
        }
        
    }
    
    return nil;
}

- (NSError *)httpStatusError:(NSInteger)statusCode {
    return [NSError errorWithDomain:kForecastAPIErrorDomain code:ForecastAPIErrorCodeStatusError userInfo:@{NSLocalizedDescriptionKey : @"Bad response from server"}];
}

- (NSError *)apiResponseError:(NSString*)responseString {
    return [NSError errorWithDomain:kForecastAPIErrorDomain code:ForecastAPIErrorCodeAPIResponseError userInfo:@{NSLocalizedDescriptionKey : responseString}];
}

@end
