//
//  PartyNewMemberViewController.h
//  Lifestyle
//
//  Created by ryuyutyo on 3/29/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#define kAddNewMemberFinishedNotification      @"AddNewMemberFinished"

@interface PartyNewMemberViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *memberField;
@property (nonatomic, strong) NSManagedObject *partyNewItem;

@property (strong, nonatomic) NSMutableArray *partyNewMember;
// @property (nonatomic, strong) NSString *labelString;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end
