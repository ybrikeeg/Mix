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
#import <MessageUI/MessageUI.h>

#import "MockData.h"

@interface MainViewController ()<MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *activities;
@property (nonatomic, strong) ActivityExploreView *exploreView;
@property (nonatomic, strong) MessageView *messageView;

@property (nonatomic, strong) UIView *tabView;
@property (nonatomic, strong) UIView *selectionIndicator;
@property (nonatomic, strong) UIView *navBar;
@property (nonatomic, strong) UIButton *buttonTopRight;
@property (nonatomic, strong) UIView *activeView;
@end

@implementation MainViewController



- (void)viewDidLoad {
   
   [super viewDidLoad];
   
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newActivityAdded:) name:@"newActivityAdded" object:nil];
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
   self.buttonTopRight.frame = CGRectMake(self.view.frame.size.width - 60, self.navBar.frame.size.height - 40   , 60, 40);
   [self.buttonTopRight.titleLabel setTextAlignment: NSTextAlignmentCenter];
   self.buttonTopRight.backgroundColor = [UIColor blueColor];
   [self.navBar addSubview:self.buttonTopRight];
   
   self.tabView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBar.frame.origin.y + self.navBar.frame.size.height, self.view.frame.size.width, 40)];
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
   self.messageView = [[MessageView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.origin.y + self.tabView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.tabView.frame.size.height - self.navBar.frame.size.height)];
   [self.view addSubview:self.messageView];
   self.messageView.backgroundColor = [UIColor purpleColor];
   
   
   self.exploreView = [[ActivityExploreView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.origin.y + self.tabView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.tabView.frame.size.height - self.navBar.frame.size.height)];
   [self.view addSubview:self.exploreView];
   self.exploreView.doneButton = self.buttonTopRight;
   self.exploreView.backgroundColor = [UIColor orangeColor];
   self.activeView = self.exploreView;
   self.buttonTopRight.hidden = !self.exploreView.isDetailViewPresented;
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
