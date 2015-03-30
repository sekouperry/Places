//
//  SplashViewController.m
//  Places
//
//  Created by Ishan on 3/30/15.
//  Copyright (c) 2015 Ishan. All rights reserved.
//

#import "Constants.h"
#import "SplashViewController.h"

@interface SplashViewController ()

@property (strong, nonatomic) NSTimer *loadHomeTimer;
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loadHomeTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(loadHome) userInfo:nil repeats:NO];
    
    // Setting up the touch interface.
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTapped:)];
    [self.view addGestureRecognizer:self.tapRecognizer];
    
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void) screenTapped:(UITapGestureRecognizer *)recognizer {
    // Handle screen tap.
    [self.loadHomeTimer invalidate];
    [self loadHome];
}

- (void) loadHome {
    [self performSegueWithIdentifier:LOAD_HOME_SEGUE sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
