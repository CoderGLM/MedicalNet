//
//  HNAImagePickersScrollView.m
//  MedicalNet
//
//  Created by gengliming on 16/1/14.
//  Copyright © 2016年 HaiHang. All rights reserved.
//

#import "HNAImagePickersScrollView.h"
#import "HNAAutoUploadImagePicker.h"
#import "HNAImagePickerView.h"

#define Margin 5
#define ImagePickerWidth (self.frame.size.height-2*Margin)
#define DefaultBackgroundColor [UIColor clearColor]

@interface HNAImagePickersScrollView() <HNAAutoUploadImagePickerDelegate>

@property (nonatomic, strong) NSMutableArray<HNAAutoUploadImagePicker *> *imagePickers;

@end

@implementation HNAImagePickersScrollView

#pragma mark - View lifecycle
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
    // 设置ScrollView
    self.showsVerticalScrollIndicator = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.clipsToBounds = YES;
    self.backgroundColor = DefaultBackgroundColor;
    // 添加第一个imagePicker
    [self addImagePicker];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentSize = CGSizeMake(self.imagePickers.count*(ImagePickerWidth+Margin), self.frame.size.height);
    for (NSInteger i=0; i<self.imagePickers.count; i++) {
        CGRect frame = CGRectMake(i*(ImagePickerWidth+Margin)+Margin, Margin, ImagePickerWidth, ImagePickerWidth);
        self.imagePickers[i].frame = frame;
        self.imagePickers[i].backgroundColor = [UIColor redColor];
    }
}

#pragma mark - Custom Accessors
- (NSMutableArray<HNAAutoUploadImagePicker *> *)imagePickers {
    if (_imagePickers == nil) {
        _imagePickers = [NSMutableArray array];
    }
    return _imagePickers;
}

- (void)setSuperContainer:(UIView *)superContainer {
    _superContainer = superContainer;
    [_superContainer addSubview:self];
}

- (NSMutableArray<UIImage *> *)images {
    NSMutableArray<UIImage *> *array = [NSMutableArray array];
    for (HNAAutoUploadImagePicker *ipv in self.imagePickers) {
        if (ipv.image != nil) {
            [array addObject:ipv.image];
        }
    }
    return array;
}

- (NSMutableArray *)imageUrls {
    NSMutableArray *urls = [NSMutableArray array];
    for (HNAAutoUploadImagePicker *aip in self.imagePickers) {
        if (aip.uploadUrl != nil) {
            [urls addObject:aip.uploadUrl];
        }
    }
    return urls;
}

+ (instancetype)imagePickersScrollView {
    return [[HNAImagePickersScrollView alloc] init];
}

#pragma mark - Private
/** 是否需要添加新的imagePicker */
- (BOOL)needAddNewImagePicker {
    for (HNAAutoUploadImagePicker *imagePicker in self.imagePickers) {
        if (imagePicker.image == nil) {
            return NO;
        }
    }
    return YES;
}

- (void)addImagePicker {
    HNAAutoUploadImagePicker *imagePicker = [HNAAutoUploadImagePicker autoUploadImagePicker];
    imagePicker.delegate = self;
    [self.imagePickers addObject: imagePicker];
    [self addSubview: imagePicker];
    [self layoutIfNeeded];
}

- (void)removeImagePicker:(HNAAutoUploadImagePicker *)imagePicker {
    // 只有一个imagePicker时不操作
    if (self.imagePickers.count <= 1) {
        return;
    }
    [self.imagePickers removeObject:imagePicker];
    [imagePicker removeFromSuperview];
    
    [UIView animateWithDuration:0.25f animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - HNAAutoUploadImagePickerDelegate
- (BOOL)autoUploadImagePickerWillSelectImage:(HNAAutoUploadImagePicker *)autoUploadImagePicker {
    if ([self.ipsvDelegate respondsToSelector:@selector(imagePickersScrollViewWillSelectImage:)]) {
        return [self.ipsvDelegate imagePickersScrollViewWillSelectImage:self];
    }
    return YES;
}

- (void)autoUploadImagePickerDidSelectImage:(HNAAutoUploadImagePicker *)autoUploadImagePicker {
    if ([self needAddNewImagePicker]) {
        [self addImagePicker];
    }
}

- (void)autoUploadImagePickerDidRemoveImage:(HNAAutoUploadImagePicker *)autoUploadImagePicker {
    [self removeImagePicker: autoUploadImagePicker];
}

@end
