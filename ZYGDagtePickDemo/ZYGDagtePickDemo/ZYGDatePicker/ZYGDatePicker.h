//
//  ZYGDatePicker.h
//  ZYGDagtePickDemo
//
//  Created by ZhangYunguang on 16/4/28.
//  Copyright © 2016年 ZhangYunguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYGDatePickerDelegate;
@interface ZYGDatePicker : UIView
/**
 *  设置datePicker的mode
 */
@property (nonatomic, assign) UIDatePickerMode pickMode;
/**
 *  设置datePicker出现时显示的日期，默认为当前日期
 */
@property (nonatomic, strong) NSDate           *date;
/**
 *  设置datePicker的最大日期，默认为无限制
 */
@property (nonatomic, strong) NSDate           *maxDate;
/**
 *  设置datePicker的最小日期，默认为无限制
 */
@property (nonatomic, strong) NSDate           *minDate;
/**
 *  设置datePicker的代理
 */
@property (nonatomic, assign) id<ZYGDatePickerDelegate> delegate;
/**
 *  隐藏datePicker
 */
- (void)removePicker;

@end
/**
 *  datePicker的协议
 */
@protocol ZYGDatePickerDelegate <NSObject>
/**
 *  点击确定按钮时的回调事件（可选）
 */
@optional
-(void)chooseDate:(NSString *)dateString;

@end