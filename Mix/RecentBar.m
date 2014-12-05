//
//  RecentBar.m
//  Mix
//
//  Created by Kirby Gee on 12/1/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "RecentBar.h"
#import "Constants.h"

@interface RecentBar ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *underline;
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UITextView *descriptionTextView;
@property (nonatomic, strong) UIScrollView *profileScrollView;
@property (nonatomic, strong) MKMapView *map;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIImageView *categoryImage;
@property (nonatomic, strong) UIImageView *creatorImage;
@property (nonatomic, strong) CAGradientLayer *gradient;

@end

@implementation RecentBar

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
      
      self.gradient = [CAGradientLayer layer];
      [self updateGradient];
   }
   
   return self;
}

- (void)updateGradient{
   self.gradient.frame = self.bounds;
   UIColor *startColour = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0];
   UIColor *endColour = [UIColor colorWithHue:0 saturation:0 brightness:0.93 alpha:1.0];
   self.gradient.colors = [NSArray arrayWithObjects:(id)[startColour CGColor], (id)[endColour CGColor], nil];
   [self.layer insertSublayer:self.gradient atIndex:0];
}

/*
 * Contracts the expanded view into a smaller view
 */
- (void)contractView{
   [self updateGradient];

   [UIView animateWithDuration:0.6f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
      self.frame = self.originalFrame;
      self.bottomBorder.frame = CGRectMake(0, self.frame.size.height - BORDER_HEIGHT, self.frame.size.width, BORDER_HEIGHT);
      
      for (UIView *sub in self.subviews){
         if (sub.tag == MAKE_INVISIBLE_TAG){
            sub.alpha = 0.0f;
         }
      }
      
      self.endTimeLabel.frame = CGRectMake(INSET, self.frame.size.height/2, self.endTimeLabel.frame.size.width, self.endTimeLabel.frame.size.height);
      
   }completion:^(BOOL finished){
      
   }];
}

