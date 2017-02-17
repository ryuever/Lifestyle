//
//  PartiesNewViewController.h
//  Lifestyle
//
//  Created by ryuyutyo on 3/8/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Party.h"

@interface PartiesNewViewController : UIViewController
@property (strong, nonatomic) Party *item;

@property (weak,nonatomic) IBOutlet UITextField *descriptionField;
@property (weak,nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextView *locationField;
@property (weak, nonatomic) IBOutlet UITextView *registrationField;
@property (weak, nonatomic) IBOutlet UITextView *meetingPlaceField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardHeight;

- (IBAction)addDidFinished:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
@end
