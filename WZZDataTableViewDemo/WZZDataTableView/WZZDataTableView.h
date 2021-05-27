//
//  WZZDataTableView.h
//  GoldenMan
//
//  Created by wyq_iMac on 2019/5/18.
//  Copyright © 2019 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZZDataTableViewModel.h"
#import "WZZDataTableViewCell.h"

@interface WZZDataTableView : UIView

@property (strong, nonatomic) UITableView * tableView;

/// 设置tableView代理
@property (nonatomic, weak) id<UITableViewDelegate> delegate;

/// 设置tableView数据源
@property (nonatomic, weak) id<UITableViewDataSource> dataSource;

/**
 注册cell
 
 通用注册方法，可以注册xib和纯代码创建的cell

 也可以不注册，类名按以下规则，tableview即可自动找到对应的cell完成注册
 xxxxxModel
 xxxxxCell
 
 @param cellClass cell
 @param modelClass 模型
 */
- (void)registerCell:(Class)cellClass
               model:(Class)modelClass;

/**
 注册cell
 
 @param cellClass cell
 @param modelClass 模型
 */
- (void)registerCodeCell:(Class)cellClass
                   model:(Class)modelClass;

/**
 刷新数据
 */
- (void)reloadData;

/// 刷新数据
/// @param dataArr 数据数组
- (void)reloadData:(NSArray<WZZDataTableViewModel *> *)dataArr;

/**
 设置数据
 
 @param dataArr 数据数组
 */
- (void)setDataArr:(NSArray <WZZDataTableViewModel *>*)dataArr;

@end
