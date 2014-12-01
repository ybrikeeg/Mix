//
//  FirstViewController.m
//  Mix
//
//  Created by Kirby Gee on 11/18/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "FirstViewController.h"
#import "Activity.h"
#import "ActivityExploreView.h"
#import "MockData.h"

@interface FirstViewController ()
@property (nonatomic, strong) NSMutableArray *activities;
@property (nonatomic, strong) ActivityExploreView *exploreView;

@end

@implementation FirstViewController



- (void)viewDidLoad {
   
   [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newActivityAdded:) name:@"newActivityAdded" object:nil];
   
   [self createActivities];
   NSLog(@"t: %f" ,self.tabBarController.tabBar.frame.size.height);
   NSLog(@"t: %f" , [UIApplication sharedApplication].statusBarFrame.size.height);
}

- (void)viewWillAppear:(BOOL)animated{
    self.exploreView = [[ActivityExploreView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.tabBarController.tabBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height) withData:self.activities];
    [self.view addSubview:self.exploreView];
}

- (void)createActivities{
   Activity *act1 = [[Activity alloc] init];
   act1.activityName = @"Squash";
   act1.descriptionText = @"Lets play squash";
   act1.startTime = @"10:00am";
   act1.endTime = @"12:00pm";
   act1.participants = @[@"Joe", @"Kerry", @"Jane"];
   act1.address = @"Sandhill road";
   act1.distance = 1.3f;
   
   
   Activity *act2 = [[Activity alloc] init];
   act2.activityName = @"Pottery";
   act2.descriptionText = @"Let go make a pot";
   act2.startTime = @"2:00pm";
   act2.endTime = @"3:00pm";
   act2.participants = @[@"Jake", @"Cesca"];
   act2.address = @"1345 Middlefield Ave";
   act2.distance = 5.8f;
   
   Activity *act3 = [[Activity alloc] init];
   act3.activityName = @"Hide and Seek";
   act3.descriptionText = @"Lets play hide and seek";
   act3.startTime = @"8:00pm";
   act3.endTime = @"11:30pm";
   act3.participants = @[@"Larry", @"Bill", @"Nolan", @"Jenny", @"Daniel", @"Michelle"];
   act3.address = @"The forest";
   act3.distance = 3.4f;
   
   self.activities = [[NSMutableArray alloc] init];
   [self.activities addObject:act1];
   [self.activities addObject:act2];
   [self.activities addObject:act3];
   
   
   
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
