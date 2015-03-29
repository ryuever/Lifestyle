//
//  Party.m
//  Lifestyle
//
//  Created by ryuyutyo on 3/7/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import "Party.h"

@implementation Party


- (id)initWithDescription:(NSString*)partyDescription date:(NSString*)date totalCost:(NSString*)totalCost members:(NSMutableArray*)members
{
    NSLog(@"initialization");
    self = [super init];
    if (self) {
        self.date = date;
        self.partyDescription = partyDescription;
        self.totalCost = totalCost;
        self.members = members;
    }
    NSLog(@"initialization finished");
    return self;
}

//- (id)initWithName:(NSString*)name lab:(NSString*)lab
//{
//    self = [super init];
//    if (self) {
//        self.name = name;
//        self.lab = lab;
//    }
//    return self;
//}
//
- (void)postDidChangeNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kWhatsitDidChangeNotification
                                                        object:self];
}

- (void)postAddNewParticipantFinishedNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddNewParticipantFinishedNotification object:self];
}


@end
