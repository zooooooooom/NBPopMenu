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

#pragma mark - 从一个View弹出
/**
 传入一个View 从这个View弹出(不包含图片)

 @param items 需要展示的数组
 @param fromView 从哪个View弹出
 @param configBlock 配置的block(在这里进行属性配置)
 @param clickIndexBlock 点击的block回调
 @param backgroundViewClick 背景点击的block回调
 @return 返回对象
 */
+ (instancetype)showPopMenuWithItems:(NSArray <NSString *>*)items
                            fromView:(UIView *)fromView
                    updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock
                           clickItem:(void(^)(NSInteger index))clickIndexBlock
                 backgroundViewClick:(void(^)(void))backgroundViewClick;


/**
 传入一个View 从这个View弹出带图片(带图片)

 @param items 需要展示的数组
 @param images 数组对应的图片
 @param fromView 从哪个View弹出
 @param configBlock 配置的block(在这里进行属性配置)
 @param clickIndexBlock 点击的block回调
 @param backgroundViewClick 背景点击的block回调
 @return 返回对象
 */
+ (instancetype)showPopMenuWithItems:(NSArray <NSString *>*)items
                            WithImages:(NSArray <NSString *>*)images
                            fromView:(UIView *)fromView
                    updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock
                           clickItem:(void(^)(NSInteger index))clickIndexBlock
                 backgroundViewClick:(void(^)(void))backgroundViewClick;

/**
 传入一个View 从这个View弹出带图片(带图片)

 @param itemDict 用一个字典包装传入的展示数组与图片数组
 @param fromView 从哪个View弹出
 @param configBlock 配置的block(在这里进行属性配置)
 @param clickIndexBlock 点击的block回调
 @param backgroundViewClick 背景点击的block回调
 @return 返回对象
 */
+ (instancetype)showPopMenuWithDict:(NSDictionary *)itemDict
                            fromView:(UIView *)fromView
                    updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock
                           clickItem:(void(^)(NSInteger index))clickIndexBlock
                backgroundViewClick:(void(^)(void))backgroundViewClick;


#pragma mark - 从一个点弹出
/**
 传入一个point点 从这个point弹出(不包含图片)

 @param items 需要展示的数组
 @param point 从哪个点弹出
 @param configBlock 配置的block(在这里进行属性配置)
 @param clickIndexBlock 点击的block回调
 @param backgroundViewClick 背景点击的block回调
 @return 返回对象
 */
+ (instancetype)showPopMenuWithItems:(NSArray <NSString *>*)items
                           fromPoint:(CGPoint)point
                    updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock
                           clickItem:(void(^)(NSInteger index))clickIndexBlock
                 backgroundViewClick:(void(^)(void))backgroundViewClick;

/**
 传入一个point点 从这个point弹出(带图片)

 @param items 需要展示的数组
 @param images 与展示数组匹配的图片数组
 @param point 从哪个点弹出
 @param configBlock 配置的block(在这里进行属性配置)
 @param clickIndexBlock 点击的block回调
 @param backgroundViewClick 背景点击的block回调
 @return 返回对象
 */
+ (instancetype)showPopMenuWithItems:(NSArray <NSString *>*)items
                          WithImages:(NSArray <NSString *>*)images
                           fromPoint:(CGPoint)point
                    updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock
                           clickItem:(void(^)(NSInteger index))clickIndexBlock
                 backgroundViewClick:(void(^)(void))backgroundViewClick;

/**
 传入一个point点 从这个point弹出(带图片)

 @param itemDict 用一个字典包装传入的展示数组与图片数组
 @param point 从哪个点弹出
 @param configBlock 配置的block(在这里进行属性配置)
 @param clickIndexBlock 点击的block回调
 @param backgroundViewClick 背景点击的block回调
 @return 返回对象
 */
+ (instancetype)showPopMenuWithDict:(NSDictionary *)itemDict
                            fromPoint:(CGPoint)point
                    updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock
                           clickItem:(void(^)(NSInteger index))clickIndexBlock
                backgroundViewClick:(void(^)(void))backgroundViewClick;


@end
