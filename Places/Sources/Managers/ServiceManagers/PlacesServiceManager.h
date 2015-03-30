//
//  PlacesServiceManager.h
//  Places
//
//  Created by Ishan on 3/30/15.
//  Copyright (c) 2015 Ishan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PlacesServiceManagerDelegate <NSObject>

- (void) requestCompletedSuccessfullyWithData:(NSData *)data;
- (void) requestFailedWithError:(NSError *)error;

@end

typedef enum : NSUInteger {
    serviceTypeFetchPlaces,
    serviceTypeFetchImage,
} ServiceType;

@interface PlacesServiceManager : NSObject

@property (weak, nonatomic) id <PlacesServiceManagerDelegate> delegate;

+ (instancetype)placesServiceManager;

- (void) requestServiceOfType:(ServiceType)type withData:(id)data;

@end
