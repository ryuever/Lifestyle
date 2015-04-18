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
    NSLog(@"notification of new member finised comes to party member view controll");
    [self viewDidLoad];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PartyTabBarViewController *tabBar = (PartyTabBarViewController *)self.tabBarController;
    membersList = [NSKeyedUnarchiver unarchiveObjectWithData:[(Party *)tabBar.partyItem members]];
    self.getChance.UserInteractionEnabled = true;
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
    NSLog(@"get value is %@", self.getChance.text);
    // Animate the view so the answer slowly appears
    [UIView animateWithDuration:0.5 animations:^{
        self.getChance.alpha = 1.0;
    }];
}


//- (BOOL)canBecomeFirstResponder {
//    return NO;
//}

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    if (action == @selector(copy:) || action == @selector(selectAll:) || action == @selector(paste:))
//        return NO;
//    return [super canPerformAction:action withSender:sender];
//}

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    if (action == @selector(paste:))
//        return NO;
//    if (action == @selector(select:))
//        return NO;
//    if (action == @selector(selectAll:))
//        return NO;
//    return [super canPerformAction:action withSender:sender];
//}
//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    [UIMenuController sharedMenuController].menuVisible = NO;
//    return NO;
//}

- (IBAction)touchForChange:(id)sender {
    NSLog(@"new value");
    self.getChance.text = membersList[arc4random_uniform([membersList count])];
    // self.getChance.userInteractionEnabled = NO;
    NSLog(@"get value is %@", self.getChance.text);
}
@end
