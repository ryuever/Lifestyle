//
//  PartyInfoViewController.m
//  Lifestyle
//
//  Created by ryuyutyo on 3/8/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import "PartyInfoViewController.h"
#import "PartiesMasterViewController.h"
#import "PartyTabBarViewController.h"

@interface PartyInfoViewController ()
{
    NSMutableArray* membersList;
}
@end

@implementation PartyInfoViewController
- (void)awakeFromNib {

    NSLog(@"in party info");
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(addNewMemberFinishedNotification:)
     name:kAddNewMemberFinishedNotification
     object:nil];
    
    [super awakeFromNib];
}

- (void)addNewMemberFinishedNotification:(NSNotification*)notification
{
    NSLog(@"new member is added");
    [self viewDidLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PartyTabBarViewController *tabBar = (PartyTabBarViewController *)self.tabBarController;
    if (tabBar.partyItem) {
        // NSLog(@"from info view controller : %@", [(Party *)tabBar.partyItem date]);
        self.partyDescription.text = [(Party *)tabBar.partyItem partyDescription];
        self.location.text = [(Party *)tabBar.partyItem location];
        self.date.text = [(Party *)tabBar.partyItem date];
        self.totalCost.text = [(Party *)tabBar.partyItem totalCost];
        // membersList = [(Party *)tabBar.partyItem members];
        
        // disable text field
        self.partyDescription.enabled = NO;
        self.totalCost.enabled = NO;
        self.date.enabled = NO;
        self.location.enabled = NO;
        
        membersList = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData *)[(Party *)tabBar.partyItem members]];
        
        NSInteger tc = [self.totalCost.text integerValue];
        self.memberNumber.text = [@([membersList count]) stringValue];
        NSInteger aveCost = tc / [membersList count];
        if (tc == 0) {
            self.averageCost.text = @"#";
        }else{
            self.averageCost.text = [@(aveCost) stringValue];
        }
    }
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                  target:self action:@selector(editInfo:)];
    self.navigationItem.rightBarButtonItem = editButton;

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


- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)editInfo:(id)sender {
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                   target:self action:@selector(finishEditInfo:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    self.totalCost.enabled = YES;
    
}

- (IBAction)finishEditInfo:(id)send{
    NSManagedObjectContext *context = [self managedObjectContext];
    PartyTabBarViewController *tabBar = (PartyTabBarViewController *)self.tabBarController;
    [tabBar.partyItem setValue:self.totalCost.text forKey:@"totalCost"];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                   target:self action:@selector(editInfo:)];
    self.navigationItem.rightBarButtonItem = editButton;
    [self viewDidLoad];
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.view endEditing:NO];
}

@end
