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
    
    // 添加中间view
    UIButton *titleView = [[UIButton alloc] init];
    [titleView setTitle:@"中间按钮" forState: UIControlStateNormal];
    [titleView setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [titleView addTarget:self action:@selector(titleViewClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleView;
    
    // 左边的
    UIButton *popLeftBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [popLeftBtn addTarget:self action:@selector(leftRightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:popLeftBtn];
    // 右边的
    UIButton *popRightBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [popRightBtn addTarget:self action:@selector(leftRightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:popRightBtn];
    
}

/**
 导航栏中间按钮点击
 */
- (void)titleViewClick:(UIButton *)btn
{
    NSDictionary *itemDict = @{@"发起群聊":@"chat_img_groupchat",
                               @"添加朋友":@"home_img_my",
                               @"扫一扫":@"home_img_scan"
                               };
    
    [NBPopMenu showPopMenuWithDict:itemDict fromView:btn updateWithConfig:^(NBPopMenuConfig *config) {
        config.popMenuBackgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        config.popMenuTextColor = [UIColor whiteColor];
    } clickItem:^(NSInteger index) {
        NSLog(@"点击了%zd",index);
    }];
}

/**
 屏幕的点击
 */
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
 左上角按钮的点击
 */
- (IBAction)leftTopBtnClick:(UIButton *)sender {
    
    NSArray *arr = @[@"发起群聊",@"添加朋友",@"扫一扫"];
    NSArray *images = @[@"chat_img_groupchat",@"home_img_my",@"home_img_scan"];
    
    [NBPopMenu showPopMenuWithItems:arr WithImages:images fromView:sender updateWithConfig:^(NBPopMenuConfig *config) {
        config.popMenuBackgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        config.popMenuTextColor = [UIColor whiteColor];
    } clickItem:^(NSInteger index) {
        NSLog(@"点击了%zd",index);
    }];
}

/**
 右上角按钮的点击
 */
- (IBAction)topRightBtnClick:(UIButton *)sender {
    
    NSDictionary *itemDict = @{@"发起群聊":@"chat_img_groupchat",
                                      @"添加朋友":@"home_img_my",
                                      @"扫一扫":@"home_img_scan"
                                      };
    
    [NBPopMenu showPopMenuWithDict:itemDict fromPoint:sender.center updateWithConfig:^(NBPopMenuConfig *config) {
        config.popMenuBackgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        config.popMenuTextColor = [UIColor whiteColor];
    } clickItem:^(NSInteger index) {
        NSLog(@"点击了%zd",index);
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
