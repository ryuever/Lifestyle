//
//  PartyMembersViewController.m
//  Lifestyle
//
//  Created by ryuyutyo on 3/8/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import "PartyMembersViewController.h"
#import "PartyTabBarViewController.h"
#import "PartyNewMemberViewController.h"
#import <CoreData/CoreData.h>
#import <CoreData/NSFetchRequest.h>


@interface PartyMembersViewController ()
{
    NSMutableArray* membersList;
}
@end

@implementation PartyMembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // membersList = [NSMutableArray arrayWithArray:@[@"liu", @"yu", @"ma"]];
    PartyTabBarViewController *tabBar = (PartyTabBarViewController *)self.tabBarController;
    membersList = [NSKeyedUnarchiver unarchiveObjectWithData:[(Party *)tabBar.partyItem members]];

    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                      target:self
                                      action:@selector(backToPartiesList:)];
    self.navigationItem.leftBarButtonItem = customBarItem;

    // when poped up it will be under Editing mode
    // [self.tableView setEditing:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return membersList.count;
    // return [[tabBar.selectedParty members] count];
    // return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"membersCell" forIndexPath:indexPath];
//    
//    Party* item = partiesList[indexPath.row];
//    cell.textLabel.text = item.partyDescription;
    cell.textLabel.text = membersList[indexPath.row];
    
    return cell;
}

// tap a table row to attach a selection mark.
- (void)tableView:(UITableView *)theTableView
didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath {
    
    [theTableView deselectRowAtIndexPath:[theTableView indexPathForSelectedRow] animated:NO];
    UITableViewCell *cell = [theTableView cellForRowAtIndexPath:newIndexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        // [self.view setTintColor:[UIColor purpleColor]];
        [self.tableView setTintColor:[UIColor redColor]];
        // self.tableView.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        // Reflect selection in data model
        
    } else if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        // Reflect deselection in data model
    }
}

//// commit editing mode operations (including delete)
//- (void)tableView:(UITableView *)tableView
//commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
//forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [membersList removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath]
//                         withRowAnimation:UITableViewRowAnimationFade];
//    }
////    
////    else if (editingStyle == UITableViewCellEditingStyleInsert) {
////        [membersList insertObject:@"add member" atIndex:indexPath.row];
////        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
////    }
//}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    PartyTabBarViewController *tabBar = (PartyTabBarViewController *)self.tabBarController;

    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [membersList removeObjectAtIndex:indexPath.row];
         NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:membersList];
        [tabBar.partyItem setValue:arrayData forKey:@"members"];
         
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"can remove");
//    if (indexPath.row == 0) // Don't move the first row
//        return NO;
//    
//    return YES;
//}

// implement movable operation
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:
                    (NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = membersList[sourceIndexPath.row];
    [membersList removeObjectAtIndex:sourceIndexPath.row];
    [membersList insertObject:stringToMove atIndex:destinationIndexPath.row];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//        NSInteger ct = [self tableView:tableView numberOfRowsInSection:indexPath.section];
//        if (ct - 1  == indexPath.row){
//            return UITableViewCellEditingStyleInsert;
//        }
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}


//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
//           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        NSInteger ct = [self tableView:tableView numberOfRowsInSection:indexPath.section];
//        if (ct-1 == indexPath.row)
//            return UITableViewCellEditingStyleInsert;
//        return UITableViewCellEditingStyleDelete;
//    }
//    return UITableViewCellEditingStyleNone;
//}
//
- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    
}

//- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    [super setEditing:editing animated:animated];
//    [self.tableView setEditing:editing animated:YES];
//    if (editing) {
//        InsertButton.enabled = NO;
//    } else {
//        deleteButton.enabled = YES;
//    }
//}



- (void)insertNewMember:(id)sender {

    
//    if (!things) {
//        things = [[NSMutableArray alloc] init];
//    }
//    
//    Participant *newItem = [[Participant alloc] initWithName:@"liu" lab:@"tan"];
//    
//    [things insertObject:newItem atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    
    // dynamically add an item
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"partyNewMember"]){
    PartyTabBarViewController *tabBar = (PartyTabBarViewController *)self.tabBarController;

    NSLog(@"in prepare for segue from party members list");
    PartyNewMemberViewController *pnvc = [segue destinationViewController];
    NSLog(@"membersList is %@", membersList);
    //[pnvc.partyNewMember addObjectsFromArray:membersList];
    // pnvc.partyNewMember = [[NSMutableArray alloc] initWithObjects:membersList, nil];
    pnvc.partyNewMember = membersList;
    pnvc.partyNewItem = tabBar.partyItem;
//        NSLog(@"pnvc partyNewMember is %@", pnvc.partyNewMember);
    NSLog(@"pnvc is %@", pnvc.partyNewMember);


        //        [tabBar setLabelString:[NSString stringWithFormat:@"This has been set"]];
        //        // initWithDescription:(NSString*)partyDescription date:(NSString*)date totalCost:(NSString*)totalCost members:(NSMutableArray*)members
        
  //  }
}

- (IBAction)backToPartiesList:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addNewMember:(id)sender {
}
@end
