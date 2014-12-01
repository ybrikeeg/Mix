//
//  ActivityHeader.h
//  Mix
//
//  Created by Kirby Gee on 12/1/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
#import "Constants.h"

@interface ActivityHeaderBar : UIView

- (instancetype)initWithFrame:(CGRect)frame withActivity:(Activity *)activity;

@end
