//
//  WZZDataTableViewUnionModel.m
//  WZZDataTableViewDemo
//
//  Created by wyq_iMac on 2021/7/6.
//

#import "WZZDataTableViewUnionModel.h"

@implementation WZZDataTableViewUnionModel

/// 初始化模型
/// @param config 配置
- (void)setupWithSubModelsConfig:(void(^)(WZZDataTableViewUnionModel *thisModel, NSMutableArray * subModelsArr))config {
    self.subModels = [NSMutableArray array];
    if (config) {
        config(self, self.subModels);
    }
}

@end
