//
//  ActivityBar.m
//  Mix
//
//  Created by Kirby Gee on 11/18/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "ActivityBar.h"
#import "Constants.h"

@interface ActivityBar ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *underline;
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@end
@implementation ActivityBar

- (instancetype)initWithFrame:(CGRect)frame withActivty:(Activity *)activity{
   
   self = [super initWithFrame:frame];
   if (self) {
      self.activity = activity;
      self.originalFrame = frame;
      NSLog(@"Just checking: %@", activity.activityName);
      CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
      CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
      CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
      UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
      self.backgroundColor = color;
      self.backgroundColor = [UIColor whiteColor];
      [self createLabels];
      [self createBorders];
   }
   
   return self;
}

- (void)contractView{
   [UIView animateWithDuration:0.6f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
      self.frame = self.originalFrame;
      self.bottomBorder.frame = CGRectMake(0, self.frame.size.height - BORDER_HEIGHT, self.frame.size.width, BORDER_HEIGHT);

   }completion:^(BOOL finished){

   }];
}
- (void)expandBarWithFrame:(CGRect)frame{
   NSLog(@"expand: %@", NSStringFromCGRect(frame));
   [UIView animateWithDuration:.6f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
      self.bottomBorder.center = CGPointMake(self.center.x, frame.size.height - 1);
      self.frame = frame;
      
   }completion:^(BOOL finished){
      
   }];
}

- (void)createBorders{
   UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, BORDER_HEIGHT)];
   top.backgroundColor = [UIColor blackColor];
   //[self addSubview:top];
   
   self.bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - BORDER_HEIGHT, self.frame.size.width, BORDER_HEIGHT)];
   self.bottomBorder.backgroundColor = [UIColor blackColor];
   [self addSubview:self.bottomBorder];
}

- (void)createLabels{
   //create title label
   self.titleLabel = [[UILabel alloc] init];
   self.titleLabel.text = self.activity.activityName;
   self.titleLabel.font = [UIFont systemFontOfSize:20.0f];
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
