//
//  ActivityHeader.m
//  Mix
//
//  Created by Kirby Gee on 12/1/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "ActivityHeaderBar.h"

@interface ActivityHeaderBar ()
@property (nonatomic, strong) UIImageView *categoryImage;
@property (nonatomic, strong) UILabel *activityLabel;
@end

@implementation ActivityHeaderBar

- (instancetype)initWithFrame:(CGRect)frame withActivity:(Activity *)activity{
   self = [super initWithFrame:frame];
   if (self) {
      int sideLength = frame.size.height - 2*EDGE_INSET;

      UIView *border = [[UIView alloc] initWithFrame:CGRectMake(EDGE_INSET, self.frame.size.height - 2, self.frame.size.width - 2*EDGE_INSET, 2)];
      border.backgroundColor = THEME_COLOR;
      [self addSubview:border];
      
      self.categoryImage = [[UIImageView alloc] initWithFrame:CGRectMake(EDGE_INSET, EDGE_INSET, sideLength, sideLength)];
      [self.categoryImage setImage:[UIImage imageNamed:[activity.category.lowercaseString stringByReplacingOccurrencesOfString:@" " withString:@"_"]]];
      [self addSubview:self.categoryImage];
      
      self.activityLabel = [[UILabel alloc] init];
      self.activityLabel.text = [NSString stringWithFormat:@"%@ - %@", activity.activityName, activity.date];
      [self.activityLabel sizeToFit];
      self.activityLabel.center = CGPointMake(self.categoryImage.frame.origin.x + self.categoryImage.frame.size.width + EDGE_INSET + self.activityLabel.frame.size.width/2, EDGE_INSET + self.activityLabel.frame.size.height/2);
      [self addSubview:self.activityLabel];
   }
   
   return self;
}
@end
