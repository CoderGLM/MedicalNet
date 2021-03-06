//
//  HNAChangeCipherController.h
//  MedicalNet
//
//  Created by gengliming on 15/11/20.
//  Copyright © 2015年 HaiHang. All rights reserved.
//

// 修改密码

#import <UIKit/UIKit.h>
#import "HNAChangeBaseController.h"

typedef NS_ENUM(NSInteger,HNAChangeCipherControllerType) {
    HNAChangeCipherControllerTypeDefault,
    HNAChangeCipherControllerTypeViaPhoneValidation
};

@interface HNAChangeCipherController : HNAChangeBaseController

@property (nonatomic, assign) HNAChangeCipherControllerType type;

@end
