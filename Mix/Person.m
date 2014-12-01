//
//  Person.m
//  Mix
//
//  Created by Kirby Gee on 11/30/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithFirstName:(NSString *)first lastName:(NSString *)last number:(NSString *)number{
   self = [super init];
   if (self) {
      self.firstName = first;
      self.lastName = last;
      self.phoneNumber = number;
       self.imageName = [NSString stringWithFormat:@"%@_%@.png", self.firstName.lowercaseString, self.lastName.lowercaseString];
   }
   
   return self;
}
@end
