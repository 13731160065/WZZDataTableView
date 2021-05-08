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

/**
 cell复用，返回cell则覆盖原本的cell
 */
@property (strong, nonatomic) UITableViewCell *(^cellForRowAtIndexPath)(UITableView * tableView, UITableViewCell * cell, NSIndexPath * indexPath);

/**
 注册cell
 
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

/**
 设置数据
 
 @param dataArr 数据数组
 */
- (void)setDataArr:(NSArray <WZZDataTableViewModel *>*)dataArr;

@end
