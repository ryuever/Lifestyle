//
//  PartyInfoViewController.h
//  Lifestyle
//
//  Created by ryuyutyo on 3/8/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartyInfoViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *partyDescription;
@property (strong, nonatomic) IBOutlet UITextField *location;
@property (strong, nonatomic) IBOutlet UITextField *totalCost;
@property (strong, nonatomic) IBOutlet UITextField *date;

- (IBAction)back:(id)sender;
@end
