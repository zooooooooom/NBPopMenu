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
    [popLeftBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:popLeftBtn];
    // 右边的
    UIButton *popRightBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [popRightBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:popRightBtn];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray *arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: self.view];
    [NBPopMenu showPopMenuWithItems:arr fromPoint:p updateWithConfig:^(NBPopMenuConfig *config) {
        config.popMenuVisibleItemCount = 4;
        config.popMenuOffset = 5;
    } clickItem:^(NSInteger index) {
        
    }];
}



- (IBAction)addBtnClick:(UIButton *)sender {
    NSArray *arr = @[@"1",@"2",@"3",@"4"];
    [NBPopMenu showPopMenuWithItems:arr fromView:sender updateWithConfig:^(NBPopMenuConfig *config) {
        config.popMenuSeparatorColor = [UIColor redColor];
        config.popMenuOffset = 5;
    } clickItem:nil];
    
}




@end
