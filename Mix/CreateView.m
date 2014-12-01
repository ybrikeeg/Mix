//
//  CreateView.m
//  Mix
//
//  Created by William Huang on 12/1/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "CreateView.h"
#import "Activity.h"

@interface CreateView ()
@property (strong, nonatomic) UILabel *activityLabel;
@property (strong, nonatomic) UITextField *activityNameTextField;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UITextField *addressTextField;
@property (strong, nonatomic) UILabel *startTimeLabel;
@property (nonatomic, strong) UITextField *startTime;
@property (strong, nonatomic) UILabel *endTimeLabel;
@property (nonatomic, strong) UITextField *endTime;
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
        
        self.activityNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 40.0, self.bounds.size.width - 40.0, 25.0)];
        [self addSubview:self.activityNameTextField];
        
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 80.0, 75.0, 20.0)];
        self.addressLabel.text = @"Address:";
        [self addSubview:self.addressLabel];
        
        self.addressTextField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 110.0, self.bounds.size.width - 40.0, 25.0)];
        [self addSubview:self.addressTextField];
        
        self.startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 150.0, 90.0, 20.0)];
        self.startTimeLabel.text = @"Start Time:";
        [self addSubview:self.startTimeLabel];
        
        self.startTime = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 180.0, self.bounds.size.width - 40.0, 25.0)];
        [self addSubview:self.startTime];
        
        self.endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 220.0, 90.0, 20.0)];
        self.endTimeLabel.text = @"End Time:";
        [self addSubview:self.endTimeLabel];
        
        self.endTime = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 250.0, self.bounds.size.width - 40.0, 25.0)];
        [self addSubview:self.endTime];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 290.0, 110.0, 20.0)];
        self.descriptionLabel.text = @"Description:";
        [self addSubview:self.descriptionLabel];
        
        self.descriptionTextField = [[UITextView alloc] initWithFrame:CGRectMake(20.0, 320.0, self.bounds.size.width - 40.0, 100.0)];
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
    newAct.participants = @[];
    newAct.address = self.addressTextField.text;
    newAct.distance = 5.8f;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newActivityAdded" object:newAct];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
