//
//  AddActivityViewController.m
//  Mix
//
//  Created by William Huang on 11/30/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "AddActivityViewController.h"
#import "Activity.h"

@interface AddActivityViewController ()

@property (strong, nonatomic) IBOutlet UITextField *activityNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (nonatomic, strong) IBOutlet UITextField *startTime;
@property (nonatomic, strong) IBOutlet UITextField *endTime;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextField;

@end

@implementation AddActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitAction:(UIButton *)sender {
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
- (IBAction)endEditingTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
