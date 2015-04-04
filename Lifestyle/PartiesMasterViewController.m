//
//  PartiesMasterViewController.m
//  Lifestyle
//
//  Created by ryuyutyo on 3/7/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import "PartiesMasterViewController.h"
#import "PartiesNewViewController.h"
#import "PartiesDetailViewController.h"
#import "PartyInfoViewController.h"
#import <CoreData/CoreData.h>
#import <CoreData/NSFetchRequest.h>
#import "Party.h"
#import "PartyTabBarViewController.h"

@interface PartiesMasterViewController ()
//{
//    NSMutableArray* partiesList;
//}
@end

@implementation PartiesMasterViewController

- (void)awakeFromNib {
//    NSLog(@"initialization finised");
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self
//     selector:@selector(whatsitDidChangeNotification:)
//     name:kWhatsitDidChangeNotification
//     object:nil];
    
// manually add a + button
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(addNewParticipantFinishedNotification:)
     name:kAddNewParticipantFinishedNotification
     object:nil];
    
    [super awakeFromNib];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSLog(@"before parties list");

    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"PartiesList"];

    self.partiesList = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    NSLog(@"view did load");
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.partiesList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"partiesCell" forIndexPath:indexPath];
    
    NSManagedObject *partyItem = [self.partiesList objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", [partyItem valueForKey:@"partyDescription"], [partyItem valueForKey:@"location"]]];
    [cell.detailTextLabel setText:[partyItem valueForKey:@"date"]];
    
    return cell;
}

- (void)addNewParticipantFinishedNotification:(NSNotification*)notification
{
    NSLog(@"new participant notification selector");
    Party *item = notification.object;
    [self.partiesList insertObject:item atIndex:0];
    NSLog(@"received item is %@", item);
    [self.tableView reloadData];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *context = [self managedObjectContext];

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [context deleteObject:[self.partiesList objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.partiesList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [self.partiesList insertObject:@"insert" atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }   
}

-(IBAction)backToHome:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"tab"]){
        PartyTabBarViewController *tabBar = [segue destinationViewController];
        tabBar.selectedParty = (Party *)[self.partiesList objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        tabBar.partyItem = [self.partiesList objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        NSLog(@"partiesList in PartiesMasterViewController %@", self.partiesList);
        NSLog(@"partyItem in PartiesMasterViewController %@", [self.partiesList objectAtIndex:self.tableView.indexPathForSelectedRow.row]);
//        NSLog(@"selected item : %@", [(Party *)[self.partiesList objectAtIndex:self.tableView.indexPathForSelectedRow.row] date]);
        NSLog(@"%@", self.partiesList);
//        NSLog(@"selectedParty : %@", [tabBar.selectedParty date]);
//        [tabBar setLabelString:[NSString stringWithFormat:@"This has been set"]];
//        // initWithDescription:(NSString*)partyDescription date:(NSString*)date totalCost:(NSString*)totalCost members:(NSMutableArray*)members

    }
}




@end
