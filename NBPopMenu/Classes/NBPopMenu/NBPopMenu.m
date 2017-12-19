//
//  NBPopMenu.m
//  弹出菜单
//
//  Created by mac on 2017/9/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NBPopMenu.h"
#import "NBPopMenuConfig.h"
#import "UIView+NBPopMenu.h"
#import "NBPopMenuCell.h"

#define NBPopMenuKeyWindow [UIApplication sharedApplication].keyWindow
#define NBPopMenuScreenWidth [UIScreen mainScreen].bounds.size.width
#define NBPopMenuScreenHeight [UIScreen mainScreen].bounds.size.height

@interface NBPopMenu()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

/**
 用于保存数据
 */
@property(nonatomic, strong) NSArray <NSString *>*items;
/**
 用于保存图片的数组
 */
@property(nonatomic, strong) NSArray <NSString *>*images;
/**
 数据展示的tableView
 */
@property(nonatomic, strong) UITableView *menuTableView;
/**
 配置
 */
@property(nonatomic, strong) NBPopMenuConfig *config;
/**
 黑色遮罩
 */
@property(nonatomic, strong) UIButton *coverBtn;
/**
 保存用于点击选中的block
 */
@property(nonatomic, copy) void(^clickIndexBlock)(NSInteger);

/**
 保存用于点击背景的block
 */
@property(nonatomic, copy) void(^backgroundViewClick)(void);
/**
 容器View
 */
@property(nonatomic, strong) UIView *contentView;

@end

@implementation NBPopMenu
{
    CGPoint _anchorPoint;   // 弹出动画的锚点
    CGFloat _arrowPositionX;    // 箭头所在X轴的位置
}
@synthesize items = _items;

#pragma mark - 系统方法


#pragma mark - 快速创建方法推荐使用
/**
 快速创建方法
 */
+ (instancetype)showPopMenuWithItems:(NSArray <NSString *>*)items fromView:(UIView *)fromView updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock clickItem:(void(^)(NSInteger index))clickIndexBlock backgroundViewClick:(void(^)(void))backgroundViewClick;
{
    return [self showPopMenuWithItems:items WithImages:nil fromView:fromView updateWithConfig:configBlock clickItem:clickIndexBlock backgroundViewClick:backgroundViewClick];
}

+ (instancetype)showPopMenuWithItems:(NSArray <NSString *>*)items
                          WithImages:(NSArray <NSString *>*)images
                            fromView:(UIView *)fromView
                    updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock
                           clickItem:(void(^)(NSInteger index))clickIndexBlock
                backgroundViewClick:(void(^)(void))backgroundViewClick
{
    NBPopMenu *popMenu = [[NBPopMenu alloc] initWithItems:items images:images updateWithConfig:configBlock clickItem:clickIndexBlock backgroundViewClick:backgroundViewClick];
    
    [popMenu showFromView:fromView];
    
    return popMenu;
}

+ (instancetype)showPopMenuWithDict:(NSDictionary *)itemDict
                            fromView:(UIView *)fromView
                    updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock
                           clickItem:(void(^)(NSInteger index))clickIndexBlock
                 backgroundViewClick:(void(^)(void))backgroundViewClick
{
    NSMutableArray <NSString *>*arr = [NSMutableArray array];
    NSMutableArray <NSString *>*images = [NSMutableArray array];
    
    [itemDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL * _Nonnull stop) {
        [arr addObject:key];
        [images addObject:value];
    }];
    
    return [self showPopMenuWithItems:arr WithImages:images fromView:fromView updateWithConfig:configBlock clickItem:clickIndexBlock backgroundViewClick:backgroundViewClick];
}

+ (instancetype)showPopMenuWithItems:(NSArray <NSString *>*)items
                           fromPoint:(CGPoint)point
                    updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock
                           clickItem:(void(^)(NSInteger index))clickIndexBlock
                 backgroundViewClick:(void(^)(void))backgroundViewClick
{
    
    return [self showPopMenuWithItems:items WithImages:nil fromPoint:point updateWithConfig:configBlock clickItem:clickIndexBlock backgroundViewClick:backgroundViewClick];
}

+ (instancetype)showPopMenuWithDict:(NSDictionary *)itemDict
                          fromPoint:(CGPoint)point
                   updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock
                          clickItem:(void(^)(NSInteger index))clickIndexBlock
                backgroundViewClick:(void(^)(void))backgroundViewClick
{
    NSMutableArray <NSString *>*arr = [NSMutableArray array];
    NSMutableArray <NSString *>*images = [NSMutableArray array];
    
    [itemDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL * _Nonnull stop) {
        [arr addObject:key];
        [images addObject:value];
    }];
    return [self showPopMenuWithItems:arr WithImages:images fromPoint:point updateWithConfig:configBlock clickItem:clickIndexBlock backgroundViewClick:backgroundViewClick];
}

