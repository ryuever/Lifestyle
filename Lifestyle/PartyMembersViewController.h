//
//  PartyMembersViewController.h
//  Lifestyle
//
//  Created by ryuyutyo on 3/8/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartyNewMemberViewController.h"
#define kAddNewMemberFinishedNotification      @"AddNewMemberFinished"

@interface PartyMembersViewController : UITableViewController
- (IBAction)backToPartiesList:(id)sender;
- (IBAction)addNewMember:(id)sender;

@end
