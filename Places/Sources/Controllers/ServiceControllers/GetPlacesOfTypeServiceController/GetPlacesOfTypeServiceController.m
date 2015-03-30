//
//  GetPlacesOfTypeServiceController.m
//  Places
//
//  Created by Ishan on 3/30/15.
//  Copyright (c) 2015 Ishan. All rights reserved.
//

#import "Constants.h"
#import "FetchPlaceModel.h"
#import "AFHTTPRequestOperation.h"
#import "GetPlacesOfTypeServiceController.h"



@implementation GetPlacesOfTypeServiceController

+ (instancetype) sharedGetPlacesOfTypeServiceController {
    static GetPlacesOfTypeServiceController *controller = nil;
    @synchronized([GetPlacesOfTypeServiceController class]) {
        if (controller == nil) {
            controller = [[GetPlacesOfTypeServiceController alloc] init];
        }
    }
    return controller;
}
- (void) fetchPlacesOfTypeForData:(id)data {
    
    FetchPlaceModel *tempModel = (FetchPlaceModel *)data;
    
    NSString *string = [NSString stringWithFormat:@"%@location=%f,%f&radius=%d&types=%@&key=%@", FETCH_PLACES_BASE_URL,tempModel.location.latitude,tempModel.location.longitude,tempModel.radius,tempModel.placeType,tempModel.apiKey];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    // Make sure to set the responseSerializer correctly
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        if (self.delegate != nil) {
            [self.delegate fetchPlacesOfTypeServiceReturnedSuccessWithData:responseObject];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (self.delegate != nil) {
            [self.delegate fetchPlacesOfTypeServiceFailedWithError:error];
        }
        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
    }];
    
    [operation start];
}

@end
