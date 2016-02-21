//
//  LocationViewController.m
//  Location Details
//
//  Created by NIDHIN BALAKRISHNAN on 20/02/16.
//  Copyright © 2016 Nidhin Balakrishnan. All rights reserved.
//

#import "LocationViewController.h"
#import "InitializeViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface LocationViewController ()

@end

@implementation LocationViewController

@synthesize accXLabel, accYLabel, accZLabel, rotXLabel, rotYLabel, rotZLabel, stopButton, startButton, motionManager, responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self stopAccValues];
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = 1;
    self.motionManager.gyroUpdateInterval = 1;
    
    self.responseData = [NSMutableData data];
}

- (IBAction)startAccValues:(id)sender {
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelertionData:accelerometerData.acceleration];
                                                 if(error){
                                                     NSLog(@"%@", error);
                                                 }
                                             }];
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
                                    withHandler:^(CMGyroData *gyroData, NSError *error) {
                                        [self outputRotationData:gyroData.rotationRate];
                                    }];
}

- (IBAction)stopAccValues:(id)sender {
    [self.motionManager stopAccelerometerUpdates];
    [self.motionManager stopGyroUpdates];
    
    [self stopAccValues];
}

- (void)stopAccValues {
    [accXLabel setText: [NSString stringWithFormat:@"%d", 0]];
    [accYLabel setText: [NSString stringWithFormat:@"%d", 0]];
    [accZLabel setText: [NSString stringWithFormat:@"%d", 0]];
    [rotXLabel setText: [NSString stringWithFormat:@"%d", 0]];
    [rotYLabel setText: [NSString stringWithFormat:@"%d", 0]];
    [rotZLabel setText: [NSString stringWithFormat:@"%d", 0]];
}

-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    [self.accXLabel setText:[NSString stringWithFormat:@" %.2fg",acceleration.x]];
    [self.accYLabel setText:[NSString stringWithFormat:@" %.2fg",acceleration.y]];
    [self.accZLabel setText:[NSString stringWithFormat:@" %.2fg",acceleration.z]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://10.14.121.219:8081/putSensorValues?sid=8&value=%f", acceleration.x]]];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Success...");
    }
}

-(void)outputRotationData:(CMRotationRate)rotation
{
    self.rotXLabel.text = [NSString stringWithFormat:@" %.2fr/s",rotation.x];
    self.rotYLabel.text = [NSString stringWithFormat:@" %.2fr/s",rotation.y];
    self.rotZLabel.text = [NSString stringWithFormat:@" %.2fr/s",rotation.z];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://10.14.121.219:8081/putSensorValues?sid=9&value=%f", rotation.x]]];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Success...");
    }

}

// delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    /*
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    for(id key in res) {
        
        id value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
    }
    
    // extract specific value...
    NSArray *results = [res objectForKey:@"results"];
    
    for (NSDictionary *result in results) {
        NSString *icon = [result objectForKey:@"icon"];
        NSLog(@"icon: %@", icon);
    }
    */
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

- (IBAction)sendDataToServer:(id)sender {
}

@end
