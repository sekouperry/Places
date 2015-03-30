//
//  GetPlacesOfTypeServiceController.h
//  Places
//
//  Created by Ishan on 3/30/15.
//  Copyright (c) 2015 Ishan. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GetPlacesOfTypeServiceControllerDelegate <NSObject>

- (void) fetchPlacesOfTypeServiceReturnedSuccessWithData:(id)data;
- (void) fetchPlacesOfTypeServiceFailedWithError:(NSError *)error;

@end

@interface GetPlacesOfTypeServiceController : NSObject

@property (weak, nonatomic) id<GetPlacesOfTypeServiceControllerDelegate> delegate;

+ (instancetype) sharedGetPlacesOfTypeServiceController;
- (void) fetchPlacesOfTypeForData:(id)data;

@end
