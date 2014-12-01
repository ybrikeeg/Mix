//
//  FirstViewController.m
//  Mix
//
//  Created by Kirby Gee on 11/18/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "MainViewController.h"
#import "Activity.h"
#import "ActivityExploreView.h"
#import "MessageView.h"

#import "MockData.h"

@interface MainViewController ()
@property (nonatomic, strong) NSMutableArray *activities;
@property (nonatomic, strong) ActivityExploreView *exploreView;
@property (nonatomic, strong) MessageView *messageView;

@property (nonatomic, strong) UIView *tabView;
@property (nonatomic, strong) UIView *selectionIndicator;
@end

@implementation MainViewController



- (void)viewDidLoad {
   
   [super viewDidLoad];
   
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newActivityAdded:) name:@"newActivityAdded" object:nil];
   
   [self createTabBar];
   
}

- (void)animateIndicator:(UIButton *)sender
{
   [UIView animateWithDuration:0.2f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
      self.selectionIndicator.frame = CGRectMake(sender.frame.origin.x, self.selectionIndicator.frame.origin.y, self.selectionIndicator.frame.size.width, self.selectionIndicator.frame.size.height);
   }completion:^(BOOL finished){
   }];
}


- (void)explore:(UIButton *)sender
{
   [self animateIndicator:sender];
   self.exploreView = [[ActivityExploreView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.origin.y + self.tabView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - self.tabView.frame.size.height)];
   [self.view addSubview:self.exploreView];
   NSLog(@"Frame: %@", NSStringFromCGRect(self.exploreView.frame));
}

- (void)create:(UIButton *)sender
{
   [self animateIndicator:sender];
}

- (void)recent:(UIButton *)sender
{
   [self animateIndicator:sender];
}

- (void)message:(UIButton *)sender
{
   [self animateIndicator:sender];
   self.messageView = [[MessageView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.origin.y + self.tabView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - self.tabView.frame.size.height)];
   [self.view addSubview:self.messageView];
   NSLog(@"Frame: %@", NSStringFromCGRect(self.messageView.frame));
   self.messageView.backgroundColor = [UIColor purpleColor];
}

- (void)createTabBar
{
   self.tabView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, 40)];
   self.tabView.backgroundColor = [UIColor blackColor];
   [self.view addSubview:self.tabView];
   
   self.selectionIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.size.height - INDICATOR_HEIGHT, self.tabView.frame.size.width/4, INDICATOR_HEIGHT)];
   self.selectionIndicator.backgroundColor = [UIColor greenColor];
   [self.tabView addSubview:self.selectionIndicator];
   
   UIButton *explore = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [explore addTarget:self action:@selector(explore:) forControlEvents:UIControlEventTouchUpInside];
   [explore setTitle:@"Explore" forState:UIControlStateNormal];
   explore.frame = CGRectMake(0, 0, self.tabView.frame.size.width/4, self.tabView.frame.size.height);
   [self.tabView addSubview:explore];
   
   UIButton *create = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [create addTarget:self action:@selector(create:) forControlEvents:UIControlEventTouchUpInside];
   [create setTitle:@"Create" forState:UIControlStateNormal];
   create.frame = CGRectMake(self.tabView.frame.size.width/4, 0, self.tabView.frame.size.width/4, self.tabView.frame.size.height);
   [self.tabView addSubview:create];
   
   UIButton *recent = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [recent addTarget:self action:@selector(recent:) forControlEvents:UIControlEventTouchUpInside];
   [recent setTitle:@"Recent" forState:UIControlStateNormal];
   recent.frame = CGRectMake(self.tabView.frame.size.width/2, 0, self.tabView.frame.size.width/4, self.tabView.frame.size.height);
   [self.tabView addSubview:recent];
   
   UIButton *message = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [message addTarget:self action:@selector(message:) forControlEvents:UIControlEventTouchUpInside];
   [message setTitle:@"Message" forState:UIControlStateNormal];
   message.frame = CGRectMake(3 * self.tabView.frame.size.width/4, 0, self.tabView.frame.size.width/4, self.tabView.frame.size.height);
   [self.tabView addSubview:message];
}
- (void)viewWillAppear:(BOOL)animated{
   //    self.exploreView = [[ActivityExploreView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height) withData:self.activities];
   //    [self.view addSubview:self.exploreView];
   
   
}


- (void)newActivityAdded:(NSNotification *)notification{
   
   Activity *newActivity = notification.object;
   NSLog(@"%@", newActivity.activityName);
   [self.activities addObject:newActivity];
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

@end
