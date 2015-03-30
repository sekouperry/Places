//
//  FetchPlaceModel.h
//  Places
//
//  Created by Ishan on 3/30/15.
//  Copyright (c) 2015 Ishan. All rights reserved.
//

#import "LocationModel.h"
#import <Foundation/Foundation.h>

@interface FetchPlaceModel : NSObject

@property (strong, nonatomic) LocationModel *location;
@property NSInteger radius;
@property (strong, nonatomic) NSString *placeType;
@property (strong, nonatomic) NSString *apiKey;

@end
