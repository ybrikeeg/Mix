//
//  RecentActivityView.h
//  Mix
//
//  Created by Kirby Gee on 12/1/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentActivityView : UIView

@property (nonatomic) bool isDetailViewPresented;
@property (nonatomic, strong) UIButton *doneButton;
- (void)done:(UIButton*)button;

@end
