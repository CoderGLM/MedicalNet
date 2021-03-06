//
//  HNAHealthCheckTool.m
//  MedicalNet
//
//  Created by gengliming on 15/12/14.
//  Copyright © 2015年 HaiHang. All rights reserved.
//

#import "HNAHealthCheckTool.h"
#import "HNAHttpTool.h"
#import "MJExtension.h"
#import "HNAGetHCRecordsParam.h"
#import "HNAGetHCRecordsResult.h"
#import "HNAGetHCDetailParam.h"
#import "HNAGetHCDetailResult.h"
#import "HNAGetPackageDetailParam.h"
#import "HNAGetPackageDetailResult.h"
#import "HNAGetPackageListParam.h"
#import "HNAGetPackageListResult.h"
#import "HNAGetHCOrganListParam.h"
#import "HNAGetHCOrganListResult.h"
#import "HNAReserveHCParam.h"
#import "HNAReserveHCResult.h"

@implementation HNAHealthCheckTool

/**
 *  获取体检纪录
 *
 *  @param param   参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getHCRecordsWithParam:(HNAGetHCRecordsParam *)param success:(void(^)(HNAGetHCRecordsResult *result))success failure:(void(^)(NSError *error))failure{
    // 请求地址
    NSString *urlStr = [NSString stringWithFormat:@"%@/medical/medicalRecords", kRequestUrlDomain];
    // 发送请求
    [HNAHttpTool getWithURL:urlStr params:param.keyValues success:^(id json) {
        if (success) {
            HNAGetHCRecordsResult *result = [HNAGetHCRecordsResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  获取体检详情
 *
 *  @param param   参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getHCDetailWithParam:(HNAGetHCDetailParam *)param success:(void (^)(HNAGetHCDetailResult *result))success failure:(void (^)(NSError *error))failure{
    // 请求地址
    NSString *urlStr = [NSString stringWithFormat:@"%@/medical/medicalDetails", kRequestUrlDomain];
    // 发送请求
    [HNAHttpTool getWithURL:urlStr params:param.keyValues success:^(id json) {
        if (success) {
            HNAGetHCDetailResult *result = [HNAGetHCDetailResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  获取体检套餐详情
 *
 *  @param param   参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getPackgetDetailWithParam:(HNAGetPackageDetailParam *)param success:(void (^)(HNAGetPackageDetailResult *result))success failure:(void (^)(NSError *error))failure{
    
    // 请求地址
    NSString *urlStr = [NSString stringWithFormat:@"%@/medical/packageDetails", kRequestUrlDomain];
    // 发送请求
    [HNAHttpTool getWithURL:urlStr params:param.keyValues success:^(id json) {
        if (success) {
            HNAGetPackageDetailResult *result = [HNAGetPackageDetailResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
/**
 *  获取体检套餐列表
 *
 *  @param param   参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getPackageListWithParam:(HNAGetPackageListParam *)param success:(void (^)(HNAGetPackageListResult *result))success failure:(void (^)(NSError *error))failure{
    
    // 请求地址
    NSString *urlStr = [NSString stringWithFormat:@"%@/medical/getPackageLists", kRequestUrlDomain];
    
    // 发送请求
    [HNAHttpTool getWithURL:urlStr params:param.keyValues success:^(id json) {
        if (success) {
            HNAGetPackageListResult *result = [HNAGetPackageListResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
/**
 *  获取体检机构列表
 *
 *  @param param   参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getHCOrganListWithParam:(HNAGetHCOrganListParam *)param success:(void (^)(HNAGetHCOrganListResult *result))success failure:(void (^)(NSError *error))failure{
    // 请求地址
    NSString *urlStr = [NSString stringWithFormat:@"%@/medical/getMedicalOrganList", kRequestUrlDomain];
    
    // 发送请求
    [HNAHttpTool getWithURL:urlStr params:param.keyValues success:^(id json) {
        if (success) {
            HNAGetHCOrganListResult *result = [HNAGetHCOrganListResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
/**
 *  预约体检
 *
 *  @param param   参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)reserveHCWithParam:(HNAReserveHCParam *)param success:(void (^)(HNAReserveHCResult *result))success failure:(void (^)(NSError *))failure{
    // 请求地址
    NSString *urlStr = [NSString stringWithFormat:@"%@/medical/reserveMedical", kRequestUrlDomain];
    
    // 发送请求
    [HNAHttpTool postWithURL:urlStr params:param.keyValues toDisk:NO success:^(id json) {
        if (success) {
            HNAReserveHCResult *result = [HNAReserveHCResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
