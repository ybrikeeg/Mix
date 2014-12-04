//
//  MockData.m
//  Mix
//
//  Created by Kirby Gee on 11/30/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "MockData.h"
#import "Activity.h"
#import "Person.h"

@interface MockData ()
@property (nonatomic, strong) NSMutableArray *personLibrary;
@property (nonatomic, strong) NSMutableArray *upcomingActivities;
@property (nonatomic, strong) NSMutableArray *pastActivities;
@end

@implementation MockData

+ (MockData *) sharedObj
{
    static MockData * shared = nil;
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        
        shared = [[MockData alloc] init];
        [shared createPersonLibrary];
        [shared createUpcomingActivities];
        [shared createPastActivities];
    });
    return shared;
}

- (NSString *)generateRandomNumber
{
   NSString *number = [[NSString alloc] init];
   for (int i = 0; i < 7; i++){
      int rand = arc4random()%9;
      number = [number stringByAppendingString:[NSString stringWithFormat:@"%d", rand]];
      if (i == 2){
         number = [number stringByAppendingString:@"-"];
         
      }
   }
   return number;
}



- (NSArray *)getUpcomingActivities{
    return self.upcomingActivities;
}

- (NSArray *)getPastEvents{
    return self.pastActivities;
}

- (void)createUpcomingActivities{
    self.upcomingActivities = [[NSMutableArray alloc] init];
    
    Activity *act1 = [[Activity alloc] init];
    act1.activityName = @"Roller Hockey";
    act1.descriptionText = @"Lets play roller hockey at the skating rink";
    act1.startTime = @"10a";
    act1.endTime = @"12p";
    act1.participants = @[[self.personLibrary objectAtIndex:0], [self.personLibrary objectAtIndex:1], [self.personLibrary objectAtIndex:2], [self.personLibrary objectAtIndex:3], [self.personLibrary objectAtIndex:4], [self.personLibrary objectAtIndex:5], [self.personLibrary objectAtIndex:6], [self.personLibrary objectAtIndex:7]];
    act1.address = @"Sandhill road";
    act1.distance = 1.3f;
    
    act1.creator = [act1.participants firstObject];
    act1.category = @"Sport";
    act1.date = @"11/27";
    
    
    Activity *act2 = [[Activity alloc] init];
    act2.activityName = @"Pottery";
    act2.descriptionText = @"Let go make a pot";
    act2.startTime = @"2p";
    act2.endTime = @"3p";
    act2.participants = @[[self.personLibrary objectAtIndex:8], [self.personLibrary objectAtIndex:9], [self.personLibrary objectAtIndex:5]];
    act2.address = @"1345 Middlefield Ave";
    act2.distance = 5.8f;
    
    act2.creator = [act2.participants firstObject];
    act2.category = @"Craft";
    act2.date = @"11/27";
    
    
    Activity *act3 = [[Activity alloc] init];
    act3.activityName = @"Concert in the Park";
    act3.descriptionText = @"Lets go to a concert";
    act3.startTime = @"8p";
    act3.endTime = @"11p";
    act3.participants = @[[self.personLibrary objectAtIndex:3], [self.personLibrary objectAtIndex:0], [self.personLibrary objectAtIndex:2], [self.personLibrary objectAtIndex:7], [self.personLibrary objectAtIndex:8]];
    act3.address = @"The park";
    act3.distance = 3.4f;
    
    act3.creator = [act3.participants firstObject];
    act3.category = @"Fine Arts";
    act3.date = @"11/27";
    
    Activity *act4 = [[Activity alloc] init];
    act4.activityName = @"CS107 Study Session";
    act4.descriptionText = @"Lets study together for 107";
    act4.startTime = @"9p";
    act4.endTime = @"11p";
    act4.participants = @[[self.personLibrary objectAtIndex:1], [self.personLibrary objectAtIndex:9], [self.personLibrary objectAtIndex:6], [self.personLibrary objectAtIndex:7], [self.personLibrary objectAtIndex:3]];
    act4.address = @"Old Union";
    act4.distance = 2.1f;
    
    act4.creator = [act4.participants firstObject];
    act4.category = @"Education";
    act4.date = @"11/27";
    
    Activity *act5 = [[Activity alloc] init];
    act5.activityName = @"Beer Pong";
    act5.descriptionText = @"Lets play beer pong in the morning";
    act5.startTime = @"8a";
    act5.endTime = @"9a";
    act5.participants = @[[self.personLibrary objectAtIndex:2], [self.personLibrary objectAtIndex:5], [self.personLibrary objectAtIndex:8]];
    act5.address = @"Toyon";
    act5.distance = 1.0f;
    
    act5.creator = [act5.participants firstObject];
    act5.category = @"Social";
    act5.date = @"11/27";
    
    [self.upcomingActivities addObject:act1];
    [self.upcomingActivities addObject:act2];
    [self.upcomingActivities addObject:act3];
    [self.upcomingActivities addObject:act4];
    [self.upcomingActivities addObject:act5];
}

