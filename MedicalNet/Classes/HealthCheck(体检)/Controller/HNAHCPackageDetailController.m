//
//  HNAHCPackageDetailController.m
//  MedicalNet
//
//  Created by gengliming on 15/11/30.
//  Copyright © 2015年 HaiHang. All rights reserved.
//

// 套餐详情

#import "HNAHCPackageDetailController.h"
#import "HNAHealthCheckTool.h"
#import "HNAUserTool.h"
#import "HNAUser.h"
#import "HNAGetPackageDetailParam.h"
#import "HNAGetPackageDetailResult.h"
#import "MBProgressHUD+MJ.h"

@interface HNAHCPackageDetailController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  套餐名称
 */
@property (weak, nonatomic) IBOutlet UILabel *packageNameLabel;
/**
 *  “选择此套餐按钮” 父视图
 */
@property (weak, nonatomic) IBOutlet UIView *selectBtnContainer;
/**
 *  记录 数据
 */
@property (strong, nonatomic) NSMutableArray<HNAPackageDetailItem *> *records;
/**
 *  选择此套餐
 */
- (IBAction)selectThePackage:(UIButton *)sender;

@end

@implementation HNAHCPackageDetailController

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    // 如果只是展示，则隐藏“选择此套餐”按钮
    if (self.type == HNAHCPackageDetailControllerDisplay) {
        self.selectBtnContainer.hidden = YES;
    }
}

#pragma mark - Custom Accessors
- (NSMutableArray<HNAPackageDetailItem *> *)records{
    if (_records == nil) {
        _records = [NSMutableArray array];
    }
    return _records;
}

#pragma mark - Private
- (void)loadData{
    // 提示
    [MBProgressHUD showMessage: kMessageWhenLoadingData];
    
    // 参数
    HNAGetPackageDetailParam *param = [[HNAGetPackageDetailParam alloc] init];
    param.id = self.packageId;
    
    // 请求数据
    WEAKSELF(weakSelf);
    [HNAHealthCheckTool getPackgetDetailWithParam:param success:^(HNAGetPackageDetailResult *result) {
        [MBProgressHUD hideHUD];
        if (result.success==HNARequestResultSUCCESS) {
            weakSelf.packageNameLabel.text = result.packageName;
            weakSelf.records = result.records;
            // 刷新tableView
            [weakSelf.tableView reloadData];
        } else {
            weakSelf.packageNameLabel.text = @"";
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError: kMessageWhenNoData];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        
        for (NSInteger i = 0; i < 10; i++) {
            HNAPackageDetailItem *item = [[HNAPackageDetailItem alloc] init];
            item.item = @"项目";
            item.desc = @"13114314314311";
            [weakSelf.records addObject:item];
        }
        weakSelf.packageNameLabel.text = @"套餐A";
        [weakSelf.tableView reloadData];
        
        [MBProgressHUD showError: kMessageWhenFaild];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"packageDetailCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    HNAPackageDetailItem *item = self.records[indexPath.row];
    cell.textLabel.text = item.item;
    cell.detailTextLabel.text = item.desc;
    
    return cell;
}

#pragma mark - IBActions
/**
 *  选择此套餐
 */
- (IBAction)selectThePackage:(UIButton *)sender {
    if (self.selectBlock) {
        self.selectBlock(self.packageId);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
