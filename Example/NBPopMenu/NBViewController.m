//
//  NBViewController.m
//  NBPopMenu
//
//  Created by 260497176@qq.com on 10/10/2017.
//  Copyright (c) 2017 260497176@qq.com. All rights reserved.
//

#import "NBViewController.h"
#import "NBPopMenu.h"

@interface NBViewController ()

@end

@implementation NBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"测试";
    // 左边的
    UIButton *popLeftBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [popLeftBtn addTarget:self action:@selector(leftRightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:popLeftBtn];
    // 右边的
    UIButton *popRightBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [popRightBtn addTarget:self action:@selector(leftRightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:popRightBtn];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    static NSInteger ind = 2;
    NSArray *arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: self.view];
    [NBPopMenu showPopMenuWithItems:arr fromPoint:p updateWithConfig:^(NBPopMenuConfig *config) {
        config.popMenuVisibleItemCount = 4;
        config.popMenuOffset = 5;
        config.popMenuSelectIndex = ind;
        config.popMenuSelectedBgColor = [UIColor yellowColor];
    } clickItem:^(NSInteger index) {
        ind = index;
    }];
}


/**
 中间按钮的点击// 取消箭头
 */
- (IBAction)midBtnClick:(UIButton *)sender {
    
    NSArray *arr = @[@"1",@"2",@"3",@"4"];
    [NBPopMenu showPopMenuWithItems:arr fromView:sender updateWithConfig:^(NBPopMenuConfig *config) {
        config.popMenuSeparatorColor = [UIColor blackColor];
        config.popMenuOffset = 5;
        config.popMenuArrowHeight = 0;
        config.popMenuSelectedBgColor = [UIColor yellowColor];
        config.popMenuCoverColor = [UIColor colorWithWhite:1 alpha:1];
        config.popMenuCoverAlpha = 0.8;
    } clickItem:nil];
}


/**
 导航栏左右按钮的点击
 */
- (void)leftRightBarButtonClick:(UIButton *)btn
{
    NSArray *arr = @[@"1",@"2",@"3",@"4"];
    [NBPopMenu showPopMenuWithItems:arr fromView:btn updateWithConfig:^(NBPopMenuConfig *config) {
        config.popMenuSeparatorColor = [UIColor grayColor];
        config.popMenuOffset = 5;
        config.popMenuArrowHeight = 5;
        config.popMenuSelectedBgColor = [UIColor lightGrayColor];
        config.popMenuBackgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        config.popMenuTextColor = [UIColor whiteColor];
    } clickItem:nil];
}

/**
 View四角四个按钮的的点击
 */
- (IBAction)addBtnClick:(UIButton *)sender {
    NSArray *arr = @[@"1",@"2",@"3",@"4"];
    [NBPopMenu showPopMenuWithItems:arr fromView:sender updateWithConfig:^(NBPopMenuConfig *config) {
        config.popMenuSeparatorColor = [UIColor redColor];
        config.popMenuOffset = 4;
        config.popMenuArrowHeight = 6;
        config.popMenuSelectedBgColor = [UIColor yellowColor];
    } clickItem:nil];
    
}




@end
