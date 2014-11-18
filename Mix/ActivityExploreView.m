//
//  ActivityExploreView.m
//  Mix
//
//  Created by Kirby Gee on 11/18/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "ActivityExploreView.h"
#import "ActivityBar.h"


#define ACTIVITY_BAR_HEIGHT 100

@interface ActivityExploreView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *allBars;
@end
@implementation ActivityExploreView

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data
{
   self = [super initWithFrame:frame];
   if (self) {
      self.data = data;
      self.backgroundColor = [UIColor lightGrayColor];
      self.allBars = [[NSMutableArray alloc] init];
      self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.frame.size.width, self.frame.size.height)];
      self.scrollView.clipsToBounds = NO;
      self.scrollView.backgroundColor = [UIColor whiteColor];
      [self addSubview:self.scrollView];
      
      for (int i = 0; i < [data count]; i ++){
         ActivityBar *bar = [[ActivityBar alloc] initWithFrame: CGRectMake(0, ACTIVITY_BAR_HEIGHT * i, self.bounds.size.width, ACTIVITY_BAR_HEIGHT) withActivty: self.data[i]];
         [self.scrollView addSubview:bar];
         [self.allBars addObject:bar];
      }
      self.scrollView.contentSize = CGSizeMake(self.frame.size.width, [data count] * ACTIVITY_BAR_HEIGHT);

      
      
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
      [self addGestureRecognizer:tap];
      
   }
   return self;
}

- (void)tapGesture:(UITapGestureRecognizer *)sender {

   for (ActivityBar *bar in self.allBars){
      CGPoint pointInSubjectsView = [sender locationInView:bar];
      BOOL pointInsideObject = [bar pointInside:pointInSubjectsView withEvent:nil];
      if(pointInsideObject){
         NSLog(@"Tapped bar: %@", bar.activity.activityName);
      }
   }
   
}

@end
