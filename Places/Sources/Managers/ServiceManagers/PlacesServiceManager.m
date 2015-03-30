//
//  PlacesServiceManager.m
//  Places
//
//  Created by Ishan on 3/30/15.
//  Copyright (c) 2015 Ishan. All rights reserved.
//

#import "FetchPlaceModel.h"
#import "FetchImageModel.h"
#import "PlacesServiceManager.h"
#import "GetPlacesOfTypeServiceController.h"

@interface PlacesServiceManager ()<GetPlacesOfTypeServiceControllerDelegate>

@end

@implementation PlacesServiceManager

+ (instancetype)placesServiceManager {
    static PlacesServiceManager *manager = nil;
    @synchronized([manager class]) {
        if (manager == nil) {
            manager = [[PlacesServiceManager alloc] init];
        }
    }
    return manager;
}

- (void) requestServiceOfType:(ServiceType)type withData:(id)data {
    switch (type) {
        case serviceTypeFetchPlaces:
            [[GetPlacesOfTypeServiceController sharedGetPlacesOfTypeServiceController] setDelegate:self];
            [[GetPlacesOfTypeServiceController sharedGetPlacesOfTypeServiceController] fetchPlacesOfTypeForData:data];
            break;
            
        case serviceTypeFetchImage:
            //TODO: call the relevant service controller
            NSLog(@"serviceTypeFetchImage called");
            break;
            
        default:
            break;
    }
}

#pragma -mark GetPlacesOfTypeServiceControllerDelegate Methods

- (void) fetchPlacesOfTypeServiceReturnedSuccessWithData:(id)data {
    //TODO: Send the data to the response parser to fill the models. On success return call the requestCompletedSuccessfullyWithData delegate.
}

- (void) fetchPlacesOfTypeServiceFailedWithError:(NSError *)error {
    [self.delegate requestFailedWithError:error];
}

@end
