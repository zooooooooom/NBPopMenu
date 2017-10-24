# NBPopMenu

[![CI Status](http://img.shields.io/travis/260497176@qq.com/NBPopMenu.svg?style=flat)](https://travis-ci.org/260497176@qq.com/NBPopMenu)
[![Version](https://img.shields.io/cocoapods/v/NBPopMenu.svg?style=flat)](http://cocoapods.org/pods/NBPopMenu)
[![License](https://img.shields.io/cocoapods/l/NBPopMenu.svg?style=flat)](http://cocoapods.org/pods/NBPopMenu)
[![Platform](https://img.shields.io/cocoapods/p/NBPopMenu.svg?style=flat)](http://cocoapods.org/pods/NBPopMenu)

## 示例图片

![image](https://github.com/shiyingfeng/NBPopMenu/raw/master/Gif/1.gif)

## 介绍
NBPopMenu支持弹出框定制.非常方便使用.使用简单.代码块集中.

## 使用方式

###### 1.最简洁的使用方式
```
NSArray *arr = @[@"1",@"2",@"3",@"4"];
[NBPopMenu showPopMenuWithItems:arr fromView:sender updateWithConfig:nil clickItem:nil];
```

###### 2.回调的使用方式
```
NSArray *arr = @[@"1",@"2",@"3",@"4"];
[NBPopMenu showPopMenuWithItems:arr fromView:sender updateWithConfig:nil clickItem:^(NSInteger index) {
NSLog(@"点击了%zd",index);
}];
```

###### 3.默认初始化一个选择(需配合使用)
```
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
```

## 安装

NBPopMenu 可以通过Pods安装 [CocoaPods](http://cocoapods.org).

```
pod 'NBPopMenu'
```

## 联系方式

左手边是幸福, 260497176@qq.com