+ (instancetype)showPopMenuWithItems:(NSArray <NSString *>*)items
                          WithImages:(NSArray <NSString *>*)images
                           fromPoint:(CGPoint)point
                    updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock
                           clickItem:(void(^)(NSInteger index))clickIndexBlock
                 backgroundViewClick:(void(^)(void))backgroundViewClick

{
    NBPopMenu *popMenu = [[NBPopMenu alloc] initWithItems:items images:images updateWithConfig:configBlock clickItem:clickIndexBlock backgroundViewClick:backgroundViewClick];
    
    [popMenu showFromPoint:point];
    
    return popMenu;
}

- (instancetype)initWithItems:(NSArray <NSString *>*)items
                       images:(NSArray <NSString *>*)images
             updateWithConfig: (void(^)(NBPopMenuConfig *config))configBlock
                    clickItem:(void(^)(NSInteger index))clickIndexBlock
          backgroundViewClick:(void(^)(void))backgroundViewClick
{
    NBPopMenu *popMenu = [[NBPopMenu alloc] init];
    if (images != nil) {
        NSAssert(items.count == images.count, @"传入的选项和图片数量不一致");
        popMenu.images = images;
    }
    if (configBlock) {
        configBlock(popMenu.config);
    }
    
    popMenu.clickIndexBlock = clickIndexBlock;
    popMenu.backgroundViewClick = backgroundViewClick;
    popMenu.items = items;

    return popMenu;
}



- (void)setupFrameAndConfig
{
    self.alpha = 0;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 2.0;
    
    self.contentView.backgroundColor = self.config.popMenuBackgroundColor;
    
    CGFloat w = self.config.popMenuWidth;
    // 1. 计算自己的frame
    // 自己的高度等于内容的高度加上箭头的高度*2 上下余出箭头的距离
    CGFloat h = self.config.popMenuItemHeight * self.config.popMenuVisibleItemCount + self.config.popMenuArrowHeight * 2;
    self.nbPopMenu_width = w;
    self.nbPopMenu_height = h;
    
    // 2. 设置容器的frame
    self.contentView.frame = self.bounds;
    
    // 3, 设置 tableview 的frame
    self.menuTableView.frame = self.contentView.bounds;
    self.menuTableView.nbPopMenu_height -= 2 * self.config.popMenuArrowHeight;
    self.menuTableView.nbPopMenu_centerY = self.contentView.nbPopMenu_centerY;
}

- (void)setArrowPoint:(CGPoint)point
{
    // 1. 同时设置指向箭头的点
    _anchorPoint = point;
    // 2. 设置自己的x位置
    CGFloat arrowMargin = self.config.popMenuArrowWidth+self.config.popMenuCornerRadius;
    if ((point.x <= NBPopMenuScreenWidth-self.nbPopMenu_width*0.5) && (point.x >= self.nbPopMenu_width*0.5)) {
        self.nbPopMenu_x = point.x-self.nbPopMenu_width*0.5;
    } else if (point.x < self.nbPopMenu_width*0.5) {
        self.nbPopMenu_x = 0;
    } else {
        self.nbPopMenu_x = NBPopMenuScreenWidth-self.nbPopMenu_width;
    }
    
    // 3.设置自己的y位置
    self.nbPopMenu_y = point.y;
    
    // 4.设置箭头的positionX位置
    if (point.x <= self.nbPopMenu_width*0.5) { // 这里判断小于自己宽度一半
        _arrowPositionX = point.x-self.config.popMenuArrowWidth*0.5;
        // 在判断小于arrowMargin的情况
        if (point.x <= arrowMargin) {
            _arrowPositionX = arrowMargin-self.config.popMenuArrowWidth;
        }
    } else if (point.x >= NBPopMenuScreenWidth-self.nbPopMenu_width*0.5) { // 这里判断大于屏幕宽度减去自己一半的情况
        _arrowPositionX = self.nbPopMenu_width-(NBPopMenuScreenWidth-point.x)-self.config.popMenuArrowWidth*0.5;
        // 再判断大于最大arrowMargin的情况
        if (NBPopMenuScreenWidth-point.x <= arrowMargin) {
            _arrowPositionX = self.nbPopMenu_width-arrowMargin-self.config.popMenuArrowWidth*0.5;
        }
    } else { // 这就表明点击的位置在除去圆角半径和箭头一半宽度中间的位置
        _arrowPositionX = self.nbPopMenu_width*0.5-self.config.popMenuArrowWidth*0.5;
    }
}

