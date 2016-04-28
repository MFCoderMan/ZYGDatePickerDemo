//
//  ViewController.m
//  ZYGDagtePickDemo
//
//  Created by ZhangYunguang on 16/4/27.
//  Copyright © 2016年 ZhangYunguang. All rights reserved.
//

#import "ViewController.h"
#import "ZYGDatePicker.h"

@interface ViewController ()<ZYGDatePickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ZYGDatePicker *picker = [[ZYGDatePicker alloc] init];
    picker.backgroundColor = [UIColor greenColor];
    picker.pickMode = UIDatePickerModeDate;
    picker.maxDate = [NSDate date];
    picker.delegate = self;
    [self.view addSubview:picker];
    
}
-(void)chooseDate:(NSString *)dateString{
    NSLog(@"-------> %@",dateString);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
