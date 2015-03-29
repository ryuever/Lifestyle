//
//  PartyNewMemberViewController.m
//  Lifestyle
//
//  Created by ryuyutyo on 3/29/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import "PartyNewMemberViewController.h"
#import <CoreData/CoreData.h>

@interface PartyNewMemberViewController ()
{
    NSMutableArray* membersList;
}
@end

@implementation PartyNewMemberViewController
//@synthesize partyNewMember;
//@synthesize labelString;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"%@", self.labelString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSLog(@"memberList is %@", self.partyNewMember);
//    membersList = [NSKeyedUnarchiver unarchiveObjectWithData:[(Party *)tabBar.partyItem members]];
//    NSLog(@"memberField.text is : %@", self.memberField.text);
//    NSLog(@"before insert membersList : %@", membersList);
    [self.partyNewMember addObject:self.memberField.text];
    //[self.partyNewMember insertObject:self.memberField.text atIndex:0];
    NSLog(@"membersList is %@", self.partyNewMember);
//    NSLog(@"after insert membersList : %@", membersList);
    // NSMutableArray * member2 = [NSMutableArray arrayWithArray:@[@"lifdffu", @"mmmmm"]];

    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:self.partyNewMember];
    // NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:member2];
    [self.partyNewItem setValue:arrayData forKey:@"members"];
//        
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
        
    // Remove device from table view
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end