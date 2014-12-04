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

@property (nonatomic, strong) UIButton *explore;
@property (nonatomic, strong) UIButton *create;
@property (nonatomic, strong) UIButton *recent;
@property (nonatomic, strong) UIButton *message;


@property (nonatomic, strong) UIView *filterView;
@property (nonatomic, strong) UIButton *sportsButton;
@property (nonatomic, strong) UIButton *craftsButton;
@property (nonatomic, strong) UIButton *fineArtsButton;
@property (nonatomic, strong) UIButton *educationButton;
@property (nonatomic, strong) UIButton *socialButton;
@property (nonatomic, strong) UIButton *removeButton;
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

   [self createFilterView];
}

- (void)setFilter:(NSString *)filter{
   NSLog(@"Setting filter: %@", filter);
   self.filterView.hidden = YES;
   
   if ([filter isEqualToString:@"Remove"]){
      [self.exploreView filterBy:@""];
   }else{
      [self.exploreView filterBy:filter];
   }
   
}
- (void)sports:(UIButton *)button{
   [self setFilter:button.titleLabel.text];

}
- (void)crafts:(UIButton *)button{
   [self setFilter:button.titleLabel.text];

}
- (void)fineArts:(UIButton *)button{
   [self setFilter:button.titleLabel.text];

}
- (void)education:(UIButton *)button{
   [self setFilter:button.titleLabel.text];

}
- (void)social:(UIButton *)button{
   [self setFilter:button.titleLabel.text];

}
- (void)remove:(UIButton *)button{
   [self setFilter:button.titleLabel.text];
}

