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

@property (nonatomic, strong) UIImageView *categoryImage;
@property (nonatomic, strong) UIImageView *creatorImage;
@end

@implementation ActivityBar

#define INSET 10
#define KEEP_VISIBLE_TAG 1305
#define MAKE_INVISIBLE_TAG 999

- (instancetype)initWithFrame:(CGRect)frame withActivty:(Activity *)activity{
   
   self = [super initWithFrame:frame];
   if (self) {
      self.clipsToBounds = YES;
      self.activity = activity;
      self.originalFrame = frame;

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

/*
 * Contracts the expanded view into a smaller view
 */
- (void)contractView{
   [UIView animateWithDuration:0.6f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
      self.frame = self.originalFrame;
      self.bottomBorder.frame = CGRectMake(0, self.frame.size.height - BORDER_HEIGHT, self.frame.size.width, BORDER_HEIGHT);
      
      for (UIView *sub in self.subviews){
         if (sub.tag == MAKE_INVISIBLE_TAG){
            sub.alpha = 0.0f;
         }
      }
      //self.startTimeLabel.frame = CGRectMake(INSET, self.frame.size.height/2 - self.startTimeLabel.bounds.size.height, self.startTimeLabel.bounds.size.width, self.startTimeLabel.bounds.size.height);
      self.endTimeLabel.frame = CGRectMake(INSET, self.frame.size.height/2, self.endTimeLabel.frame.size.width, self.endTimeLabel.frame.size.height);

      
      //self.distanceLabel.frame = CGRectMake(self.bounds.size.width - INSET - self.distanceLabel.frame.size.width, self.frame.size.height/2 - self.distanceLabel.frame.size.height/2, self.distanceLabel.frame.size.width, self.distanceLabel.frame.size.height);

      
   }completion:^(BOOL finished){

   }];
}

- (void)expandBarWithFrame:(CGRect)frame{
   [UIView animateWithDuration:.6f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
      self.bottomBorder.center = CGPointMake(self.center.x, frame.size.height - 1);
      self.frame = frame;
      NSLog(@"expand bar frame: %@", NSStringFromCGRect(frame));

      
      //self.startTimeLabel.center = CGPointMake(self.startTimeLabel.center.x, self.underline.frame.origin.y/2 + BORDER_HEIGHT - self.startTimeLabel.frame.size.height/2);
      self.endTimeLabel.center = CGPointMake(self.endTimeLabel.center.x, self.underline.frame.origin.y/2 + BORDER_HEIGHT + self.endTimeLabel.frame.size.height/2);

      //self.distanceLabel.center = CGPointMake(self.distanceLabel.center.x, self.underline.frame.origin.y/2 + BORDER_HEIGHT);
      for (UIView *sub in self.subviews){
         if (sub.tag == MAKE_INVISIBLE_TAG){
            sub.alpha = 1.0f;
         }
      }
   }completion:^(BOOL finished){
      
   }];
}

- (void)createBorders{
   self.bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - BORDER_HEIGHT, self.frame.size.width, BORDER_HEIGHT)];
   self.bottomBorder.backgroundColor = [UIColor blackColor];
   [self addSubview:self.bottomBorder];
}

- (void)join:(UIButton*)button{
   self.activity.activityJoined = YES;
   self.layer.borderColor = [UIColor colorWithRed:37/255.0f green:217/255.0f blue:0/255.0f alpha:1.0f].CGColor;
   self.layer.borderWidth = 2.0f;
   [self bringSubviewToFront:self.underline];
   [self.delegate joinedActivity];
}

#define FONT_NAME @"Avenir-Medium"