- (void)expandBarWithFrame:(CGRect)frame{
   [UIView animateWithDuration:.6f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:0.0f options:0 animations:^{
      self.bottomBorder.center = CGPointMake(self.center.x, frame.size.height - 1);
      self.frame = frame;
      [self updateGradient];

      self.endTimeLabel.center = CGPointMake(self.endTimeLabel.center.x, self.underline.frame.origin.y/2 + BORDER_HEIGHT + self.endTimeLabel.frame.size.height/2);
      
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
}


- (void)createLabels{
   self.categoryImage = [[UIImageView alloc] initWithFrame:CGRectMake(EDGE_INSET, 0, CHECK_IMAGE_SIDE, CHECK_IMAGE_SIDE)];
   self.categoryImage.center = CGPointMake(self.categoryImage.center.x, self.frame.size.height/2);
   //self.categoryImage.backgroundColor = [UIColor redColor];
   [self.categoryImage setImage:[UIImage imageNamed:[self.activity.category.lowercaseString stringByReplacingOccurrencesOfString:@" " withString:@"_"]]];
   [self addSubview:self.categoryImage];
   
   int titleWidth = self.frame.size.width - 4*EDGE_INSET - self.categoryImage.frame.size.width - 50;
   //create title label
   self.titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(EDGE_INSET + self.categoryImage.frame.origin.x + self.categoryImage.frame.size.width, 0, titleWidth, 35)];
   self.titleLabel.text = self.activity.activityName;
   self.titleLabel.font = [UIFont fontWithName:FONT_NAME size:28.0f];
   self.titleLabel.tag = KEEP_VISIBLE_TAG;
   self.titleLabel.adjustsFontSizeToFitWidth = YES;
   self.titleLabel.center = CGPointMake(self.titleLabel.center.x, self.frame.size.height/3);
   [self addSubview:self.titleLabel];
   
   //underline title
   self.underline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.titleLabel.frame.size.width, 2)];
   self.underline.center = CGPointMake(self.titleLabel.center.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height);
   self.underline.backgroundColor = THEME_COLOR;
   self.underline.tag = KEEP_VISIBLE_TAG;
   [self addSubview:self.underline];
   
   int sideLength = 50;
   
   self.creatorImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - EDGE_INSET - sideLength, EDGE_INSET, sideLength, sideLength)];
   [self.creatorImage setImage:[UIImage imageNamed:self.activity.creator.imageName]];
   CAShapeLayer *shape = [CAShapeLayer layer];
   UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.creatorImage.bounds];
   shape.path = path.CGPath;
   self.creatorImage.layer.mask = shape;
   [self addSubview:self.creatorImage];
   
   UILabel *createLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.creatorImage.frame.origin.x, self.creatorImage.frame.size.height, self.creatorImage.frame.size.width, self.frame.size.height - self.creatorImage.frame.size.height)];
   createLabel.text = [NSString stringWithFormat:@"%@ %@.", self.activity.creator.firstName, [self.activity.creator.lastName substringToIndex: 1]];
   createLabel.font = [UIFont fontWithName:FONT_NAME size:28.0f];
   createLabel.tag = KEEP_VISIBLE_TAG;
   createLabel.adjustsFontSizeToFitWidth = YES;
   [createLabel setTextAlignment:NSTextAlignmentCenter];
   [self addSubview:createLabel];
   
   int timeWidth =  self.titleLabel.frame.size.width/2;
   int timeHeight = self.frame.size.height - (self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height);
   
   UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + timeHeight/4, timeHeight/2, timeHeight/2)];
   [timeImage setImage:[UIImage imageNamed:@"time"]];
   [self addSubview:timeImage];
   
   self.startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(3 + timeImage.frame.size.width + self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, timeWidth - timeImage.frame.size.width, timeHeight)];
   self.startTimeLabel.adjustsFontSizeToFitWidth = YES;
   self.startTimeLabel.text = [NSString stringWithFormat:@"%@-%@", self.activity.startTime, self.activity.endTime];
   self.startTimeLabel.font = [UIFont fontWithName:FONT_NAME size:14.0f];
   [self addSubview:self.startTimeLabel];
   
   
   UIImageView *distanceImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.startTimeLabel.frame.origin.x + self.startTimeLabel.frame.size.width, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + timeHeight/4, timeHeight/2, timeHeight/2)];
   [distanceImage setImage:[UIImage imageNamed:@"distance"]];
   [self addSubview:distanceImage];
   
   //distnace
   self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(3 + distanceImage.frame.size.width + self.startTimeLabel.frame.origin.x + self.startTimeLabel.frame.size.width, self.startTimeLabel.frame.origin.y, timeWidth - distanceImage.frame.size.width, self.startTimeLabel.frame.size.height)];
   self.distanceLabel.text = [NSString stringWithFormat:@"%.01f mi away", self.activity.distance];
   self.distanceLabel.font = [UIFont fontWithName:FONT_NAME size:14.0f];
   self.distanceLabel.tag = KEEP_VISIBLE_TAG;
   self.distanceLabel.adjustsFontSizeToFitWidth = YES;
   [self.distanceLabel setTextAlignment:NSTextAlignmentLeft];
   [self addSubview:self.distanceLabel];
   
   
   //create UI for expanded view
   UILabel *descriptionTitle = [[UILabel alloc] initWithFrame:CGRectMake(INSET, self.startTimeLabel.frame.origin.y + self.startTimeLabel.frame.size.height, self.frame.size.width - 2*INSET, 60)];
   descriptionTitle.text = @"Description";
   descriptionTitle.font = [UIFont fontWithName:FONT_NAME size:18.0f];
   [descriptionTitle sizeToFit];
   descriptionTitle.tag = MAKE_INVISIBLE_TAG;
   [self addSubview:descriptionTitle];
   
   self.descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(INSET, descriptionTitle.frame.origin.y + descriptionTitle.frame.size.height, self.frame.size.width - 2*INSET, 35)];
   self.descriptionTextView.text = self.activity.descriptionText;
   self.descriptionTextView.font = [UIFont fontWithName:FONT_NAME size:14.0f];
   self.descriptionTextView.backgroundColor = [UIColor clearColor];
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
   
//   CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(-37.00, 100.00) radius:10 identifier:@"idd"];
   self.map = [[MKMapView alloc] initWithFrame:CGRectMake(INSET, locationTitle.frame.origin.y + locationTitle.frame.size.height, self.frame.size.width - 2*INSET, 80)];
   UIImageView *mapImage = [[UIImageView alloc] initWithFrame:CGRectMake(INSET, locationTitle.frame.origin.y + locationTitle.frame.size.height, self.frame.size.width - 2*INSET, 80)];
   [mapImage setImage:[UIImage imageNamed:@"map"]];
   [self addSubview:mapImage];
//   self.map.rotateEnabled = YES;
//   self.map.pitchEnabled = YES;
//   self.map.showsUserLocation = YES;
//   self.map.userInteractionEnabled = YES;
//   self.map.tag = MAKE_INVISIBLE_TAG;
//   [self.map setRegion:MKCoordinateRegionMakeWithDistance(region.center, 1000, 1000) animated:YES];
//   
//   MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
//   [annotation setCoordinate:region.center];
//   [self.map addAnnotation:annotation];
//   [self.map  selectAnnotation:annotation animated:YES];
//   [self addSubview:self.map];
   
   self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(INSET, self.map.frame.origin.y + self.map.frame.size.height, self.frame.size.width - 2*INSET, 40)];
   self.addressLabel.text = self.activity.address;
   self.addressLabel.font = [UIFont fontWithName:FONT_NAME size:14.0f];
   self.addressLabel.tag = MAKE_INVISIBLE_TAG;
   
   [self addSubview:self.addressLabel];
   
   [self contractView];
}

@end