- (void)showFromView:(UIView *)view
{
    CGRect relativeRect = [view convertRect:view.bounds toView:NBPopMenuKeyWindow];
    CGPoint relativePoint = CGPointMake(relativeRect.origin.x + relativeRect.size.width / 2, relativeRect.origin.y + relativeRect.size.height);
    self.contentView.layer.mask = [self getMaskLayerWithPoint:relativePoint];
    if (self.nbPopMenu_y < _anchorPoint.y) {
        self.nbPopMenu_y -= relativeRect.size.height;
    }
    [self show];
}
- (void)showFromPoint:(CGPoint)point
{
    self.contentView.layer.mask = [self getMaskLayerWithPoint:point];
    
    [self show];
}

- (CAShapeLayer *)getMaskLayerWithPoint:(CGPoint)point
{
    [self setArrowPoint:point];
    [self determineAnchorPoint];
    CAShapeLayer *layer = [self drawMaskLayer];
    if (CGRectGetMaxY(self.frame) > NBPopMenuScreenHeight) {
        _arrowPositionX = self.nbPopMenu_width - _arrowPositionX - self.config.popMenuArrowWidth;
        layer = [self drawMaskLayer];
        layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
        self.nbPopMenu_y = _anchorPoint.y - self.nbPopMenu_height;
    }
    self.nbPopMenu_y += self.nbPopMenu_y >= _anchorPoint.y ? self.config.popMenuOffset : -self.config.popMenuOffset;
    return layer;
}

/**
 展示
 */
- (void)show
{
    self.coverBtn.backgroundColor = self.config.popMenuCoverColor;
    self.coverBtn.alpha = 0;
    [NBPopMenuKeyWindow addSubview:self.coverBtn];
    [NBPopMenuKeyWindow addSubview:self];
    if (self.config.popMenuSelectIndex != -1 && self.config.popMenuSelectIndex < self.items.count) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.config.popMenuSelectIndex inSection:0];

        [self.menuTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    NBPopMenuCell *lastCell = [self getLastVisibleCell];
    lastCell.isShowSeparator = NO;
    self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration: 0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1;
        self.coverBtn.alpha = self.config.popMenuCoverAlpha;
    }];
}

/**
 按钮遮罩点击
 */
- (void)coverBtnClick:(UIButton *)coverBtnClick
{
    [self dismiss];
    if (self.backgroundViewClick) {
        self.backgroundViewClick();
    }
}

/**
 隐藏
 */
- (void)dismiss
{
    [UIView animateWithDuration: 0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
        self.coverBtn.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.coverBtn removeFromSuperview];
    }];
}
/**
 设置AnchorPoint点的位置用于从哪里弹出
 */
- (void)setAnimationAnchorPoint:(CGPoint)point
{
    CGRect originRect = self.frame;
    self.layer.anchorPoint = point;
    self.frame = originRect;
}

/**
 计算AnchorPoint点的位置用于从哪里弹出
 */
- (void)determineAnchorPoint
{
    CGPoint aPoint = CGPointMake(0.5, 0.5);
    if (CGRectGetMaxY(self.frame) > NBPopMenuScreenHeight) {
        aPoint = CGPointMake((fabs(_arrowPositionX)+self.config.popMenuArrowWidth*0.5) / self.config.popMenuWidth, 1);
    }else {
        aPoint = CGPointMake((fabs(_arrowPositionX)+self.config.popMenuArrowWidth*0.5) / self.config.popMenuWidth, 0);
    }
    [self setAnimationAnchorPoint:aPoint];
}


/**
 获取显示的最后一个cell
 */
- (NBPopMenuCell *)getLastVisibleCell
{
    NSArray <NSIndexPath *>*indexPaths = [self.menuTableView indexPathsForVisibleRows];
    indexPaths = [indexPaths sortedArrayUsingComparator:^NSComparisonResult(NSIndexPath *  _Nonnull obj1, NSIndexPath *  _Nonnull obj2) {
        return obj1.row < obj2.row;
    }];
    NSIndexPath *indexPath = indexPaths.firstObject;
    return [self.menuTableView cellForRowAtIndexPath:indexPath];
}

/**
 绘制
 */
