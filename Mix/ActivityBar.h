//
//  ActivityBar.h
//  Mix
//
//  Created by Kirby Gee on 11/18/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
#import <MapKit/MapKit.h>


@protocol ActivityBarDelegate <NSObject>

@required
- (void)joinedActivity;
@end

@interface ActivityBar : UIView

@property (nonatomic, strong) Activity *activity;
@property (nonatomic) CGRect originalFrame;
@property (nonatomic, strong) UIView *bottomBorder;
@property (weak, nonatomic) id <ActivityBarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withActivty:(Activity *)activity;

- (void)expandBarWithFrame:(CGRect)frame;
- (void)contractView;

@end