- (void)createPastActivities{
    self.pastActivities = [[NSMutableArray alloc] init];
    
    Activity *act1 = [[Activity alloc] init];
    act1.activityName = @"Soccer";
    act1.descriptionText = @"Lets play soccer at the field";
    act1.startTime = @"9a";
    act1.endTime = @"12p";
    act1.participants = @[[self.personLibrary objectAtIndex:4], [self.personLibrary objectAtIndex:3], [self.personLibrary objectAtIndex:6], [self.personLibrary objectAtIndex:9], [self.personLibrary objectAtIndex:2], [self.personLibrary objectAtIndex:1], [self.personLibrary objectAtIndex:0], [self.personLibrary objectAtIndex:7]];
    act1.address = @"Soccer Field";
    act1.distance = 1.5f;
    
    act1.creator = [act1.participants firstObject];
    act1.category = @"Sport";
    act1.date = @"11/26";
    
    
    Activity *act2 = [[Activity alloc] init];
    act2.activityName = @"Underwater Basket Weaving";
    act2.descriptionText = @"Let make a basket underwater";
    act2.startTime = @"4p";
    act2.endTime = @"5p";
    act2.participants = @[[self.personLibrary objectAtIndex:5], [self.personLibrary objectAtIndex:4], [self.personLibrary objectAtIndex:2]];
    act2.address = @"618 Escondido Rd.";
    act2.distance = 3.8f;
    
    act2.creator = [act2.participants firstObject];
    act2.category = @"Craft";
    act2.date = @"11/24";
    
    
    Activity *act3 = [[Activity alloc] init];
    act3.activityName = @"Painting";
    act3.descriptionText = @"Lets go paint a picture";
    act3.startTime = @"3p";
    act3.endTime = @"5p";
    act3.participants = @[[self.personLibrary objectAtIndex:8], [self.personLibrary objectAtIndex:9]];
    act3.address = @"Crothers";
    act3.distance = 3.8f;
    
    act3.creator = [act3.participants firstObject];
    act3.category = @"Fine Arts";
    act3.date = @"11/23";
    
    Activity *act4 = [[Activity alloc] init];
    act4.activityName = @"CS103 PSET";
    act4.descriptionText = @"Lets work on the 103 PSET";
    act4.startTime = @"8p";
    act4.endTime = @"11p";
    act4.participants = @[[self.personLibrary objectAtIndex:1], [self.personLibrary objectAtIndex:2], [self.personLibrary objectAtIndex:3]];
    act4.address = @"Old Union";
    act4.distance = 2.1f;
    
    act4.creator = [act4.participants firstObject];
    act4.category = @"Education";
    act4.date = @"11/20";
    
    Activity *act5 = [[Activity alloc] init];
    act5.activityName = @"Picnic at Lake Lag";
    act5.descriptionText = @"Lets have a picnic around Lake Lag";
    act5.startTime = @"11a";
    act5.endTime = @"12p";
    act5.participants = @[[self.personLibrary objectAtIndex:7], [self.personLibrary objectAtIndex:9], [self.personLibrary objectAtIndex:4]];
    act5.address = @"Lake Lag";
    act5.distance = 4.4f;
    
    act5.creator = [act5.participants firstObject];
    act5.category = @"Social";
    act5.date = @"11/15";
    
    [self.pastActivities addObject:act1];
    [self.pastActivities addObject:act2];
    [self.pastActivities addObject:act3];
    [self.pastActivities addObject:act4];
    [self.pastActivities addObject:act5];
}