- (void)createFilterView{
   
   self.filterView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBar.frame.origin.y + self.navBar.frame.size.height, self.view.frame.size.width, 50)];
   self.filterView.backgroundColor = [UIColor whiteColor];
   [self.view addSubview:self.filterView];
   
   UIView *b = [[UIView alloc] initWithFrame:CGRectMake(0, self.tabView.frame.size.height - 1, self.view.frame.size.width, 1)];
   b.backgroundColor = THEME_COLOR;
   [self.filterView addSubview:b];
   
   self.sportsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.sportsButton addTarget:self action:@selector(sports:) forControlEvents:UIControlEventTouchUpInside];
   [self.sportsButton setTitle:@"Sports" forState:UIControlStateNormal];
   self.sportsButton.frame = CGRectMake(0, 0, self.filterView.frame.size.width/6, self.filterView.frame.size.height);
   [self.sportsButton setTitleColor:THEME_COLOR forState:UIControlStateNormal];
   [self.filterView addSubview:self.sportsButton];
   
   UIView *s1 = [[UIView alloc] initWithFrame:CGRectMake(self.sportsButton.frame.size.width, 0, 1, self.sportsButton.frame.size.height)];
   s1.backgroundColor = THEME_COLOR;
   [self.filterView addSubview:s1];
   
   
   self.craftsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.craftsButton addTarget:self action:@selector(crafts:) forControlEvents:UIControlEventTouchUpInside];
   [self.craftsButton setTitle:@"Crafts" forState:UIControlStateNormal];
   self.craftsButton.frame = CGRectMake(self.filterView.frame.size.width/6, 0, self.filterView.frame.size.width/6, self.filterView.frame.size.height);
   [self.craftsButton setTitleColor:THEME_COLOR forState:UIControlStateNormal];
   [self.filterView addSubview:self.craftsButton];
   
   UIView *s2 = [[UIView alloc] initWithFrame:CGRectMake(self.craftsButton.frame.origin.x +  self.craftsButton.frame.size.width, 0, 1, self.craftsButton.frame.size.height)];
   s2.backgroundColor = THEME_COLOR;
   [self.filterView addSubview:s2];
   
   self.fineArtsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.fineArtsButton addTarget:self action:@selector(fineArts:) forControlEvents:UIControlEventTouchUpInside];
   [self.fineArtsButton setTitle:@"Fine Arts" forState:UIControlStateNormal];
   self.fineArtsButton.frame = CGRectMake(self.filterView.frame.size.width/3, 0, self.filterView.frame.size.width/6, self.filterView.frame.size.height);
   [self.fineArtsButton setTitleColor:THEME_COLOR forState:UIControlStateNormal];
   [self.filterView addSubview:self.fineArtsButton];
   
   UIView *s3 = [[UIView alloc] initWithFrame:CGRectMake(self.fineArtsButton.frame.origin.x +  self.fineArtsButton.frame.size.width, 0, 1, self.sportsButton.frame.size.height)];
   s3.backgroundColor = THEME_COLOR;
   [self.filterView addSubview:s3];
   
   
   self.educationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.educationButton addTarget:self action:@selector(education:) forControlEvents:UIControlEventTouchUpInside];
   [self.educationButton setTitle:@"Education" forState:UIControlStateNormal];
   self.educationButton.frame = CGRectMake(self.filterView.frame.size.width/2 + 3, 0, self.filterView.frame.size.width/6, self.filterView.frame.size.height);
   self.socialButton.titleLabel.adjustsFontSizeToFitWidth = YES;
   [self.educationButton setTitleColor:THEME_COLOR forState:UIControlStateNormal];
   [self.filterView addSubview:self.educationButton];
   
   UIView *s4 = [[UIView alloc] initWithFrame:CGRectMake(self.educationButton.frame.origin.x +  self.educationButton.frame.size.width, 0, 1, self.sportsButton.frame.size.height)];
   s4.backgroundColor = THEME_COLOR;
   [self.filterView addSubview:s4];
   
   self.socialButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.socialButton addTarget:self action:@selector(social:) forControlEvents:UIControlEventTouchUpInside];
   [self.socialButton setTitle:@"Social" forState:UIControlStateNormal];
   self.socialButton.titleLabel.adjustsFontSizeToFitWidth = YES;
   self.socialButton.frame = CGRectMake(2 * self.filterView.frame.size.width/3 + 3, 0, self.filterView.frame.size.width/6, self.filterView.frame.size.height);
   [self.socialButton setTitleColor:THEME_COLOR forState:UIControlStateNormal];
   [self.filterView addSubview:self.socialButton];
   
   UIView *s5 = [[UIView alloc] initWithFrame:CGRectMake(self.socialButton.frame.origin.x +  self.socialButton.frame.size.width, 0, 1, self.sportsButton.frame.size.height)];
   s5.backgroundColor = THEME_COLOR;
   [self.filterView addSubview:s5];
   
   self.removeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.removeButton addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
   [self.removeButton setTitle:@"Remove" forState:UIControlStateNormal];
   self.removeButton.frame = CGRectMake(5 * self.filterView.frame.size.width/6 + 3, 0, self.filterView.frame.size.width/6, self.filterView.frame.size.height);
   [self.removeButton setTitleColor:THEME_COLOR forState:UIControlStateNormal];
   [self.filterView addSubview:self.removeButton];

   self.filterView.hidden = YES;
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
   self.buttonTopRight.hidden = NO;
   if (self.exploreView.isDetailViewPresented){
      [self.buttonTopRight setTitle:@"Done" forState:UIControlStateNormal];
   }else{
      [self.buttonTopRight setTitle:@"Filter" forState:UIControlStateNormal];
   }
   [self.buttonTopRight.titleLabel sizeToFit];
}

- (void)create:(UIButton *)sender
{
   [self animateIndicator:sender];
   [self.view bringSubviewToFront:self.createView];
   self.activeView = self.createView;
   self.buttonTopRight.hidden = YES;
}

- (void)recent:(UIButton *)sender
{
   [self animateIndicator:sender];
   [self.view bringSubviewToFront:self.recentView];
   self.activeView = self.recentView;
   [self.buttonTopRight setTitle:@"Done" forState:UIControlStateNormal];
   [self.buttonTopRight.titleLabel sizeToFit];
   self.buttonTopRight.hidden = !self.recentView.isDetailViewPresented;
   
}

- (void)message:(UIButton *)sender
{
   [self animateIndicator:sender];
   [self.view bringSubviewToFront:self.messageView];
   self.activeView = self.messageView;
   self.buttonTopRight.hidden = NO;
   [self.buttonTopRight setTitle:@"Send" forState:UIControlStateNormal];
   [self.buttonTopRight.titleLabel sizeToFit];
}

- (void)done:(UIButton *)sender
{
   if (self.activeView == self.exploreView){
      
      if ([self.buttonTopRight.titleLabel.text isEqualToString:@"Filter"]){
         self.filterView.hidden = NO;
      }else if ([self.buttonTopRight.titleLabel.text isEqualToString:@"Done"]){
         self.filterView.hidden = YES;
      }
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
