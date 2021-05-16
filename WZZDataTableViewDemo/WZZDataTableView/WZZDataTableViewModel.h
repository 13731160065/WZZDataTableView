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

/**
 扩展字段，可以用来携带数据
 */
@property (strong, nonatomic) id extObj;

/**
 cell点击
 
 thisModel 本模型自己
 */
@property (strong, nonatomic) void(^onClick)(id thisModel);

#pragma mark - 段头
/// 段头
@property (assign, nonatomic) BOOL isSectionHeader;

/// 段头高度
@property (assign, nonatomic) CGFloat sectionHeaderHeight;

/// 段头是否复用
@property (assign, nonatomic) BOOL sectionHeaderReuse;

/// cell是否复用
@property (assign, nonatomic) BOOL cellNoReuse;

@end
