//
//  NBPopMenuProtocol.h
//  弹出菜单
//
//  Created by mac on 2017/9/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NBPopMenu;
@protocol NBPopMenuProtocol <NSObject>

@optional
- (void)popMenu:(NBPopMenu *)popMenu didSelectRowAtIndex:(NSInteger)index;

@end
