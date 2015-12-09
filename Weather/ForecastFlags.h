//
//  ForcastFlags.h
//  Weather
//
//  Created by Jonathon Francis on 9/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastFlags : NSObject

@property (strong, nonatomic) NSString* darkskyUnavailable;
@property (strong, nonatomic) NSArray<NSString*>* darkskyStations;
@property (strong, nonatomic) NSArray<NSString*>* datapointStations;
@property (strong, nonatomic) NSArray<NSString*>* isdStations;
@property (strong, nonatomic) NSArray<NSString*>* lampStations;
@property (strong, nonatomic) NSArray<NSString*>* metarStations;
@property (strong, nonatomic) NSString* metnoLicense;
@property (strong, nonatomic) NSArray<NSString*>* sources;
@property (strong, nonatomic) NSString* units;

@end
