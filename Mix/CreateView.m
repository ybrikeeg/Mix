//
//  CreateView.m
//  Mix
//
//  Created by William Huang on 12/1/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "CreateView.h"
#import "Activity.h"
#import "MockData.h"
#import <UIKit/UIKit.h>

@interface CreateView () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong, nonatomic) UILabel *activityLabel;
@property (strong, nonatomic) UITextField *activityNameTextField;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UITextField *addressTextField;
@property (strong, nonatomic) UILabel *startTimeLabel;
@property (nonatomic, strong) UITextField *startTime;
@property (strong, nonatomic) UILabel *endTimeLabel;
@property (nonatomic, strong) UITextField *endTime;
@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) UIPickerView *categoryPicker;
@property (nonatomic, strong) NSArray *pickerArray;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UITextView *descriptionTextField;
@property (strong, nonatomic) UIButton *submit;
@end

@implementation CreateView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       self.backgroundColor = [UIColor whiteColor];
        self.activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 10.0, 75.0, 20.0)];
        self.activityLabel.text = @"Activity:";
        [self addSubview:self.activityLabel];
        
        self.activityNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 35.0, self.bounds.size.width - 40.0, 25.0)];
        [self addSubview:self.activityNameTextField];
        
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 65.0, 75.0, 20.0)];
        self.addressLabel.text = @"Address:";
        [self addSubview:self.addressLabel];
        
        self.addressTextField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 90.0, self.bounds.size.width - 40.0, 25.0)];
        [self addSubview:self.addressTextField];
        
        self.startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 120.0, 90.0, 20.0)];
        self.startTimeLabel.text = @"Start Time:";
        [self addSubview:self.startTimeLabel];
        
        self.startTime = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 145.0, (self.bounds.size.width - 60.0)/2, 25.0)];
        [self addSubview:self.startTime];
        
        self.endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 + 10, 120.0, 90.0, 20.0)];
        self.endTimeLabel.text = @"End Time:";
        [self addSubview:self.endTimeLabel];
        
        self.endTime = [[UITextField alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 + 10, 145.0, (self.bounds.size.width - 60.0)/2, 25.0)];
        [self addSubview:self.endTime];
        
        self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 175.0, 90.0, 20.0)];
        self.categoryLabel.text = @"Category:";
        [self addSubview:self.categoryLabel];
        
        self.pickerArray = @[@"Sport", @"Fine Arts", @"Craft", @"Education", @"Social"];
        self.categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(70.0, 160.0, self.bounds.size.width - 140.0, 5.0)];
        self.categoryPicker.dataSource = self;
        self.categoryPicker.delegate = self;
        [self addSubview:self.categoryPicker];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 310.0, 110.0, 20.0)];
        self.descriptionLabel.text = @"Description:";
        [self addSubview:self.descriptionLabel];
        
        self.descriptionTextField = [[UITextView alloc] initWithFrame:CGRectMake(20.0, 340.0, self.bounds.size.width - 40.0, 100.0)];
        [self addSubview:self.descriptionTextField];
       self.descriptionTextField.layer.borderWidth = 1.0f;
       self.descriptionTextField.layer.borderColor = [[UIColor grayColor] CGColor];
        
//        self.submit = [[UIButton alloc] initWithFrame:CGRectMake(80.0, 440.0, self.bounds.size.width - 160.0, 30.0)];
//        self.submit.titleLabel.text = @"Submit";
//       
//        [self.submit.titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [self addSubview:self.submit];
//       [self.submit addTarget:self action:@selector(submitPressed:) forControlEvents:UIControlEventTouchUpInside];
       
       
       
       
       self.submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
       [self.submit addTarget:self action:@selector(submitPressed:) forControlEvents:UIControlEventTouchUpInside];
       [self.submit setTitle:@"Submit" forState:UIControlStateNormal];
       self.submit.frame = CGRectMake(80.0, 440.0, self.bounds.size.width - 160.0, 30.0);
       [self addSubview:self.submit];
       
       
       for (UIView *sub in self.subviews){
          if ([sub isKindOfClass:[UITextField class]]){
             sub.layer.borderWidth = 1.0f;
             sub.layer.borderColor = [[UIColor grayColor] CGColor];
          }
       }
       
       CAGradientLayer *gradient = [CAGradientLayer layer];
       gradient.frame = self.bounds;
       UIColor *startColour = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0];
       UIColor *endColour = [UIColor colorWithHue:0 saturation:0 brightness:0.93 alpha:1.0];
       gradient.colors = [NSArray arrayWithObjects:(id)[startColour CGColor], (id)[endColour CGColor], nil];
       [self.layer insertSublayer:gradient atIndex:0];
       
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

- (void)submitPressed:(UIButton *)sender{
    Activity *newAct = [[Activity alloc] init];
    newAct.activityName = self.activityNameTextField.text;
    newAct.descriptionText = self.descriptionTextField.text;
    newAct.startTime = self.startTime.text;
    newAct.endTime = self.endTime.text;
    newAct.participants = @[[[[MockData sharedObj] getPersonLibrary] objectAtIndex:10]];
    newAct.creator = [newAct.participants objectAtIndex:0];
    newAct.activityJoined = true;
    newAct.currentParticipants = 1;
    newAct.address = self.addressTextField.text;
    newAct.distance = 5.8f;
    newAct.category = [self.pickerArray objectAtIndex:[self.categoryPicker selectedRowInComponent:0]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newActivityAdded" object:newAct];
}

#pragma mark - Picker View Shit

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.pickerArray objectAtIndex:row];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
