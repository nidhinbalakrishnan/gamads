//
//  InitializeViewController.h
//  Location Details
//
//  Created by NIDHIN BALAKRISHNAN on 21/02/16.
//  Copyright © 2016 Nidhin Balakrishnan. All rights reserved.
//

// Just to use a registration screen.
// Not using for the demo. Only main sensor details screen will be used.

#import <UIKit/UIKit.h>

@interface InitializeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;

- (IBAction)register:(id)sender;

@end
