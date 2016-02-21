//
//  AppDelegate.h
//  Location Details
//
//  Created by NIDHIN BALAKRISHNAN on 20/02/16.
//  Copyright © 2016 Nidhin Balakrishnan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@class LocationViewController, InitializeViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) LocationViewController *locationViewController;
@property (strong, nonatomic) InitializeViewController *initializeViewController;

@end

