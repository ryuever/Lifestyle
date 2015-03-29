//
//  PartiesNewViewController.m
//  Lifestyle
//
//  Created by ryuyutyo on 3/8/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import "PartiesNewViewController.h"
// #import "CoreData"
#import <CoreData/CoreData.h>
@interface PartiesNewViewController ()
{
    NSMutableArray* things;
}
@end

@implementation PartiesNewViewController

- (void)viewDidLoad {
    // things = [NSMutableArray arrayWithArray:@[@"China", @"Japan"]];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self numberOfSectionsInTableView:self.members];
//    [self tableView:self.members canEditRowAtIndexPath:<#(NSIndexPath *)#>]
    
    
    
    NSLog(@"finished");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRowInSection method : count is %lu", (unsigned long)things.count);
    return things.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //NSDate *object = things[indexPath.row];
    //  cell.textLabel.text = [object description];
    // cell.textLabel.text = [things objectAtIndex:indexPath.row];
    cell.textLabel.text = [things objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)addDidFinished:(id)sender
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newParty = [NSEntityDescription insertNewObjectForEntityForName:@"PartiesList" inManagedObjectContext:context];
    
    
    NSMutableArray * membersList = [NSMutableArray arrayWithArray:@[@"liu", @"yu"]];
    NSLog(@"in parties new : membersList %@ ", membersList);
    [membersList addObject:@"ma"];
    NSLog(@"in parties new : membersList %@ ", membersList);
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:membersList];
    
    [newParty setValue:self.descriptionField.text forKey:@"partyDescription"];
    [newParty setValue:self.dateField.text forKey:@"date"];
    [newParty setValue:self.locationField.text forKey:@"location"];
    [newParty setValue:arrayData forKey:@"members"];
 
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

//- (IBAction)addDidFinished:(id)sender
//{
//    NSLog(@"addition is finished");
//    NSLog(@"presented view controller is %@", self.presentedViewController);
//    NSLog(@"presenting view controller is %@", self.presentingViewController);
//    //    NSMutableArray* membersValue =
//    self.item = [[Party alloc] initWithDescription:self.descriptionField.text date:self.dateField.text totalCost:NULL members:NULL];
//    
//    [self.item postAddNewParticipantFinishedNotification];
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//}


- (IBAction)cancel:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
