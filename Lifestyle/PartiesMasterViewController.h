//
//  PartiesMasterViewController.h
//  Lifestyle
//
//  Created by ryuyutyo on 3/7/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Party.h"


@interface PartiesMasterViewController : UITableViewController

// @property (weak,nonatomic) IBOutlet UIButton *backToHome;
@property (strong) NSMutableArray *partiesList;

- (IBAction)backToHome:(id)sender;
- (IBAction)addItem:(id)sender;
@end
