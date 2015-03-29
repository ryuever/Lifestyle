//
//  PartyTabBarViewController.h
//  Lifestyle
//
//  Created by ryuyutyo on 3/29/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Party.h"

@interface PartyTabBarViewController : UITabBarController
@property (nonatomic, strong) NSString *labelString;
@property (nonatomic, strong) Party *selectedParty;
@property (nonatomic, strong) NSManagedObject *partyItem;
@end
