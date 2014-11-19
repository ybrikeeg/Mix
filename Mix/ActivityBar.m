//
//  ActivityBar.m
//  Mix
//
//  Created by Kirby Gee on 11/18/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "ActivityBar.h"
#import "Constants.h"

@interface ActivityBar ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *underline;
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UITextView *descriptionTextView;
@property (nonatomic, strong) UIScrollView *profileScrollView;
@property (nonatomic, strong) MKMapView *map;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton *joinButton;
@end

@implementation ActivityBar

#define INSET 10
- (instancetype)initWithFrame:(CGRect)frame withActivty:(Activity *)activity{
   
   self = [super initWithFrame:frame];
   if (self) {
      self.clipsToBounds = YES;
      self.activity = activity;
      self.originalFrame = frame;
      NSLog(@"Just checking: %@", activity.activityName);
      CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
      CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
      CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
      UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
      self.backgroundColor = color;
      self.backgroundColor = [UIColor whiteColor];
      [self createLabels];
      [self createBorders];
   }
   
   return self;
}

- (void)contractView{
   [UIView animateWithDuration:0.6f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
      self.frame = self.originalFrame;
      self.bottomBorder.frame = CGRectMake(0, self.frame.size.height - BORDER_HEIGHT, self.frame.size.width, BORDER_HEIGHT);

   }completion:^(BOOL finished){

   }];
}
- (void)expandBarWithFrame:(CGRect)frame{
   NSLog(@"expand: %@", NSStringFromCGRect(frame));
   [UIView animateWithDuration:.6f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
      self.bottomBorder.center = CGPointMake(self.center.x, frame.size.height - 1);
      self.frame = frame;
      
   }completion:^(BOOL finished){
      
   }];
}

- (void)createBorders{
   self.bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - BORDER_HEIGHT, self.frame.size.width, BORDER_HEIGHT)];
   self.bottomBorder.backgroundColor = [UIColor blackColor];
   [self addSubview:self.bottomBorder];
}

- (void)join:(UIButton*)button{

}

- (void)createLabels{
   //create title label
   self.titleLabel = [[UILabel alloc] init];
   self.titleLabel.text = self.activity.activityName;
   self.titleLabel.font = [UIFont systemFontOfSize:20.0f];
   [self.titleLabel sizeToFit];
   self.titleLabel.center = CGPointMake(self.center.x, 15);
   [self addSubview:self.titleLabel];
   
   //underline title
   self.underline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.titleLabel.frame.size.width, 2)];
   self.underline.center = CGPointMake(self.titleLabel.center.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height);
   self.underline.backgroundColor = [UIColor purpleColor];
   [self addSubview:self.underline];
   
   NSLog(@"Center: %@", NSStringFromCGPoint(self.center));
   //start time label
   self.startTimeLabel = [[UILabel alloc] init];
   self.startTimeLabel.text = [NSString stringWithFormat:@"%@ -", self.activity.startTime];
   [self.startTimeLabel sizeToFit];
   self.startTimeLabel.frame = CGRectMake(10, self.frame.size.height/2 - self.startTimeLabel.bounds.size.height, self.startTimeLabel.bounds.size.width, self.startTimeLabel.bounds.size.height);
   [self addSubview:self.startTimeLabel];
   
   //end time label
   self.endTimeLabel = [[UILabel alloc] init];
   self.endTimeLabel.text = self.activity.endTime;
   [self.endTimeLabel sizeToFit];
   self.endTimeLabel.frame = CGRectMake(10, self.frame.size.height/2, self.endTimeLabel.frame.size.width, self.endTimeLabel.frame.size.height);
   [self addSubview:self.endTimeLabel];
   
   //distnace
   self.distanceLabel = [[UILabel alloc] init];
   self.distanceLabel.text = [NSString stringWithFormat:@"%.01f mi", self.activity.distance];
   [self.distanceLabel sizeToFit];
   self.distanceLabel.frame = CGRectMake(self.bounds.size.width - 20 - self.distanceLabel.frame.size.width, self.frame.size.height/2 - self.distanceLabel.frame.size.height/2, self.distanceLabel.frame.size.width, self.distanceLabel.frame.size.height);
   [self addSubview:self.distanceLabel];
   
   
   //create UI for expanded view
   self.descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(INSET, self.underline.frame.origin.y + 2, self.frame.size.width - 2*INSET, 80)];
   self.descriptionTextView.text = self.activity.descriptionText;
   self.descriptionTextView.backgroundColor = [UIColor yellowColor];
   self.descriptionTextView.editable = NO;
   [self addSubview:self.descriptionTextView];
   
   self.profileScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(INSET, self.descriptionTextView.frame.origin.y + self.descriptionTextView.frame.size.height, self.frame.size.width - 2*INSET, 80)];
   self.profileScrollView.backgroundColor = [UIColor blueColor];
   
   for (int i = 0; i < [self.activity.participants count]; i++){
      UIImageView *thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(i * 60, 0, 60, 60)];
      thumbnail.image = [UIImage imageNamed:@"lana"];
      [self.profileScrollView addSubview:thumbnail];
      
      UILabel *name = [[UILabel alloc] init];
      name.text = [self.activity.participants objectAtIndex:i];
      [name sizeToFit];
      name.center = CGPointMake(thumbnail.center.x, thumbnail.frame.origin.y + thumbnail.frame.size.height + name.frame.size.height/2);
      [self.profileScrollView addSubview:name];
   }
   self.profileScrollView.contentSize = CGSizeMake([self.activity.participants count] * 60, 80);
   [self addSubview:self.profileScrollView];
   
   CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(-37.00, 100.00) radius:10 identifier:@"idd"];
   self.map = [[MKMapView alloc] initWithFrame:CGRectMake(INSET, self.profileScrollView.frame.origin.y + self.profileScrollView.frame.size.height, self.frame.size.width - 2*INSET, 120)];
   self.map.rotateEnabled = YES;
   self.map.pitchEnabled = YES;
   self.map.showsUserLocation = YES;
   self.map.userInteractionEnabled = YES;
   [self.map setRegion:MKCoordinateRegionMakeWithDistance(region.center, 1000, 1000) animated:YES];

   MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
   [annotation setCoordinate:region.center];
   [self.map addAnnotation:annotation];
   [self.map  selectAnnotation:annotation animated:YES];
   [self addSubview:self.map];
   
   self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(INSET, self.map.frame.origin.y + self.map.frame.size.height, self.frame.size.width - 2*INSET, 40)];
   self.addressLabel.text = self.activity.address;
   [self addSubview:self.addressLabel];
   
   self.joinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.joinButton addTarget:self action:@selector(join:) forControlEvents:UIControlEventTouchUpInside];
   [self.joinButton setTitle:@"Join" forState:UIControlStateNormal];
   self.joinButton.backgroundColor = [UIColor greenColor];
   self.joinButton.frame = CGRectMake(INSET, self.addressLabel.frame.origin.y + self.addressLabel.frame.size.height, self.frame.size.width - 2*INSET, 40);
   [self addSubview:self.joinButton];
}

@end
