//
//  HNAMutiStateButton.m
//  MedicalNet
//
//  Created by gengliming on 15/12/10.
//  Copyright © 2015年 HaiHang. All rights reserved.
//

#import "HNAMutiStateButton.h"

@interface HNAMutiStateButton(){
    UIColor *_disbledBackgroundColor;
}

@end

@implementation HNAMutiStateButton

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    if (state == UIControlStateDisabled) {
        _disbledBackgroundColor = backgroundColor;
        if (self.state == UIControlStateDisabled) {
            [super setBackgroundColor:backgroundColor];
        }
    } else {
        [super setBackgroundColor:backgroundColor];
    }
}

@end
