//
//  ActivityExploreView.h
//  Mix
//
//  Created by Kirby Gee on 11/18/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityBar.h"
@interface ActivityExploreView : UIView <ActivityBarDelegate>

@property (nonatomic) bool isDetailViewPresented;
@property (nonatomic, strong) UIButton *doneButton;
- (void)done:(UIButton*)button;
- (void)filterBy:(NSString *)filter;

@end
