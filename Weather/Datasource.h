//
//  Datasource.h
//  Weather
//
//  Created by Jonathon Francis on 9/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"

@interface Datasource : NSObject

- (void)submitRequest:(Request*)request;

@end
