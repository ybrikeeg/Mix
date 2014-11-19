//
//  ActivityExploreView.m
//  Mix
//
//  Created by Kirby Gee on 11/18/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "ActivityExploreView.h"
#import "ActivityBar.h"
#import "Constants.h"

@interface ActivityExploreView ()
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *allBars;
@property (nonatomic) bool isDetailViewPresented;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) ActivityBar *tappedBar;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation ActivityExploreView

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data
{
   self = [super initWithFrame:frame];
   if (self) {
      self.data = data;
      [self initializeData];
      [self loadActivityBars];
      
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
      [self addGestureRecognizer:tap];
      
   }
   return self;
}

/**
 * Moves all the non tapped bars up or down, and then calls the tapped bar method to show the expanded view
 */
- (void)tapGesture:(UITapGestureRecognizer *)sender {
   if (self.isDetailViewPresented) return;
   self.isDetailViewPresented = YES;
   self.doneButton.hidden = NO;
   for (ActivityBar *bar in self.allBars){
      CGPoint pointInSubjectsView = [sender locationInView:bar];
      BOOL pointInsideObject = [bar pointInside:pointInSubjectsView withEvent:nil];
      if(pointInsideObject){
         self.tappedBar = bar;
         [UIView animateWithDuration:0.6f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
            
            CGPoint newCenter = [self convertPoint:self.center toView:self.scrollView];
            //distnace all subviews above tappedBar need to move in the y direction
            CGFloat moveAboveSubviewsDistance = bar.frame.origin.y - (newCenter.y - EXPANDED_BAR_HEIGHT/2);
            CGFloat moveBelowSubviewsDistance = (newCenter.y - EXPANDED_BAR_HEIGHT/2 + EXPANDED_BAR_HEIGHT) - (bar.frame.origin.y + bar.frame.size.height);
            
            for (ActivityBar *subs in self.allBars){
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
            
         }completion:^(BOOL finished){
            
         }];
         
      }
   }
}

/*
 * Delegate method from ActivityBar when user joins activity
 */
- (void)joinedActivity{
   [self done:nil];
}

- (void)done:(UIButton*)button{
   self.isDetailViewPresented = NO;
   self.doneButton.hidden = YES;
   
   [UIView animateWithDuration:0.6f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
      
      CGFloat moveAboveSubviewsDistance = self.tappedBar.originalFrame.origin.y - self.tappedBar.frame.origin.y;
      CGFloat moveBelowSubviewsDistance = (self.tappedBar.frame.origin.y + EXPANDED_BAR_HEIGHT) - (self.tappedBar.originalFrame.origin.y + self.tappedBar.originalFrame.size.height);
      
      for (UIView *subs in self.scrollView.subviews){
            if (subs.tag > self.tappedBar.tag){
               subs.center = CGPointMake(subs.center.x, subs.center.y - moveBelowSubviewsDistance);
               
            }else if (subs.tag < self.tappedBar.tag){
               subs.center = CGPointMake(subs.center.x, subs.center.y + moveAboveSubviewsDistance);
            }
         
         if (abs((int)subs.tag - (int)self.tappedBar.tag) <= 1){
            [self.scrollView bringSubviewToFront:subs];
         }
      }
      
      [self.tappedBar contractView];
      //self.tappedBar.frame = self.tappedBar.originalFrame;
      self.scrollView.scrollEnabled = YES;
      [self.tappedBar layoutIfNeeded];

   }completion:^(BOOL finished){
      
   }];
   return;
   
}

- (void)loadActivityBars{
   for (int i = 0; i < [self.data count]; i ++){
      ActivityBar *bar = [[ActivityBar alloc] initWithFrame: CGRectMake(0, ACTIVITY_BAR_HEIGHT * i, self.bounds.size.width, ACTIVITY_BAR_HEIGHT) withActivty: self.data[i]];
      bar.tag = i;
      bar.delegate = self;
      [self.scrollView addSubview:bar];
      [self.allBars addObject:bar];
   }
   self.scrollView.contentSize = CGSizeMake(self.frame.size.width, [self.data count] * ACTIVITY_BAR_HEIGHT);
}

- (void)initializeData{
   self.backgroundColor = [UIColor whiteColor];
   self.isDetailViewPresented = NO;
   self.titleLabel = [[UILabel alloc] init];
   self.titleLabel.text = @"Today";
   self.titleLabel.font = [UIFont systemFontOfSize:28.0f];
   self.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:28.0f];
   [self.titleLabel sizeToFit];
   self.titleLabel.center = CGPointMake(self.center.x, self.titleLabel.frame.size.height/2);
   [self addSubview:self.titleLabel];
   
   UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleLabel.frame.size.height-1, self.frame.size.width, 1)];
   top.backgroundColor = [UIColor blackColor];
   [self addSubview:top];
   
   self.doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
   [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
   self.doneButton.frame = CGRectMake(self.frame.size.width - 50, 5,40, 20);
   [self addSubview:self.doneButton];
   self.doneButton.hidden = YES;
   
   self.allBars = [[NSMutableArray alloc] init];
   self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleLabel.frame.size.height, self.frame.size.width, self.frame.size.height - self.titleLabel.frame.size.height)];
   [self addSubview:self.scrollView];
}

@end
