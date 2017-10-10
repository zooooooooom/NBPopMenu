//
//  NBPopMenu.h
//  弹出菜单
//
//  Created by mac on 2017/9/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBPopMenuConfig.h"

@interface NBPopMenu : UIView

/**
 传入一个View 从这个View弹出

 @param items 需要展示的数组
 @param fromView 从哪个View弹出
 @param configBlock 配置的block(在这里进行属性配置)
 @param clickIndexBlock 点击的block回调
 @return 返回对象
 */
+ (instancetype)showPopMenuWithItems:(NSArray <NSString *>*)items
                            fromView:(UIView *)fromView
                    updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock
                           clickItem:(void(^)(NSInteger index))clickIndexBlock;

/**
 传入一个point点 从这个point弹出

 @param items 需要展示的数组
 @param point 从哪个点弹出
 @param configBlock 配置的block(在这里进行属性配置)
 @param clickIndexBlock 点击的block回调
 @return 返回对象
 */
+ (instancetype)showPopMenuWithItems:(NSArray <NSString *>*)items
                           fromPoint:(CGPoint)point
                    updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock
                           clickItem:(void(^)(NSInteger index))clickIndexBlock;


@end
