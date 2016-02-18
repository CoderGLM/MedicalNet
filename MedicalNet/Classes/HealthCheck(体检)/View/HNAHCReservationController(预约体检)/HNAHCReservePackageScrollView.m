//
//  HNAPackageButtonScrollView.m
//  MedicalNet
//
//  Created by gengliming on 15/12/2.
//  Copyright © 2015年 HaiHang. All rights reserved.
//

#import "HNAHCReservePackageScrollView.h"
#import "HNAHCReservePackageButton.h"

#define Padding 5

@interface HNAHCReservePackageScrollView()

@end
@implementation HNAHCReservePackageScrollView

#pragma mark - 初始化
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}

- (void)layoutSubviews {
    // 放置button
    CGFloat w = self.frame.size.height-2*Padding;
    for (NSInteger i=0; i<self.buttons.count; i++) {
        CGFloat x = i*(Padding+w);
        CGFloat y = Padding;
        CGRect frame = CGRectMake(x, y, w, w);
        self.buttons[i].frame = frame;
    }
    
    // 设置contentSize
    CGSize contentSize = CGSizeMake(self.buttons.count*(Padding+w)+Padding, self.frame.size.height);
    self.contentSize = contentSize;
}

#pragma mark - 添加数据
- (NSMutableArray *)buttons {
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setModelItems:(NSMutableArray *)modelItems{
    _modelItems = modelItems;
    
    NSInteger count = modelItems.count;
    
    // 添加items到scrollView
    for (NSInteger i = 0; i < count; i++) {
        HNAHCReservePackageButton *button = [HNAHCReservePackageButton packageButtonWithModel: modelItems[i]];
        [self addButton:button withIndex:i];
    }
    
    [self layoutIfNeeded];
}

- (void)addButtonWithModel:(HNAPackageListItem *)model {
    HNAHCReservePackageButton *button = [HNAHCReservePackageButton packageButtonWithModel:model];
    
    [self.modelItems addObject:model];
    
    // 添加button
    NSInteger index = self.modelItems.count - 1;
    [self addButton:button withIndex:index];
}

- (void)addButton:(HNAHCReservePackageButton *)button withIndex:(NSInteger)index{
    [self.buttons addObject:button];
    
    // 设置标签
    button.tag = index;
    [self addSubview:button];
    
    // 添加事件
    [button addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectWithPackageId:(NSInteger)packageId {
    for (NSInteger i=0; i<self.buttons.count; i++) {
        if (self.buttons[i].model.packageId == packageId) {
            self.selectedButton = self.buttons[i];
            return;
        }
    }
}

- (void)selectAtIndex:(NSInteger)index {
    if (self.buttons!=nil && self.buttons.count > index) {
        self.selectedButton = self.buttons[index];
    }
}

- (NSInteger)packageIdAtIndex:(NSInteger)index {
    if (self.buttons!=nil && self.buttons.count > index) {
        return self.buttons[index].model.packageId;
    }
    return -1;
}

#pragma mark - 属性
- (NSInteger)selectedPackageId {
    return self.selectedButton.model.packageId;
}

- (void)setSelectedButton:(HNAHCReservePackageButton *)selectedButton {
    _selectedButton.selected = NO;
    _selectedButton = selectedButton;
    _selectedButton.selected = YES;
}

#pragma mark - 单击事件
- (void)itemClicked:(HNAHCReservePackageButton *)sender{
    // 问代理能不能点击
    if ([self.hcDelegate respondsToSelector:@selector(packageScrollView:willClickAtIndex:)] && ![self.hcDelegate packageScrollView:self willClickAtIndex:sender.tag]) {
        return;
    }
    
    if (sender == nil) {
        sender = [self.buttons firstObject];
    }
    
    // 修改button的选中状态
    self.selectedButton = sender;
    
    // 通知代理
    if ([self.hcDelegate respondsToSelector:@selector(packageScrollView:didClickedAtIndex:)]) {
        [self.hcDelegate packageScrollView:self didClickedAtIndex:sender.tag];
    }
}
@end
