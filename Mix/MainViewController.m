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
#import "RecentActivityView.h"

#import "MessageView.h"
#import "CreateView.h"
#import <MessageUI/MessageUI.h>

#import "MockData.h"

@interface MainViewController ()<MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *activities;
@property (nonatomic, strong) ActivityExploreView *exploreView;
@property (nonatomic, strong) MessageView *messageView;
@property (nonatomic, strong) RecentActivityView *recentView;
@property (nonatomic, strong) CreateView *createView;

@property (nonatomic, strong) UIView *tabView;
@property (nonatomic, strong) UIView *selectionIndicator;
@property (nonatomic, strong) UIView *navBar;
@property (nonatomic, strong) UIButton *buttonTopRight;
@property (nonatomic, strong) UIView *activeView;
@property (nonatomic, strong) UIButton *filterButton;

@property (nonatomic, strong) UIButton *explore;
@property (nonatomic, strong) UIButton *create;
@property (nonatomic, strong) UIButton *recent;
@property (nonatomic, strong) UIButton *message;
@end

@implementation MainViewController



- (void)viewDidLoad {
   
   [super viewDidLoad];
   
   [self createTabBar];
    self.recentView = [[RecentActivityView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.origin.y + self.tabView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.tabView.frame.size.height - self.navBar.frame.size.height)];
    self.recentView.doneButton = self.buttonTopRight;
    
    self.messageView = [[MessageView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.origin.y + self.tabView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.tabView.frame.size.height - self.navBar.frame.size.height)];
    
    self.createView = [[CreateView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.origin.y + self.tabView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.tabView.frame.size.height - self.navBar.frame.size.height)];
    
    self.exploreView = [[ActivityExploreView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.origin.y + self.tabView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.tabView.frame.size.height - self.navBar.frame.size.height)];
}

- (void)animateIndicator:(UIButton *)sender
{
   self.buttonTopRight.hidden = self.exploreView.isDetailViewPresented;
   
   [UIView animateWithDuration:0.25f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
      self.selectionIndicator.frame = CGRectMake(sender.frame.origin.x, self.selectionIndicator.frame.origin.y, self.selectionIndicator.frame.size.width, self.selectionIndicator.frame.size.height);
   }completion:^(BOOL finished){
   }];
}


- (void)explore:(UIButton *)sender
{
   [self animateIndicator:sender];
   [self.view bringSubviewToFront:self.exploreView];
   self.activeView = self.exploreView;
   self.buttonTopRight.hidden = !self.exploreView.isDetailViewPresented;
   self.buttonTopRight.titleLabel.text = @"Filter";
   [self.buttonTopRight.titleLabel sizeToFit];
}

- (void)create:(UIButton *)sender
{
   [self animateIndicator:sender];
   self.filterButton.hidden = YES;
   [self.view bringSubviewToFront:self.createView];
   self.activeView = self.createView;
   self.buttonTopRight.hidden = YES;
   
}

- (void)recent:(UIButton *)sender
{
   [self animateIndicator:sender];
   self.filterButton.hidden = YES;
   [self.view bringSubviewToFront:self.recentView];
   self.activeView = self.recentView;
   self.buttonTopRight.titleLabel.text = @"Done";
   [self.buttonTopRight.titleLabel sizeToFit];
   self.buttonTopRight.hidden = !self.recentView.isDetailViewPresented;
   
}

- (void)message:(UIButton *)sender
{
   [self animateIndicator:sender];
   self.filterButton.hidden = YES;
   [self.view bringSubviewToFront:self.messageView];
   self.activeView = self.messageView;
   self.buttonTopRight.hidden = NO;
   self.buttonTopRight.titleLabel.text = @"Send";
   [self.buttonTopRight.titleLabel sizeToFit];
}

- (void)done:(UIButton *)sender
{
   if (self.activeView == self.exploreView){
      [self.exploreView done:nil];
   }else if (self.activeView == self.messageView){
      [self displaySMSComposerSheet];
   }else if (self.activeView == self.recentView){
      [self.recentView done:nil];
   }
   
}


