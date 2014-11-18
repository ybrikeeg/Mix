//
//  ActivityBar.m
//  Mix
//
//  Created by Kirby Gee on 11/18/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "ActivityBar.h"

@interface ActivityBar ()
@property (nonatomic, strong) Activity *activity;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *underline;
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@end
@implementation ActivityBar

#define BOARDER_HEIGHT 2
- (instancetype)initWithFrame:(CGRect)frame withActivty:(Activity *)activity{
   
   self = [super initWithFrame:frame];
   if (self) {
      self.activity = activity;
      NSLog(@"Just checking: %@", activity.activityName);
      self.backgroundColor = [UIColor redColor];
      
      [self createLabels];
      [self createBoarders];

   }
   
   return self;
}

- (void)createBoarders{
   UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, BOARDER_HEIGHT/2)];
   top.backgroundColor = [UIColor blackColor];
   [self addSubview:top];
   
   UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - BOARDER_HEIGHT/2, self.frame.size.width, BOARDER_HEIGHT/2)];
   bottom.backgroundColor = [UIColor blackColor];
   [self addSubview:bottom];
}
- (void)createLabels{
   //create title label
   self.titleLabel = [[UILabel alloc] init];
   self.titleLabel.text = self.activity.activityName;
   self.titleLabel.font = [UIFont systemFontOfSize:24.0f];
   [self.titleLabel sizeToFit];
   self.titleLabel.center = CGPointMake(self.center.x, 15);
   [self addSubview:self.titleLabel];
   
   //underline title
   self.underline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.titleLabel.frame.size.width, 2)];
   self.underline.center = CGPointMake(self.titleLabel.center.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height);
   self.underline.backgroundColor = [UIColor purpleColor];
   [self addSubview:self.underline];
   
   NSLog(@"Center: %@", NSStringFromCGPoint(self.center));
   //start time label
   self.startTimeLabel = [[UILabel alloc] init];
   self.startTimeLabel.text = [NSString stringWithFormat:@"%@ -", self.activity.startTime];
   [self.startTimeLabel sizeToFit];
   self.startTimeLabel.frame = CGRectMake(10, self.frame.size.height/2 - self.startTimeLabel.bounds.size.height, self.startTimeLabel.bounds.size.width, self.startTimeLabel.bounds.size.height);
   [self addSubview:self.startTimeLabel];
   
   //end time label
   self.endTimeLabel = [[UILabel alloc] init];
   self.endTimeLabel.text = self.activity.endTime;
   [self.endTimeLabel sizeToFit];
   self.endTimeLabel.frame = CGRectMake(10, self.frame.size.height/2, self.endTimeLabel.frame.size.width, self.endTimeLabel.frame.size.height);
   [self addSubview:self.endTimeLabel];
   
   //distnace
   self.distanceLabel = [[UILabel alloc] init];
   self.distanceLabel.text = [NSString stringWithFormat:@"%.01f mi", self.activity.distance];
   [self.distanceLabel sizeToFit];
   self.distanceLabel.frame = CGRectMake(self.bounds.size.width - 20 - self.distanceLabel.frame.size.width, self.frame.size.height/2 - self.distanceLabel.frame.size.height/2, self.distanceLabel.frame.size.width, self.distanceLabel.frame.size.height);
   [self addSubview:self.distanceLabel];
   
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
