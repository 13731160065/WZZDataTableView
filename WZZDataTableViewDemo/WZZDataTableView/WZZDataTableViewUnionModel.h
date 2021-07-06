//
//  WZZDataTableViewUnionModel.h
//  WZZDataTableViewDemo
//
//  Created by wyq_iMac on 2021/7/6.
//

#import <Foundation/Foundation.h>
#import "WZZDataTableViewModel.h"

@interface WZZDataTableViewUnionModel : WZZDataTableViewModel

@property (strong, nonatomic) NSMutableArray * subModels;

/// 初始化模型
/// @param config 配置
- (void)setupWithSubModelsConfig:(void(^)(WZZDataTableViewUnionModel *thisModel, NSMutableArray * subModelsArr))config;

@end

