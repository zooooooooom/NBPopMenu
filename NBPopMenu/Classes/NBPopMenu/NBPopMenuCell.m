//
//  NBPopMenuCell.m
//  弹出菜单
//
//  Created by mac on 2017/10/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NBPopMenuCell.h"

static NSString *NBPopMenuCellID = @"NBPopMenuCellID";
@interface NBPopMenuCell()
@property (nonatomic, strong) UIView *bottomLine;

@end
@implementation NBPopMenuCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NBPopMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:NBPopMenuCellID];
    if (cell == nil) {
        cell = [[NBPopMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NBPopMenuCellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

#pragma mark - 系统方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_bottomLine setFrame:CGRectMake(0, self.contentView.bounds.size.height-0.5, self.contentView.bounds.size.width, 0.5)];
}


- (void)setupUI
{
    [self.contentView addSubview:self.bottomLine];
}


#pragma mark - set方法
- (void)setBottomLineColor:(UIColor *)bottomLineColor
{
    _bottomLineColor = bottomLineColor;
    self.bottomLine.backgroundColor = bottomLineColor;
}

- (void)setIsShowSeparator:(BOOL)isShowSeparator
{
    _isShowSeparator = isShowSeparator;
    self.bottomLine.hidden = !isShowSeparator;
}


#pragma mark - 懒加载
- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _bottomLine;
}

@end
