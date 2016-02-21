//
//  LocationViewController.h
//  Location Details
//
//  Created by NIDHIN BALAKRISHNAN on 20/02/16.
//  Copyright © 2016 Nidhin Balakrishnan. All rights reserved.
//

// A client side App designed to emulate a sensor data
// This app reads the Accelerometer and Gyroscope data and pushes it to the central server -
// using the API exposed by the central framework. Client side app or web page will be reading -
// this data using the API provided by the central framework as well.

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface LocationViewController : UIViewController <NSURLConnectionDelegate>

//Properties
@property (weak, nonatomic) IBOutlet UILabel *accXLabel;
@property (weak, nonatomic) IBOutlet UILabel *accYLabel;
@property (weak, nonatomic) IBOutlet UILabel *accZLabel;

@property (weak, nonatomic) IBOutlet UILabel *rotXLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotYLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotZLabel;


@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) NSMutableData* responseData;

// Methods
- (IBAction)startAccValues:(id)sender;
- (IBAction)stopAccValues:(id)sender;
- (IBAction)sendDataToServer:(id)sender;

@end
