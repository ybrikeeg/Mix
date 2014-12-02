//
//  RecentActivityView.m
//  Mix
//
//  Created by Kirby Gee on 12/1/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "RecentActivityView.h"


#import "RecentBar.h"
#import "Constants.h"
#import "MockData.h"

@interface RecentActivityView ()
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *allBars;
@property (nonatomic, strong) RecentBar *tappedBar;
@end

@implementation RecentActivityView

- (instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self) {
      self.data = [[[MockData sharedObj] getPastEvents] mutableCopy];
      [self initializeData];
      [self loadActivityBars];
      self.backgroundColor = [UIColor lightGrayColor];
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
      [self addGestureRecognizer:tap];
      
   }
   return self;
}

- (void)setIsDetailViewPresented:(bool)isDetailViewPresented
{
   self.doneButton.hidden = !isDetailViewPresented;
   _isDetailViewPresented = isDetailViewPresented;
}
/**
 * Moves all the non tapped bars up or down, and then calls the tapped bar method to show the expanded view
 */
- (void)tapGesture:(UITapGestureRecognizer *)sender {
   if (self.isDetailViewPresented) return;
   self.isDetailViewPresented = YES;
   for (RecentBar *bar in self.allBars){
      CGPoint pointInSubjectsView = [sender locationInView:bar];
      BOOL pointInsideObject = [bar pointInside:pointInSubjectsView withEvent:nil];
      if(pointInsideObject){
         self.tappedBar = bar;
         [UIView animateWithDuration:0.6f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
            
            CGPoint newCenter = [self convertPoint:self.center toView:self.scrollView];
            //distnace all subviews above tappedBar need to move in the y direction
            CGFloat moveAboveSubviewsDistance = bar.frame.origin.y - (newCenter.y - EXPANDED_BAR_HEIGHT/2);
            CGFloat moveBelowSubviewsDistance = (newCenter.y - EXPANDED_BAR_HEIGHT/2 + EXPANDED_BAR_HEIGHT) - (bar.frame.origin.y + bar.frame.size.height);
            for (RecentBar *subs in self.allBars){
               if (subs.tag > bar.tag){
                  subs.center = CGPointMake(subs.center.x, subs.center.y + moveBelowSubviewsDistance);
               }else if (subs.tag < bar.tag){
                  subs.center = CGPointMake(subs.center.x, subs.center.y - moveAboveSubviewsDistance);
               }
            }
            
            //ActivtyBar now make the expanded view visible
            [bar expandBarWithFrame: CGRectMake(0, 0, bar.bounds.size.width, EXPANDED_BAR_HEIGHT)];
            self.scrollView.scrollEnabled = NO;
            [bar layoutIfNeeded];
            [self.scrollView setContentOffset:CGPointZero animated:YES];
            
         }completion:^(BOOL finished){
            
         }];
         
      }
   }
}

- (void)done:(UIButton *)button{
   self.isDetailViewPresented = NO;
   
   [UIView animateWithDuration:0.6f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
      
      for (UIView *subs in self.scrollView.subviews){
         if ([subs isKindOfClass:[RecentBar class]]){
            RecentBar *b = (RecentBar *)subs;
            b.frame = b.originalFrame;
         }
      }
      
      [self.tappedBar contractView];
      self.scrollView.scrollEnabled = YES;
      [self.tappedBar layoutIfNeeded];
      
   }completion:^(BOOL finished){
      
   }];
   return;
}

- (void)loadActivityBars{
   
   for (int i = 0; i < [self.data count]; i ++){
      RecentBar *bar = [[RecentBar alloc] initWithFrame: CGRectMake(0, ACTIVITY_BAR_HEIGHT * i, self.bounds.size.width, ACTIVITY_BAR_HEIGHT) withActivty: self.data[i]];
      bar.tag = i;
      [self.scrollView addSubview:bar];
      [self.allBars addObject:bar];
   }
   self.scrollView.contentSize = CGSizeMake(self.frame.size.width, [self.data count] * ACTIVITY_BAR_HEIGHT);
}

- (void)initializeData{
   self.backgroundColor = [UIColor whiteColor];
   self.isDetailViewPresented = NO;
   
   
   UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
   top.backgroundColor = [UIColor blackColor];
   [self addSubview:top];
   
   self.allBars = [[NSMutableArray alloc] init];
   self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
   [self addSubview:self.scrollView];
}

@end
