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
@end

@implementation MockData


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
   NSLog(@"Number: %@", number);
   return number;
}



- (NSArray *)getUpcomingActivities{
   
   NSMutableArray *activities = [[NSMutableArray alloc] init];
   
   Activity *act1 = [[Activity alloc] init];
   act1.activityName = @"Squash";
   act1.descriptionText = @"Lets play squash at the athletic courts";
   act1.startTime = @"10:00am";
   act1.endTime = @"12:00pm";
   //act1.participants = @[@"Joe", @"Kerry", @"Jane"];
   act1.address = @"Sandhill road";
   act1.distance = 1.3f;
   act1.date = @"11/27";
   act1.creator = [act1.participants firstObject];
   
   Activity *act2 = [[Activity alloc] init];
   act2.activityName = @"Pottery";
   act2.descriptionText = @"Let go make a pot";
   act2.startTime = @"2:00pm";
   act2.endTime = @"3:00pm";
   act2.participants = @[@"Jake", @"Cesca"];
   act2.address = @"1345 Middlefield Ave";
   act2.distance = 5.8f;
   act2.date = @"11/27";
   act2.creator = [act2.participants firstObject];

   Activity *act3 = [[Activity alloc] init];
   act3.activityName = @"Hide and Seek";
   act3.descriptionText = @"Lets play hide and seek";
   act3.startTime = @"8:00pm";
   act3.endTime = @"11:30pm";
   act3.participants = @[@"Larry", @"Bill", @"Nolan", @"Jenny", @"Daniel", @"Michelle"];
   act3.address = @"The forest";
   act3.distance = 3.4f;
   act3.date = @"11/27";
   act3.creator = [act3.participants firstObject];

   return NULL;
}

- (void)createPersonLibrary
{
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
   Person *p12 = [[Person alloc] initWithFirstName:@"Astul" lastName:@"Hernandez" number:[self generateRandomNumber]];
   Person *p13 = [[Person alloc] initWithFirstName:@"Jamie" lastName:@"Helyar" number:[self generateRandomNumber]];
   Person *p14 = [[Person alloc] initWithFirstName:@"Kitty" lastName:@"Kwan" number:[self generateRandomNumber]];
   Person *p15 = [[Person alloc] initWithFirstName:@"Kunle" lastName:@"Awejone" number:[self generateRandomNumber]];
   Person *p16 = [[Person alloc] initWithFirstName:@"Daniel" lastName:@"Stuart" number:[self generateRandomNumber]];
   Person *p17 = [[Person alloc] initWithFirstName:@"Grace" lastName:@"Stayner" number:[self generateRandomNumber]];
   Person *p18 = [[Person alloc] initWithFirstName:@"Rachel" lastName:@"Smith" number:[self generateRandomNumber]];
   Person *p19 = [[Person alloc] initWithFirstName:@"Holly" lastName:@"Wilsom" number:[self generateRandomNumber]];
   Person *p20 = [[Person alloc] initWithFirstName:@"Miles" lastName:@"Kool" number:[self generateRandomNumber]];
   
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
   [self.personLibrary addObject:p12];
   [self.personLibrary addObject:p13];
   [self.personLibrary addObject:p14];
   [self.personLibrary addObject:p15];
   [self.personLibrary addObject:p16];
   [self.personLibrary addObject:p17];
   [self.personLibrary addObject:p18];
   [self.personLibrary addObject:p19];
   [self.personLibrary addObject:p20];
   
}

@end
