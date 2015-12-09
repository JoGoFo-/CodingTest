//
//  ForcastAlert.h
//  Weather
//
//  Created by Jonathon Francis on 9/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastAlert : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSDate* expires;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSString* uri;

@end
