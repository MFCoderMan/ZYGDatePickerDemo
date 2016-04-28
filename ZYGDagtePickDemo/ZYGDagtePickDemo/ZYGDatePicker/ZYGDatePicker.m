//
//  ZYGDatePicker.m
//  ZYGDagtePickDemo
//
//  Created by ZhangYunguang on 16/4/28.
//  Copyright © 2016年 ZhangYunguang. All rights reserved.
//

#import "ZYGDatePicker.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kDefaultDate  [NSDate date]
static const CGFloat kDefaultBackViewHeight = 236.0f;
static const CGFloat kPickerY               = 40.0f;
static const CGFloat kToolbarHeight         = 40.0f;
static const NSInteger kDefaultPickerMode   = UIDatePickerModeDate;

@interface ZYGDatePicker ()

@property (nonatomic, strong) UIDatePicker *picker;
@property (nonatomic, copy)   NSString     *result;
@end
@implementation ZYGDatePicker
#pragma mark - 初始化
-(instancetype)init{
    if (self =[super init]) {
        [self createDatePicker];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createDatePicker];
    }
    return self;
}
#pragma mark - 创建时间选择器
-(void)createDatePicker{
    if (!_picker) {
        self.backgroundColor = [UIColor lightGrayColor];
        UIDatePicker *picker = [[UIDatePicker alloc] init];
        picker.datePickerMode = kDefaultPickerMode;
        picker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        picker.date = kDefaultDate;
        self.picker = picker;
        [self.picker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.picker];
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kToolbarHeight)];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pikerCancalClick:)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(pickerDoneClick:)];
        toolbar.items = @[leftItem,space,rightItem];
        [self addSubview:toolbar];
        [self addObserver:self forKeyPath:@"date"     options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"pickMode" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"maxDate"  options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"minDate"  options:NSKeyValueObservingOptionNew context:nil];
        [self initResultValues];
    }
}
-(void)initResultValues{
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    if (self.pickMode == kDefaultPickerMode) {
        [fomatter setDateFormat:@"yyyy-MM-dd"];
    }else if (self.pickMode == UIDatePickerModeTime){
        [fomatter setDateFormat:@"HH:mm"];
    }else if (self.pickMode == UIDatePickerModeDateAndTime){
        [fomatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }else if (self.pickMode == UIDatePickerModeCountDownTimer){
        [fomatter setDateFormat:@"HH:mm"];
    }
    NSString *dateString = [fomatter stringFromDate:self.picker.date];
    self.result = dateString;
}
#pragma mark - 选择的日期、时间发生变化
-(void)dateChanged:(UIDatePicker *)picker{
    NSDate *date = picker.date;
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    if (self.pickMode == kDefaultPickerMode) {
        [fomatter setDateFormat:@"yyyy-MM-dd"];
    }else if (self.pickMode == UIDatePickerModeTime){
        [fomatter setDateFormat:@"HH:mm"];
    }else if (self.pickMode == UIDatePickerModeDateAndTime){
        [fomatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }else if (self.pickMode == UIDatePickerModeCountDownTimer){
        [fomatter setDateFormat:@"HH:mm"];
    }
    NSString *fomatterLocalDate = [fomatter stringFromDate:date];
    self.result = fomatterLocalDate;
//    NSLog(@"选择的结果：%@",fomatterLocalDate);
}
#pragma mark - 取消按钮
-(void)pikerCancalClick:(UIBarButtonItem *)leftItem{
    [self removePicker];
}
#pragma mark - 确定按钮
-(void)pickerDoneClick:(UIBarButtonItem *)rightItem{
    if ([self.delegate respondsToSelector:@selector(chooseDate:)]) {
        [self.delegate chooseDate:self.result];
    }
    [self removePicker];
}
#pragma mark - 移除picker
-(void)removePicker{
    [self.picker removeFromSuperview];
    [self removeFromSuperview];
}
#pragma mark - 布局子视图
-(void)layoutSubviews{
    [super layoutSubviews];
    if (!self.frame.size.height) {
        self.frame = CGRectMake(0, kScreenHeight - kDefaultBackViewHeight, kScreenWidth, kDefaultBackViewHeight);
    }
    self.picker.frame = CGRectMake(0, kPickerY, self.bounds.size.width, self.bounds.size.height - kPickerY);
}
#pragma mark - KVO监测属性值的变化
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"date"]) {
        self.picker.date = self.date;
    }else if ([keyPath isEqualToString:@"pickMode"]) {
        self.picker.datePickerMode = self.pickMode;
        [self initResultValues];
    }else if ([keyPath isEqualToString:@"maxDate"]) {
        self.picker.maximumDate = self.maxDate;
    }else if ([keyPath isEqualToString:@"minDate"]) {
        self.picker.minimumDate = self.minDate;
    }
}
- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"date"];
    [self removeObserver:self forKeyPath:@"pickMode"];
    [self removeObserver:self forKeyPath:@"maxDate"];
    [self removeObserver:self forKeyPath:@"minDate"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