- (void)createTabBar
{
   
   self.navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].statusBarFrame.size.height + self.view.frame.size.width, 60)];
   self.navBar.backgroundColor = THEME_COLOR;
   [self.view addSubview:self.navBar];
   
   UILabel *mix = [[UILabel alloc] init];
   mix.text = @"Mix";
   mix.font = [UIFont fontWithName:FONT_NAME size:28.0f];
   [mix setTextColor:[UIColor whiteColor]];
   [mix sizeToFit];
   mix.frame = CGRectMake(self.view.center.x - mix.frame.size.width/2, self.navBar.frame.size.height - mix.frame.size.height, mix.frame.size.width, mix.frame.size.height);
   [self.navBar addSubview:mix];
   
   UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(mix.frame.origin.x - mix.frame.size.height + 6, mix.frame.origin.y, mix.frame.size.height * .75, mix.frame.size.height * .75)];
   [logo setImage:[UIImage imageNamed:@"logo"]];
   logo.center = CGPointMake(logo.center.x, mix.center.y);
   [self.navBar addSubview:logo];
   
   
   self.buttonTopRight = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.buttonTopRight addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
   [self.buttonTopRight setTitle:@"Filter" forState:UIControlStateNormal];
   self.buttonTopRight.frame = CGRectMake(self.view.frame.size.width - 60, self.navBar.frame.size.height - 40, 60, 40);
   [self.buttonTopRight.titleLabel setTextAlignment: NSTextAlignmentCenter];
   [self.buttonTopRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   [self.navBar addSubview:self.buttonTopRight];
   
   self.tabView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBar.frame.origin.y + self.navBar.frame.size.height, self.view.frame.size.width, 50)];
   self.tabView.backgroundColor = [UIColor whiteColor];
   [self.view addSubview:self.tabView];
   
   UIView *b = [[UIView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.size.height - 1, self.view.frame.size.width, 1)];
   b.backgroundColor = THEME_COLOR;
   [self.tabView addSubview:b];
   
   self.selectionIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.size.height - INDICATOR_HEIGHT, self.tabView.frame.size.width/4, INDICATOR_HEIGHT)];
   self.selectionIndicator.backgroundColor = THEME_COLOR;
   [self.tabView addSubview:self.selectionIndicator];
   
   self.explore = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.explore addTarget:self action:@selector(explore:) forControlEvents:UIControlEventTouchUpInside];
   [self.explore setTitle:@"Explore" forState:UIControlStateNormal];
   self.explore.frame = CGRectMake(0, 0, self.tabView.frame.size.width/4, self.tabView.frame.size.height);
   [self.explore setTitleColor:THEME_COLOR forState:UIControlStateNormal];
   [self.tabView addSubview:self.explore];
   
   UIView *s1 = [[UIView alloc] initWithFrame:CGRectMake(self.explore.frame.size.width, 0, 1, self.explore.frame.size.height)];
   s1.backgroundColor = THEME_COLOR;
   [self.tabView addSubview:s1];
   
   
   self.create = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.create addTarget:self action:@selector(create:) forControlEvents:UIControlEventTouchUpInside];
   [self.create setTitle:@"Create" forState:UIControlStateNormal];
   self.create.frame = CGRectMake(self.tabView.frame.size.width/4, 0, self.tabView.frame.size.width/4, self.tabView.frame.size.height);
   [self.create setTitleColor:THEME_COLOR forState:UIControlStateNormal];
   [self.tabView addSubview:self.create];
   
   UIView *s2 = [[UIView alloc] initWithFrame:CGRectMake(self.create.frame.origin.x +  self.create.frame.size.width, 0, 1, self.explore.frame.size.height)];
   s2.backgroundColor = THEME_COLOR;
   [self.tabView addSubview:s2];
   
   self.recent = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.recent addTarget:self action:@selector(recent:) forControlEvents:UIControlEventTouchUpInside];
   [self.recent setTitle:@"Recent" forState:UIControlStateNormal];
   self.recent.frame = CGRectMake(self.tabView.frame.size.width/2, 0, self.tabView.frame.size.width/4, self.tabView.frame.size.height);
   [self.recent setTitleColor:THEME_COLOR forState:UIControlStateNormal];
   [self.tabView addSubview:self.recent];
   
   UIView *s3 = [[UIView alloc] initWithFrame:CGRectMake(self.recent.frame.origin.x +  self.recent.frame.size.width, 0, 1, self.explore.frame.size.height)];
   s3.backgroundColor = THEME_COLOR;
   [self.tabView addSubview:s3];

   
   self.message = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.message addTarget:self action:@selector(message:) forControlEvents:UIControlEventTouchUpInside];
   [self.message setTitle:@"Message" forState:UIControlStateNormal];
   self.message.frame = CGRectMake(3 * self.tabView.frame.size.width/4, 0, self.tabView.frame.size.width/4, self.tabView.frame.size.height);
   [self.message setTitleColor:THEME_COLOR forState:UIControlStateNormal];
   
   [self.tabView addSubview:self.message];
}

- (void)viewWillAppear:(BOOL)animated{
   [self.view addSubview:self.recentView];
   [self.view addSubview:self.messageView];
   [self.view addSubview:self.createView];
   [self.view addSubview:self.exploreView];
   self.exploreView.doneButton = self.buttonTopRight;
   self.exploreView.backgroundColor = [UIColor lightGrayColor];
   self.activeView = self.exploreView;
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

#pragma mark - Compose Mail/SMS

// -------------------------------------------------------------------------------
//	displayMailComposerSheet
//  Displays an SMS composition interface inside the application.
// -------------------------------------------------------------------------------
- (void)displaySMSComposerSheet
{
   NSArray *rec = self.messageView.getRecipients;
   if ([rec count] > 0){
      NSLog(@"sending");
      MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
      picker.messageComposeDelegate = self;
      
      // You can specify one or more preconfigured recipients.  The user has
      // the option to remove or add recipients from the message composer view
      // controller.
      /* picker.recipients = @[@"Phone number here"]; */
      
      // You can specify the initial message text that will appear in the message
      // composer view controller.
      picker.recipients = rec;
      NSLog(@"sending");
      [self presentViewController:picker animated:YES completion:NULL];
      
   }else{
      NSLog(@"not sending");
      
   }
}


#pragma mark - Delegate Methods


// -------------------------------------------------------------------------------
//	messageComposeViewController:didFinishWithResult:
//  Dismisses the message composition interface when users tap Cancel or Send.
//  Proceeds to update the feedback message field with the result of the
//  operation.
// -------------------------------------------------------------------------------
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
   [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
