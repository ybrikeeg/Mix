//
//  PersonBar.h
//  Mix
//
//  Created by Kirby Gee on 12/1/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "Constants.h"

@interface PersonBar : UIView

@property (nonatomic) bool isSelected;
@property (nonatomic, strong, readonly) Person *person;


- (instancetype)initWithFrame:(CGRect)frame withPerson:(Person *)person;
@end