- (void)createLabels{
   self.categoryImage = [[UIImageView alloc] initWithFrame:CGRectMake(EDGE_INSET, 0, CHECK_IMAGE_SIDE, CHECK_IMAGE_SIDE)];
   self.categoryImage.center = CGPointMake(self.categoryImage.center.x, self.frame.size.height/2);
   //self.categoryImage.backgroundColor = [UIColor redColor];
   [self.categoryImage setImage:[UIImage imageNamed:[self.activity.category.lowercaseString stringByReplacingOccurrencesOfString:@" " withString:@"_"]]];
   [self addSubview:self.categoryImage];
   
   //create title label
   self.titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.categoryImage.frame.origin.x + self.categoryImage.frame.size.width, 0, 150, 45)];
   self.titleLabel.text = self.activity.activityName;
   self.titleLabel.font = [UIFont fontWithName:FONT_NAME size:28.0f];
   self.titleLabel.tag = KEEP_VISIBLE_TAG;
   self.titleLabel.adjustsFontSizeToFitWidth = YES;
   [self.titleLabel sizeThatFits:CGSizeMake(200, 50)];
   self.titleLabel.center = CGPointMake(self.titleLabel.center.x, self.frame.size.height/2);
   //self.titleLabel.backgroundColor = [UIColor greenColor];
   [self addSubview:self.titleLabel];
   
   //underline title
   self.underline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.titleLabel.frame.size.width, 2)];
   self.underline.center = CGPointMake(self.titleLabel.center.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height);
   CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
   CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
   CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
   UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
   self.underline.backgroundColor = color;
   self.underline.tag = KEEP_VISIBLE_TAG;
   [self addSubview:self.underline];
   
   int sideLength = 50;

   self.creatorImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - EDGE_INSET - sideLength, self.frame.size.height/2 - sideLength/2, sideLength, sideLength)];
   [self.creatorImage setImage:[UIImage imageNamed:self.activity.creator.imageName]];
   CAShapeLayer *shape = [CAShapeLayer layer];
   UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.creatorImage.bounds];
   shape.path = path.CGPath;
   self.creatorImage.layer.mask = shape;
   [self addSubview:self.creatorImage];
   
   int timeWidth = self.creatorImage.frame.origin.x - (self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width);
   NSLog(@"width: %d", timeWidth);
   self.startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width, self.titleLabel.frame.origin.y, timeWidth, self.titleLabel.frame.size.height/2)];
   NSLog(@"frame: %@", NSStringFromCGRect(self.startTimeLabel.frame));
   self.startTimeLabel.adjustsFontSizeToFitWidth = YES;
   self.startTimeLabel.text = [NSString stringWithFormat:@"%@-%@", self.activity.startTime, self.activity.endTime];
   //self.startTimeLabel.backgroundColor = color;
   [self.startTimeLabel setTextAlignment:NSTextAlignmentCenter];
   [self addSubview:self.startTimeLabel];
