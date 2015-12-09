//
//  DatasourceStub.m
//  Weather
//
//  Created by Jonathon Francis on 10/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import "DatasourceStub.h"

@implementation DatasourceStub

-(instancetype)init {
    self = [super init];
    
    
    // Default values
    
    self.responseCodeToInject = 200;
    self.responseJSONToInject = @"";
    
    return self;
}

-(void)submitRequest:(Request *)request {
    

    
    if (request.completionHandler) {
        
        NSHTTPURLResponse* response = [[NSHTTPURLResponse alloc] initWithURL:request.url statusCode:self.responseCodeToInject HTTPVersion:@"HTTP/1.1" headerFields:@{@"Content-Type" : @"application/json"}];
        
        NSData* responseData;

        responseData = [self.responseJSONToInject dataUsingEncoding:NSUTF8StringEncoding];
        
        request.completionHandler(responseData, response, nil);
        
        
    }
    
}

@end
