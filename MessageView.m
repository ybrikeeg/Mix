//
//  MessageView.m
//  Mix
//
//  Created by Kirby Gee on 12/1/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "MessageView.h"
#import "MockData.h"
#import "ActivityHeaderBar.h"
#import "PersonBar.h"
#import "Person.h"
#import <MessageUI/MessageUI.h>

@interface MessageView ()
@property (nonatomic, strong) NSArray *pastActivites;
@property (nonatomic, strong) UIScrollView *messageScrollView;
@property (nonatomic, strong, readwrite) NSMutableArray *personBarArray;
@end
@implementation MessageView

- (instancetype)initWithFrame:(CGRect)frame{
   
   self = [super initWithFrame:frame];
   if (self) {
      self.pastActivites = [[MockData sharedObj] getPastEvents];
      self.messageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
      [self addSubview:self.messageScrollView];
       self.personBarArray = [[NSMutableArray alloc] init];
      [self createView];
   }
   
   return self;
}

- (void)createView{
   int ycoord = 0;
   for (int i = 0; i < [self.pastActivites count]; i++){
      Activity *activity = [self.pastActivites objectAtIndex:i];
      //create header
      ActivityHeaderBar *header = [[ActivityHeaderBar alloc] initWithFrame:CGRectMake(EDGE_INSET, ycoord, self.frame.size.width - 2*EDGE_INSET, 50) withActivity:activity];
      [self.messageScrollView addSubview:header];
      ycoord += header.frame.size.height;
      
      for (int j = 0; j < [activity.participants count]; j++){
         Person *person = [activity.participants objectAtIndex:j];
         PersonBar *bar = [[PersonBar alloc] initWithFrame:CGRectMake(EDGE_INSET, ycoord, self.frame.size.width - 2*EDGE_INSET, header.frame.size.height) withPerson:person];
          [self.personBarArray addObject:bar];
         [self.messageScrollView addSubview:bar];
         ycoord += header.frame.size.height;
      }
   }
   
   ycoord += 50;//height of last person bar
   [self.messageScrollView setContentSize:CGSizeMake(self.frame.size.width, ycoord)];
}

- (NSArray *)getRecipients{
    NSMutableArray *numbers = [[NSMutableArray alloc] init];
    for (PersonBar *personBar in self.personBarArray) {
        if (personBar.isSelected && ![numbers containsObject:personBar.person.phoneNumber]) {
            [numbers addObject:personBar.person.phoneNumber];
        }
    }
    return numbers;
}

@end
