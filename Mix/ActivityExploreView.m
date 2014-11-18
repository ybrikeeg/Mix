//
//  ActivityExploreView.m
//  Mix
//
//  Created by Kirby Gee on 11/18/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "ActivityExploreView.h"
#import "ActivityBar.h"

@implementation ActivityExploreView

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data
{
   self = [super initWithFrame:frame];
   if (self) {

      NSLog(@"Count: %d", [self.data count]);
      self.data = data;
      self.backgroundColor = [UIColor lightGrayColor];
      ActivityBar *bar1 = [[ActivityBar alloc] initWithFrame: CGRectMake(0, 0, self.bounds.size.width, 100) withActivty: self.data[0]];
      [self addSubview:bar1];
      
      
   }
   return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
