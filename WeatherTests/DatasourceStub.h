//
//  DatasourceStub.h
//  Weather
//
//  Created by Jonathon Francis on 10/12/2015.
//  Copyright © 2015 Westpac. All rights reserved.
//

#import "Datasource.h"

@interface DatasourceStub : Datasource

@property (nonatomic) NSInteger responseCodeToInject;
@property (strong, nonatomic) NSString* responseJSONToInject;


@end
