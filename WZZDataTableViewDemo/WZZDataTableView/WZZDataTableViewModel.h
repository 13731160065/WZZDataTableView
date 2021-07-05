//
//  WZZDataTableViewModel.h
//  GoldenMan
//
//  Created by wyq_iMac on 2019/5/18.
//  Copyright © 2019 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WZZDataTableViewModel : NSObject

/// model别名，方便在外部通过tableview获取
@property (strong, nonatomic) NSString * cellNickName;

/**
 扩展字段，可以用来携带数据
 */
@property (strong, nonatomic) id extObj;

/**
 cell点击
 
 thisModel 本模型自己
 */
@property (strong, nonatomic) void(^onClick)(id thisModel);

/// 段头
@property (assign, nonatomic) BOOL isSectionHeader;

/// cell不复用名称
/// cell将会根据该名称进行复用，不同名称之间不会互相复用，方便不需要服用视图的逻辑处理。
/// 例如：banner类视图、segment类、绘图类视图等
@property (strong, nonatomic) NSString * noReuseName;

#pragma mark - 其他

/// 刷新tableView
/// 方便在cell中写刷新tableview逻辑
- (void)reloadTableView;

@end
