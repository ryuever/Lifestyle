//
//  Party.h
//  Lifestyle
//
//  Created by ryuyutyo on 3/7/15.
//  Copyright (c) 2015 ryuyutyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kWhatsitDidChangeNotification		@"MyWhatsitDidChange"
#define kAddNewParticipantFinishedNotification      @"AddNewParticipantFinished"




@interface Party : NSObject

// cant use description as property
@property (strong,nonatomic) NSString* partyDescription;
@property (strong,nonatomic) NSString* date;
@property (strong,nonatomic) NSString* totalCost;
@property (strong,nonatomic) NSString* location;
@property (strong,nonatomic) NSString* registration;
@property (strong,nonatomic) NSMutableArray* members;
@property (strong,nonatomic) NSString* meetingPlace;
// @property (strong,nonatomic) NSString* location;

- (id)initWithDescription:(NSString*)description date:(NSString*)date totalCost:(NSString*)totalCost members:(NSMutableArray*)members;
- (void)postDidChangeNotification;
- (void)postAddNewParticipantFinishedNotification;

@end
