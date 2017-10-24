//
//  NBPopMenuConfig.h
//  弹出菜单
//
//  Created by mac on 2017/9/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBPopMenuConfig : NSObject

/**
 默认配置
 */
+ (instancetype)defaultConfig;
/**
 默认选中的项(默认不选中)
 */
@property(nonatomic, assign) CGFloat popMenuSelectIndex;
/**
 指向箭头的高度
 */
@property(nonatomic, assign) CGFloat popMenuOffset;
/**
 每一行的高度(配合visibleItemCount属性使用)
 */
@property(nonatomic, assign) CGFloat popMenuItemHeight;

/**
 最多可见的数量(配合itemHeight使用可以得到自身的)
 */
@property(nonatomic, assign) NSInteger popMenuVisibleItemCount;
/**
 显示宽度
 */
@property(nonatomic, assign) CGFloat popMenuWidth;

/**
 指向箭头的宽度
 */
@property(nonatomic, assign) CGFloat popMenuArrowWidth;

/**
 指向箭头的高度
 */
@property(nonatomic, assign) CGFloat popMenuArrowHeight;

/**
 圆角半径
 */
@property(nonatomic, assign) CGFloat popMenuCornerRadius;

/**
 分割线颜色
 */
@property(nonatomic, strong) UIColor *popMenuSeparatorColor;

/**
 背景颜色(可传入带alpha的颜色)
 */
@property(nonatomic, strong) UIColor *popMenuBackgroundColor;
/**
 分割线颜色
 */
@property(nonatomic, strong) UIColor *popMenuSelectedBgColor;
/**
 字体颜色
 */
@property(nonatomic, strong) UIColor *popMenuTextColor;
/**
 底部遮盖的颜色默认[UIColor blackColor];
 */
@property(nonatomic, strong) UIColor *popMenuCoverColor;
/**
 底部遮盖的颜色的alpha(0~1)之间过渡 与popMenuCoverColor结合使用默认0.2
 */
@property(nonatomic, assign) CGFloat popMenuCoverAlpha;

@end