- (void)createPersonLibrary
{
    self.personLibrary = [[NSMutableArray alloc] init];
   Person *p1 = [[Person alloc] initWithFirstName:@"Kirby" lastName:@"Gee" number:[self generateRandomNumber]];
   Person *p2 = [[Person alloc] initWithFirstName:@"William" lastName:@"Huang" number:[self generateRandomNumber]];
   Person *p3 = [[Person alloc] initWithFirstName:@"Cesca" lastName:@"Fleischer" number:[self generateRandomNumber]];
   Person *p4 = [[Person alloc] initWithFirstName:@"Randy" lastName:@"Johnson" number:[self generateRandomNumber]];
   Person *p5 = [[Person alloc] initWithFirstName:@"Jenny" lastName:@"Cowell" number:[self generateRandomNumber]];
   Person *p6 = [[Person alloc] initWithFirstName:@"Dakota" lastName:@"Jones" number:[self generateRandomNumber]];
   Person *p7 = [[Person alloc] initWithFirstName:@"Allen" lastName:@"Wong" number:[self generateRandomNumber]];
   Person *p8 = [[Person alloc] initWithFirstName:@"Lillian" lastName:@"Mechum" number:[self generateRandomNumber]];
   Person *p9 = [[Person alloc] initWithFirstName:@"Gavin" lastName:@"Avery" number:[self generateRandomNumber]];
   Person *p10 = [[Person alloc] initWithFirstName:@"Christina" lastName:@"Chen" number:[self generateRandomNumber]];
   Person *p11 = [[Person alloc] initWithFirstName:@"Mike" lastName:@"Precup" number:[self generateRandomNumber]];
//   Person *p12 = [[Person alloc] initWithFirstName:@"Astul" lastName:@"Hernandez" number:[self generateRandomNumber]];
//   Person *p13 = [[Person alloc] initWithFirstName:@"Jamie" lastName:@"Helyar" number:[self generateRandomNumber]];
//   Person *p14 = [[Person alloc] initWithFirstName:@"Kitty" lastName:@"Kwan" number:[self generateRandomNumber]];
//   Person *p15 = [[Person alloc] initWithFirstName:@"Kunle" lastName:@"Awejone" number:[self generateRandomNumber]];
//   Person *p16 = [[Person alloc] initWithFirstName:@"Daniel" lastName:@"Stuart" number:[self generateRandomNumber]];
//   Person *p17 = [[Person alloc] initWithFirstName:@"Grace" lastName:@"Stayner" number:[self generateRandomNumber]];
//   Person *p18 = [[Person alloc] initWithFirstName:@"Rachel" lastName:@"Smith" number:[self generateRandomNumber]];
//   Person *p19 = [[Person alloc] initWithFirstName:@"Holly" lastName:@"Wilsom" number:[self generateRandomNumber]];
//   Person *p20 = [[Person alloc] initWithFirstName:@"Miles" lastName:@"Kool" number:[self generateRandomNumber]];
   
   [self.personLibrary addObject:p1];
   [self.personLibrary addObject:p2];
   [self.personLibrary addObject:p3];
   [self.personLibrary addObject:p4];
   [self.personLibrary addObject:p5];
   [self.personLibrary addObject:p6];
   [self.personLibrary addObject:p7];
   [self.personLibrary addObject:p8];
   [self.personLibrary addObject:p9];
   [self.personLibrary addObject:p10];
   [self.personLibrary addObject:p11];
//   [self.personLibrary addObject:p12];
//   [self.personLibrary addObject:p13];
//   [self.personLibrary addObject:p14];
//   [self.personLibrary addObject:p15];
//   [self.personLibrary addObject:p16];
//   [self.personLibrary addObject:p17];
//   [self.personLibrary addObject:p18];
//   [self.personLibrary addObject:p19];
//   [self.personLibrary addObject:p20];
   
}

- (NSArray *)getPersonLibrary{
    return self.personLibrary;
}

@end
