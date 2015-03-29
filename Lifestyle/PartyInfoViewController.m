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

@end

@implementation PartyInfoViewController
// @synthesize label;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PartyTabBarViewController *tabBar = (PartyTabBarViewController *)self.tabBarController;
//    NSLog(@"%@", tabBar.labelString);
//    label.text = [NSString stringWithFormat:@"Tab %lu: %@",(unsigned long)[tabBar.viewControllers indexOfObject:self],tabBar.labelString];
//    NSLog(@"%@", label.text)
    if (tabBar.partyItem) {
//        NSLog(@"from info view controller : %@", [tabBar.selectedParty date]);
//        self.partyDescription.text = [tabBar.selectedParty partyDescription];
//        self.location.text = [tabBar.selectedParty location];
//        self.date.text = [tabBar.selectedParty date];
        
        NSLog(@"from info view controller : %@", [(Party *)tabBar.partyItem date]);
        self.partyDescription.text = [(Party *)tabBar.partyItem partyDescription];
        self.location.text = [(Party *)tabBar.partyItem location];
        self.date.text = [(Party *)tabBar.partyItem date];
    }
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
@end
