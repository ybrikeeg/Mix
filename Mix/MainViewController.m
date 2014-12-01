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
#import "CreateView.h"
#import <MessageUI/MessageUI.h>

#import "MockData.h"

@interface MainViewController ()<MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *activities;
@property (nonatomic, strong) ActivityExploreView *exploreView;
@property (nonatomic, strong) MessageView *messageView;
@property (nonatomic, strong) CreateView *createView;

@property (nonatomic, strong) UIView *tabView;
@property (nonatomic, strong) UIView *selectionIndicator;
@property (nonatomic, strong) UIView *navBar;
@property (nonatomic, strong) UIButton *buttonTopRight;
@property (nonatomic, strong) UIView *activeView;

@property (nonatomic, strong) UIButton *explore;
@property (nonatomic, strong) UIButton *create;
@property (nonatomic, strong) UIButton *recent;
@property (nonatomic, strong) UIButton *message;
@end

@implementation MainViewController



- (void)viewDidLoad {
   
   [super viewDidLoad];

   [self createTabBar];
}

- (void)animateIndicator:(UIButton *)sender
{
   self.buttonTopRight.hidden = self.exploreView.isDetailViewPresented;

   [UIView animateWithDuration:0.2f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
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

}

- (void)create:(UIButton *)sender
{
   [self animateIndicator:sender];
    [self.view bringSubviewToFront:self.createView];
    self.activeView = self.createView;
}

- (void)recent:(UIButton *)sender
{
   [self animateIndicator:sender];
}

- (void)message:(UIButton *)sender
{
   [self animateIndicator:sender];
   [self.view bringSubviewToFront:self.messageView];
   self.activeView = self.messageView;
}

- (void)done:(UIButton *)sender
{
   if (self.activeView == self.exploreView){
      [self.exploreView done:nil];
   }else if (self.activeView == self.messageView){
      [self displaySMSComposerSheet];
   }

   
}

- (void)createTabBar
{
   
   self.navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].statusBarFrame.size.height + self.view.frame.size.width, 50)];
   self.navBar.backgroundColor = [UIColor yellowColor];
   [self.view addSubview:self.navBar];
   
   UILabel *mix = [[UILabel alloc] init];
   mix.text = @"Mix";
   [mix sizeToFit];
   mix.center = self.navBar.center;
   [self.navBar addSubview:mix];
   
   self.buttonTopRight = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.buttonTopRight addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
   [self.buttonTopRight setTitle:@"Done" forState:UIControlStateNormal];
   [self.buttonTopRight sizeToFit];
   self.buttonTopRight.frame = CGRectMake(self.view.frame.size.width - EDGE_INSET - self.buttonTopRight.frame.size.width, self.navBar.frame.size.height - EDGE_INSET - self.buttonTopRight.frame.size.height, self.buttonTopRight.frame.size.width, self.buttonTopRight.frame.size.height);
   [self.navBar addSubview:self.buttonTopRight];
   
   self.tabView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBar.frame.origin.y + self.navBar.frame.size.height, self.view.frame.size.width, 40)];
   self.tabView.backgroundColor = [UIColor blackColor];
   [self.view addSubview:self.tabView];
   
   self.selectionIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.size.height - INDICATOR_HEIGHT, self.tabView.frame.size.width/4, INDICATOR_HEIGHT)];
   self.selectionIndicator.backgroundColor = [UIColor greenColor];
   [self.tabView addSubview:self.selectionIndicator];
   
   self.explore = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.explore addTarget:self action:@selector(explore:) forControlEvents:UIControlEventTouchUpInside];
   [self.explore setTitle:@"Explore" forState:UIControlStateNormal];
   self.explore.frame = CGRectMake(0, 0, self.tabView.frame.size.width/4, self.tabView.frame.size.height);
   [self.tabView addSubview:self.explore];
   
   self.create = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.create addTarget:self action:@selector(create:) forControlEvents:UIControlEventTouchUpInside];
   [self.create setTitle:@"Create" forState:UIControlStateNormal];
   self.create.frame = CGRectMake(self.tabView.frame.size.width/4, 0, self.tabView.frame.size.width/4, self.tabView.frame.size.height);
   [self.tabView addSubview:self.create];
   
   self.recent = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.recent addTarget:self action:@selector(recent:) forControlEvents:UIControlEventTouchUpInside];
   [self.recent setTitle:@"Recent" forState:UIControlStateNormal];
   self.recent.frame = CGRectMake(self.tabView.frame.size.width/2, 0, self.tabView.frame.size.width/4, self.tabView.frame.size.height);
   [self.tabView addSubview:self.recent];
   
   self.message = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.message addTarget:self action:@selector(message:) forControlEvents:UIControlEventTouchUpInside];
   [self.message setTitle:@"Message" forState:UIControlStateNormal];
   self.message.frame = CGRectMake(3 * self.tabView.frame.size.width/4, 0, self.tabView.frame.size.width/4, self.tabView.frame.size.height);
   [self.tabView addSubview:self.message];
}

- (void)viewWillAppear:(BOOL)animated{
   self.messageView = [[MessageView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.origin.y + self.tabView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.tabView.frame.size.height - self.navBar.frame.size.height)];
   [self.view addSubview:self.messageView];
   self.messageView.backgroundColor = [UIColor purpleColor];
   
    self.createView = [[CreateView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.origin.y + self.tabView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.tabView.frame.size.height - self.navBar.frame.size.height)];
    [self.view addSubview:self.createView];
    self.createView.backgroundColor = [UIColor purpleColor];
   
   self.exploreView = [[ActivityExploreView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.origin.y + self.tabView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.tabView.frame.size.height - self.navBar.frame.size.height)];
   [self.view addSubview:self.exploreView];
   self.exploreView.doneButton = self.buttonTopRight;
   self.exploreView.backgroundColor = [UIColor orangeColor];
   self.activeView = self.exploreView;
   self.buttonTopRight.hidden = !self.exploreView.isDetailViewPresented;
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
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    
    // You can specify one or more preconfigured recipients.  The user has
    // the option to remove or add recipients from the message composer view
    // controller.
    /* picker.recipients = @[@"Phone number here"]; */
    
    // You can specify the initial message text that will appear in the message
    // composer view controller.
    picker.recipients = self.messageView.getRecipients;
    
    [self presentViewController:picker animated:YES completion:NULL];
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
