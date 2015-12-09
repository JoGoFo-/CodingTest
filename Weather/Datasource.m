//
//  Datasource.m
//  Weather
//
//  Created by Jonathon Francis on 9/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import "Datasource.h"

@interface Datasource ()

@property (strong, nonatomic) NSURLSession* urlSession;

@end

@implementation Datasource

-(instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSURLSessionConfiguration* urlConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    self.urlSession = [NSURLSession sessionWithConfiguration:urlConfig];
    
    return self;
}

- (void)submitRequest:(Request*)request {
    
    NSURLSessionTask* task = [self.urlSession dataTaskWithURL:request.url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (request.completionHandler) {
                request.completionHandler(data, response, error);
            }
            
        });
        
    }];
    
    
    [task resume];
    
}

@end
