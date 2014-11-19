//
//  Activity.h
//  Mix
//
//  Created by Kirby Gee on 11/18/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Activity : NSObject

@property (nonatomic, strong) NSString *activityName;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSArray *participants;
@property (nonatomic, strong) NSString *address;
@property (nonatomic) CGFloat distance;

@end
