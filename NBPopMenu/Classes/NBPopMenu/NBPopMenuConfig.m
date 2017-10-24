//
//  NBPopMenuConfig.m
//  弹出菜单
//
//  Created by mac on 2017/9/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NBPopMenuConfig.h"

@implementation NBPopMenuConfig

+ (instancetype)defaultConfig
{
    NBPopMenuConfig *config = [[NBPopMenuConfig alloc] init];
    config.popMenuOffset = 0.0;
    config.popMenuItemHeight = 44;
    config.popMenuVisibleItemCount = 5;
    config.popMenuWidth = 150;
    config.popMenuArrowWidth = 15;
    config.popMenuArrowHeight = 10;
    config.popMenuCornerRadius = 6;
    config.popMenuSeparatorColor = [UIColor lightGrayColor];
    config.popMenuBackgroundColor = [UIColor whiteColor];
    config.popMenuSelectIndex = -1;
    config.popMenuSelectedBgColor = [UIColor lightGrayColor];
    config.popMenuTextColor = [UIColor blackColor];
    config.popMenuCoverColor = [UIColor blackColor];
    config.popMenuCoverAlpha = 0.2;
    return config;
}

- (void)setPopMenuOffset:(CGFloat)popMenuOffset
{
    _popMenuOffset = popMenuOffset;
    if (_popMenuOffset<0) {
        _popMenuOffset = 0;
    }
}


@end
