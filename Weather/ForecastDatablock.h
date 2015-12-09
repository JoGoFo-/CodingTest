//
//  ForecastDatablock.h
//  Weather
//
//  Created by Jonathon Francis on 9/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ForecastDatapoint;

@interface ForecastDatablock : NSObject

@property (strong, nonatomic) NSString* summary;
@property (strong, nonatomic) NSString* icon;
@property (strong, nonatomic) NSArray<ForecastDatapoint*>* data;


@end
