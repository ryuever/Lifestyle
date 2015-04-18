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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    [self.partyNewMember addObject:self.memberField.text];
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:self.partyNewMember];
    [self.partyNewItem setValue:arrayData forKey:@"members"];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddNewMemberFinishedNotification object:self];
    // Remove device from table view
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end