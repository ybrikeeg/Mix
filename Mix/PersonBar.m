//
//  PersonBar.m
//  Mix
//
//  Created by Kirby Gee on 12/1/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "PersonBar.h"

@interface PersonBar ()
@property (nonatomic, strong) UIImageView *profilePic;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *checkImage;
@end


@implementation PersonBar

- (instancetype)initWithFrame:(CGRect)frame withPerson:(Person *)person{
   self = [super initWithFrame:frame];
   if (self) {
      
      int sideLength = frame.size.height - 2*EDGE_INSET;
      self.profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(EDGE_INSET, EDGE_INSET, sideLength, sideLength)];
      //[self.profilePic setImage:[UIImage imageNamed:person.imageName]];
      self.profilePic.backgroundColor = [UIColor orangeColor];
      [self addSubview:self.profilePic];
      
      self.nameLabel = [[UILabel alloc] init];
      self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", person.firstName, person.lastName];
      [self.nameLabel sizeToFit];
      self.nameLabel.center = CGPointMake(self.profilePic.frame.origin.x + self.profilePic.frame.size.width + EDGE_INSET + self.nameLabel.frame.size.width/2, EDGE_INSET + self.nameLabel.frame.size.height/2);
            self.nameLabel.backgroundColor = [UIColor blueColor];
      [self addSubview:self.nameLabel];
      
      
      self.checkImage = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - EDGE_INSET - CHECK_IMAGE_SIDE, EDGE_INSET, CHECK_IMAGE_SIDE, CHECK_IMAGE_SIDE)];
      [self addSubview:self.checkImage];
      
      self.isSelected = NO;
      
      
      UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
      singleTap.numberOfTapsRequired = 1;
      [self addGestureRecognizer:singleTap];
   }
   
   return self;
}

- (void)tap:(UITapGestureRecognizer *)gesture {
   NSLog(@"TOUCHED!");
   self.isSelected = !self.isSelected;
   
}

-(void)setIsSelected:(bool)isSelected
{
   NSLog(@"Selection");
   if (isSelected){
      [self.checkImage setImage:[UIImage imageNamed:@"check"]];
      self.checkImage.backgroundColor = [UIColor greenColor];
   }else{
      [self.checkImage setImage:[UIImage imageNamed:@"notCheck"]];
      self.checkImage.backgroundColor = [UIColor redColor];
   }
   _isSelected = isSelected;
}

@end
