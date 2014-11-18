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
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@end
@implementation ActivityBar


- (instancetype)initWithFrame:(CGRect)frame withActivty:(Activity *)activity{
   
   self = [super initWithFrame:frame];
   if (self) {
      self.activity = activity;
      NSLog(@"Just checking: %@", activity.activityName);
      self.backgroundColor = [UIColor redColor];
      
      [self createLabels];

   }
   
   return self;
}

- (void)createLabels{
   //create title label
   self.titleLabel = [[UILabel alloc] init];
   self.titleLabel.text = activity.activityName;
   [self.titleLabel sizeToFit];
   self.titleLabel.center = CGPointMake(self.center.x, 15);
   [self addSubview:self.titleLabel];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
