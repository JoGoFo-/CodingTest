//
//  Request.h
//  Weather
//
//  Created by Jonathon Francis on 9/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject

@property (strong, nonatomic) NSURL* url;
@property (strong, nonatomic) void(^completionHandler)(NSData *data, NSURLResponse *response, NSError *connectionError);

@end
