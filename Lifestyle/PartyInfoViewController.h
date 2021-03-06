//
//  PartyInfoViewController.h
//  Lifestyle
//
//  Created by ryuyutyo on 3/8/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kAddNewMemberFinishedNotification      @"AddNewMemberFinished"

@interface PartyInfoViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *partyDescription;
@property (strong, nonatomic) IBOutlet UITextField *totalCost;
@property (strong, nonatomic) IBOutlet UITextField *date;
@property (strong, nonatomic) IBOutlet UILabel *averageCost;
@property (weak, nonatomic) IBOutlet UILabel *memberNumber;
@property (strong, nonatomic) IBOutlet UITextView *location;
@property (strong, nonatomic) IBOutlet UITextView *registration;
@property (strong, nonatomic) IBOutlet UITextField *meetingPlace;


- (IBAction)back:(id)sender;
- (IBAction)editInfo:(id)sender;
- (IBAction)finishEditInfo:(id)send;
- (IBAction)dismissKeyboard:(id)sender;
@end
