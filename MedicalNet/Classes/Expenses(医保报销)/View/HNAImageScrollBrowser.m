//
//  HNAImageScrollBrowser.m
//  MedicalNet
//
//  Created by gengliming on 16/1/20.
//  Copyright © 2016年 HaiHang. All rights reserved.
//

#import "HNAImageScrollBrowser.h"
#import "UIImageView+WebCache.h"

#define CellMargin 5

@interface HNAImageScrollBrowserLayout()

@end

@implementation HNAImageScrollBrowserLayout

@end

@interface HNAImageScrollBrowser() <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation HNAImageScrollBrowser
@synthesize imageUrls = _imageUrls;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    // 添加collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection: UICollectionViewScrollDirectionHorizontal];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout: layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:collectionView];
    _collectionView = collectionView;
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HNAImageScrollBrowserCell"];
    
//    测试
//    for (NSInteger i=0; i<20; i++) {
//        [_imageUrls addObject:@"https://www.baidu.com/img/bd_logo1.png"];
//    }
}

- (void)layoutSubviews {
    self.collectionView.frame = self.bounds;
}

#pragma mark - Custom Accessors
- (NSMutableArray<NSString *> *)imageUrls {
    if (_imageUrls == nil) {
        _imageUrls = [NSMutableArray array];
    }
    return _imageUrls;
}

- (void)setImageUrls:(NSMutableArray<NSString *> *)imageUrls {
    _imageUrls = imageUrls;
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HNAImageScrollBrowserCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL: [NSURL URLWithString: self.imageUrls[indexPath.row]]];
    
    cell.backgroundView = imageView;
    return  cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = self.frame.size.height-2*CellMargin;
    return CGSizeMake(w, w);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(CellMargin, CellMargin, CellMargin, CellMargin);
}

@end


