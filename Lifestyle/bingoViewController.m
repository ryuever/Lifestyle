//
//  bingoViewController.m
//  Lifestyle
//
//  Created by ryuyutyo on 4/4/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import "bingoViewController.h"

@interface bingoViewController ()
{
    NSMutableArray* membersList;
}
- (void)fadeFortune;
- (void)newFortune;
@end

@implementation bingoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PartyTabBarViewController *tabBar = (PartyTabBarViewController *)self.tabBarController;
    membersList = [NSKeyedUnarchiver unarchiveObjectWithData:[(Party *)tabBar.partyItem members]];
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


- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion==UIEventSubtypeMotionShake)
        // User has started shaking device: make the current fortune disappear
        [self fadeFortune];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion==UIEventSubtypeMotionShake)
        // User has stopped shaking device: make a new fortune appear
        [self newFortune];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion==UIEventSubtypeMotionShake)
        // User started shaking device, but did not complete gesture: reset
        [self newFortune];
}

#pragma mark Wisdom

- (void)fadeFortune
{
    [UIView animateWithDuration:0.75 animations:^{
        self.getChance.alpha = 0.0;
    }];
}

- (void)newFortune
{
    // Choose a different answer at random
    NSLog(@"new value");
    self.getChance.text = membersList[arc4random_uniform([membersList count])];
    
    // Animate the view so the answer slowly appears
    [UIView animateWithDuration:2.0 animations:^{
        self.getChance.alpha = 1.0;
    }];
}



@end