- (CAShapeLayer *)drawMaskLayer
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.contentView.bounds;
    
    CGPoint topRightArcCenter = CGPointMake(self.nbPopMenu_width-self.config.popMenuCornerRadius, self.config.popMenuArrowHeight+self.config.popMenuCornerRadius);
    CGPoint topLeftArcCenter = CGPointMake(self.config.popMenuCornerRadius, self.config.popMenuArrowHeight+self.config.popMenuCornerRadius);
    CGPoint bottomRightArcCenter = CGPointMake(self.nbPopMenu_width-self.config.popMenuCornerRadius, self.nbPopMenu_height - self.config.popMenuArrowHeight - self.config.popMenuCornerRadius);
    CGPoint bottomLeftArcCenter = CGPointMake(self.config.popMenuCornerRadius, self.nbPopMenu_height - self.config.popMenuArrowHeight - self.config.popMenuCornerRadius);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(0, self.config.popMenuArrowHeight+self.config.popMenuCornerRadius)];
    [path addLineToPoint: CGPointMake(0, bottomLeftArcCenter.y)];
    [path addArcWithCenter: bottomLeftArcCenter radius: self.config.popMenuCornerRadius startAngle: -M_PI endAngle: -M_PI-M_PI_2 clockwise: NO];
    [path addLineToPoint: CGPointMake(self.nbPopMenu_width-self.config.popMenuCornerRadius, self.nbPopMenu_height - self.config.popMenuArrowHeight)];
    [path addArcWithCenter: bottomRightArcCenter radius: self.config.popMenuCornerRadius startAngle: -M_PI-M_PI_2 endAngle: -M_PI*2 clockwise: NO];
    [path addLineToPoint: CGPointMake(self.nbPopMenu_width, self.config.popMenuArrowHeight+self.config.popMenuCornerRadius)];
    [path addArcWithCenter: topRightArcCenter radius: self.config.popMenuCornerRadius startAngle: 0 endAngle: -M_PI_2 clockwise: NO];
    [path addLineToPoint: CGPointMake(_arrowPositionX+self.config.popMenuArrowWidth, self.config.popMenuArrowHeight)];
    [path addLineToPoint: CGPointMake(_arrowPositionX+0.5*self.config.popMenuArrowWidth, 0)];
    [path addLineToPoint: CGPointMake(_arrowPositionX, self.config.popMenuArrowHeight)];
    [path addLineToPoint: CGPointMake(self.config.popMenuCornerRadius, self.config.popMenuArrowHeight)];
    [path addArcWithCenter: topLeftArcCenter radius: self.config.popMenuCornerRadius startAngle: -M_PI_2 endAngle: -M_PI clockwise: NO];
    [path closePath];
    
    maskLayer.path = path.CGPath;
    
    return maskLayer;
}

#pragma mark - set方法
- (void)setItems:(NSArray<NSString *> *)items
{
    _items = items;
    if (self.config.popMenuVisibleItemCount > items.count) {
        self.config.popMenuVisibleItemCount = items.count;
    }
    self.menuTableView.scrollEnabled = self.config.popMenuVisibleItemCount != items.count;
    
    [self setupFrameAndConfig];
    [self.menuTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NBPopMenuCell *cell = [NBPopMenuCell cellWithTableView:tableView];
    cell.textLabel.text = self.items[indexPath.row];
    if (self.images) {
        NSString *imageName = self.images[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:imageName];
    }
    cell.bottomLineColor = self.config.popMenuSeparatorColor;
    cell.config = self.config;
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.config.popMenuItemHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.clickIndexBlock) {
        self.clickIndexBlock(indexPath.row);
    }
    [self dismiss];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NBPopMenuCell *lastCell = [self getLastVisibleCell];
    lastCell.isShowSeparator = YES;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NBPopMenuCell *lastCell = [self getLastVisibleCell];
    lastCell.isShowSeparator = NO;
}

#pragma mark - 懒加载
- (UITableView *)menuTableView
{
    if (_menuTableView == nil) {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _menuTableView.dataSource = self;
        _menuTableView.delegate = self;
        _menuTableView.pagingEnabled = YES;
        _menuTableView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_menuTableView];
    }
    return _menuTableView;
}
- (NBPopMenuConfig *)config
{
    if (_config == nil) {
        _config = [NBPopMenuConfig defaultConfig];
    }
    return _config;
}
- (NSArray<NSString *> *)items
{
    if (_items == nil) {
        _items = [NSArray array];
    }
    return _items;
}
- (UIButton *)coverBtn
{
    if (_coverBtn == nil) {
        _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _coverBtn.frame = [UIScreen mainScreen].bounds;
        _coverBtn.alpha = 0;
        [_coverBtn addTarget:self action:@selector(coverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coverBtn;
}
- (UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
    }
    return _contentView;
}

@end
