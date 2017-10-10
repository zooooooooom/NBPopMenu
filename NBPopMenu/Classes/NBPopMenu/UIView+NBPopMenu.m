//
//  UIView+NBPopMenu.m
//  弹出菜单
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIView+NBPopMenu.h"

@implementation UIView (NBPopMenu)
- (void)setNbPopMenu_x:(CGFloat)nbPopMenu_x
{
    CGRect frame = self.frame;
    frame.origin.x = nbPopMenu_x;
    self.frame = frame;
}

- (CGFloat)nbPopMenu_x
{
    return self.frame.origin.x;
}

- (void)setNbPopMenu_y:(CGFloat)nbPopMenu_y
{
    CGRect frame = self.frame;
    frame.origin.y = nbPopMenu_y;
    self.frame = frame;
}

- (CGFloat)nbPopMenu_y
{
    return self.frame.origin.y;
}

- (void)setNbPopMenu_origin:(CGPoint)nbPopMenu_origin
{
    CGRect frame = self.frame;
    frame.origin = nbPopMenu_origin;
    self.frame = frame;
}

- (CGPoint)nbPopMenu_origin
{
    return self.frame.origin;
}

- (CGFloat)nbPopMenu_centerX
{
    return self.center.x;
}

- (void)setNbPopMenu_centerX:(CGFloat)nbPopMenu_centerX
{
    CGPoint center = self.center;
    center.x = nbPopMenu_centerX;
    self.center = center;
}

- (CGFloat)nbPopMenu_centerY
{
    return self.center.y;
}

- (void)setNbPopMenu_centerY:(CGFloat)nbPopMenu_centerY
{
    CGPoint center = self.center;
    center.y = nbPopMenu_centerY;
    self.center = center;
}

- (CGFloat)nbPopMenu_width
{
    return self.frame.size.width;
}

- (void)setNbPopMenu_width:(CGFloat)nbPopMenu_width
{
    CGRect frame = self.frame;
    frame.size.width = nbPopMenu_width;
    self.frame = frame;
}

- (CGFloat)nbPopMenu_height
{
    return self.frame.size.height;
}

- (void)setNbPopMenu_height:(CGFloat)nbPopMenu_height
{
    CGRect frame = self.frame;
    frame.size.height = nbPopMenu_height;
    self.frame = frame;
}

- (CGSize)nbPopMenu_size
{
    return self.frame.size;
}

- (void)setNbPopMenu_size:(CGSize)nbPopMenu_size
{
    CGRect frame = self.frame;
    frame.size = nbPopMenu_size;
    self.frame = frame;
}

@end
