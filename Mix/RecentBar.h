//
//  RecentBar.h
//  Mix
//
//  Created by Kirby Gee on 12/1/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
#import <MapKit/MapKit.h>

@interface RecentBar : UIView
@property (nonatomic, strong) Activity *activity;
@property (nonatomic) CGRect originalFrame;
@property (nonatomic, strong) UIView *bottomBorder;

- (instancetype)initWithFrame:(CGRect)frame withActivty:(Activity *)activity;

- (void)expandBarWithFrame:(CGRect)frame;
- (void)contractView;
@end
