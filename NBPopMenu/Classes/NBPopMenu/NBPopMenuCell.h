//
//  NBPopMenuCell.h
//  弹出菜单
//
//  Created by mac on 2017/10/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NBPopMenuConfig;
@interface NBPopMenuCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic, strong) UIColor *bottomLineColor;
@property(nonatomic, assign) BOOL isShowSeparator;
@property(nonatomic, strong) NBPopMenuConfig *config;

@end
