//
//  HomeViewController.m
//  Places
//
//  Created by Ishan on 3/30/15.
//  Copyright (c) 2015 Ishan. All rights reserved.
//

#import "Constants.h"
#import "LocationModel.h"
#import "FetchPlaceModel.h"
#import "HomeViewController.h"
#import "PlacesServiceManager.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>


@interface HomeViewController () <CLLocationManagerDelegate,UICollectionViewDelegateFlowLayout,PlacesServiceManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UICollectionView *placeTypeCollectionView;
@property (strong, nonatomic) NSArray *placeTypeArray;
@property (strong, nonatomic) LocationModel *userLocation;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.title = @"Places";
    
    NSURL* url = [[NSBundle mainBundle] URLForResource: @"PlaceType" withExtension: @"plist"];
    self.placeTypeArray = [NSArray arrayWithContentsOfURL: url];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        self.userLocation = [[LocationModel alloc] init];
        [self.locationManager startUpdatingLocation];
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.userLocation.latitude = newLocation.coordinate.latitude;
    self.userLocation.longitude = newLocation.coordinate.longitude;
}

#pragma -mark UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.placeTypeArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *tempArray = self.placeTypeArray[0];
    return tempArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLACE_ITEM_CELL_IDENTIFIER forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

#pragma -mark UICollectionViewDelegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected cell row = %d column = %d",indexPath.section, indexPath.row);
    
    NSArray *tempArray = self.placeTypeArray[indexPath.section];
    NSString *place  = tempArray[indexPath.row];
    
    [self createPlaceFetchRequestModelForPlace:place];
    
}


#pragma -mark UICollectionViewDelegateFlowLayout Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = CGSizeMake((self.view.frame.size.width/2)-20, ((self.view.frame.size.height-64)/3)-20);
    return size;
    
}


#pragma -mark Creating Request data model

- (void) createPlaceFetchRequestModelForPlace:(NSString *)place {
    NSLog(@"fetch data for place %@", place);
    
    FetchPlaceModel *fetchPlaceModel = [[FetchPlaceModel alloc] init];
    fetchPlaceModel.placeType = [NSString stringWithString:place];
    fetchPlaceModel.location = self.userLocation;
    fetchPlaceModel.radius = 1000;
    fetchPlaceModel.apiKey = [NSString stringWithString:API_KEY_BROWSER];
    
    //TODO: Send this to the Service Manager and show the spinner control.
    PlacesServiceManager *manager = [PlacesServiceManager placesServiceManager];
    manager.delegate = self;
    [manager requestServiceOfType:serviceTypeFetchPlaces withData:fetchPlaceModel];
}

#pragma -mark PlacesServiceManagerDelegate Methods

- (void) requestCompletedSuccessfullyWithData:(NSData *)data {
    // Show success screen and save data into model.
}


- (void) requestFailedWithError:(NSError *)error {
    // Show failure message.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