//   //start time label
//   self.startTimeLabel = [[UILabel alloc] init];
//   self.startTimeLabel.text = [NSString stringWithFormat:@"%@ -", self.activity.startTime];
//   self.startTimeLabel.font = [UIFont fontWithName:FONT_NAME size:14.0f];
//   self.startTimeLabel.tag = KEEP_VISIBLE_TAG;
//   [self.startTimeLabel sizeToFit];
//   self.startTimeLabel.frame = CGRectMake(INSET, self.frame.size.height/2 - self.startTimeLabel.bounds.size.height, self.startTimeLabel.bounds.size.width, self.startTimeLabel.bounds.size.height);
//   [self addSubview:self.startTimeLabel];
//   
//   //end time label
//   self.endTimeLabel = [[UILabel alloc] init];
//   self.endTimeLabel.text = self.activity.endTime;
//   self.endTimeLabel.font = [UIFont fontWithName:FONT_NAME size:14.0f];
//   self.endTimeLabel.tag = KEEP_VISIBLE_TAG;
//   [self.endTimeLabel sizeToFit];
//   self.endTimeLabel.frame = CGRectMake(INSET, self.frame.size.height/2, self.endTimeLabel.frame.size.width, self.endTimeLabel.frame.size.height);
//   [self addSubview:self.endTimeLabel];
   
   //distnace
   self.distanceLabel = [[UILabel alloc] init];
   self.distanceLabel.text = [NSString stringWithFormat:@"%.01f mi away", self.activity.distance];
   self.distanceLabel.font = [UIFont fontWithName:FONT_NAME size:14.0f];
   self.distanceLabel.tag = KEEP_VISIBLE_TAG;
   self.distanceLabel.adjustsFontSizeToFitWidth = YES;
   [self.distanceLabel setTextAlignment:NSTextAlignmentCenter];
   self.distanceLabel.frame = CGRectMake(self.startTimeLabel.frame.origin.x, self.startTimeLabel.frame.origin.y + self.startTimeLabel.frame.size.height, timeWidth, self.titleLabel.frame.size.height/2);
   [self addSubview:self.distanceLabel];
   
   
   //create UI for expanded view
   UILabel *descriptionTitle = [[UILabel alloc] initWithFrame:CGRectMake(INSET, self.underline.frame.origin.y + 18, self.frame.size.width - 2*INSET, 80)];
   descriptionTitle.text = @"Description";
   descriptionTitle.font = [UIFont fontWithName:FONT_NAME size:18.0f];
   [descriptionTitle sizeToFit];
   descriptionTitle.tag = MAKE_INVISIBLE_TAG;
   [self addSubview:descriptionTitle];

   self.descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(INSET, descriptionTitle.frame.origin.y + descriptionTitle.frame.size.height, self.frame.size.width - 2*INSET, 40)];
   self.descriptionTextView.text = self.activity.descriptionText;
   self.descriptionTextView.font = [UIFont fontWithName:FONT_NAME size:14.0f];
   self.descriptionTextView.editable = NO;
   self.descriptionTextView.tag = MAKE_INVISIBLE_TAG;
   [self addSubview:self.descriptionTextView];
   
   UILabel *participantsTitle = [[UILabel alloc] initWithFrame:CGRectMake(INSET, self.descriptionTextView.frame.origin.y + self.descriptionTextView.frame.size.height, self.frame.size.width - 2*INSET, 80)];
   participantsTitle.text = @"Participants";
   participantsTitle.font = [UIFont fontWithName:FONT_NAME size:18.0f];
   [participantsTitle sizeToFit];
   participantsTitle.tag = MAKE_INVISIBLE_TAG;
   [self addSubview:participantsTitle];
   
   self.profileScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(INSET, participantsTitle.frame.origin.y + participantsTitle.frame.size.height, self.frame.size.width - 2*INSET, 100)];
   //self.profileScrollView.backgroundColor = [UIColor blueColor];
   self.profileScrollView.tag = MAKE_INVISIBLE_TAG;
   self.profileScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;

   for (int i = 0; i < [self.activity.participants count]; i++){
      UIImageView *thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(i * 60, 0, 60, 60)];
      thumbnail.image = [UIImage imageNamed:[[self.activity.participants objectAtIndex:i] imageName]];
      CAShapeLayer *shape = [CAShapeLayer layer];
      UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:thumbnail.bounds];
      shape.path = path.CGPath;
      thumbnail.layer.mask = shape;
      [self.profileScrollView addSubview:thumbnail];
      
      UILabel *firstName = [[UILabel alloc] init];
      firstName.text = [[self.activity.participants objectAtIndex:i] firstName];
      firstName.font = [UIFont fontWithName:FONT_NAME size:12.0f];
      [firstName sizeToFit];
      firstName.tag = MAKE_INVISIBLE_TAG;
      firstName.center = CGPointMake(thumbnail.center.x, thumbnail.frame.origin.y + thumbnail.frame.size.height + firstName.frame.size.height/2);
      [self.profileScrollView addSubview:firstName];
      
      UILabel *lastName = [[UILabel alloc] init];
      lastName.text = [[self.activity.participants objectAtIndex:i] lastName];
      lastName.font = [UIFont fontWithName:FONT_NAME size:12.0f];
      [lastName sizeToFit];
      lastName.tag = MAKE_INVISIBLE_TAG;
      lastName.center = CGPointMake(thumbnail.center.x, firstName.center.y + firstName.frame.size.height/2 + lastName.frame.size.height/2);
      [self.profileScrollView addSubview:lastName];
      
   }
   self.profileScrollView.contentSize = CGSizeMake([self.activity.participants count] * 60, 80);
   [self addSubview:self.profileScrollView];
   
   
   UILabel *locationTitle = [[UILabel alloc] initWithFrame:CGRectMake(INSET, self.profileScrollView.frame.origin.y + self.profileScrollView.frame.size.height, self.frame.size.width - 2*INSET, 80)];
   locationTitle.text = @"Location";
   locationTitle.font = [UIFont fontWithName:FONT_NAME size:18.0f];
   [locationTitle sizeToFit];
   locationTitle.tag = MAKE_INVISIBLE_TAG;
   [self addSubview:locationTitle];
   
   CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(-37.00, 100.00) radius:10 identifier:@"idd"];
   self.map = [[MKMapView alloc] initWithFrame:CGRectMake(INSET, locationTitle.frame.origin.y + locationTitle.frame.size.height, self.frame.size.width - 2*INSET, 80)];
   self.map.rotateEnabled = YES;
   self.map.pitchEnabled = YES;
   self.map.showsUserLocation = YES;
   self.map.userInteractionEnabled = YES;
   self.map.tag = MAKE_INVISIBLE_TAG;
   [self.map setRegion:MKCoordinateRegionMakeWithDistance(region.center, 1000, 1000) animated:YES];

   MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
   [annotation setCoordinate:region.center];
   [self.map addAnnotation:annotation];
   [self.map  selectAnnotation:annotation animated:YES];
   [self addSubview:self.map];
   
   self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(INSET, self.map.frame.origin.y + self.map.frame.size.height, self.frame.size.width - 2*INSET, 40)];
   self.addressLabel.text = self.activity.address;
   self.addressLabel.font = [UIFont fontWithName:FONT_NAME size:14.0f];
   self.addressLabel.tag = MAKE_INVISIBLE_TAG;

   [self addSubview:self.addressLabel];
   
   self.joinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [self.joinButton addTarget:self action:@selector(join:) forControlEvents:UIControlEventTouchUpInside];
   [self.joinButton setTitle:@"Join" forState:UIControlStateNormal];
   [[self.joinButton layer] setBorderWidth:2.0f];
   [self.joinButton.layer setBorderColor:[[UIColor colorWithRed:37/255.0f green:217/255.0f blue:0/255.0f alpha:1.0f] CGColor]];

   self.joinButton.tag = MAKE_INVISIBLE_TAG;
   self.joinButton.frame = CGRectMake(INSET, self.addressLabel.frame.origin.y + self.addressLabel.frame.size.height, self.frame.size.width - 2*INSET, 60);
   [self addSubview:self.joinButton];
   
   [self contractView];
}

@end
