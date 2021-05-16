//
//  WZZDataTableViewCell.h
//  GoldenMan
//
//  Created by wyq_iMac on 2019/5/18.
//  Copyright © 2019 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZZDataTableViewModel.h"

@interface WZZDataTableViewCell : UITableViewCell

/**
 模型
 */
@property (strong, nonatomic, readonly) WZZDataTableViewModel * model;

/**
 cell复用

 @param model 模型
 */
- (void)cellWithModel:(WZZDataTableViewModel *)model;

#pragma mark - 绑定输入

/// 绑定输入框，输入后同步到模型对应keyPath中
/// @param textField 输入框
/// @param modelKeyPath 模型keyPath
- (void)bindingTextField:(UITextField *)textField
            modelKeyPath:(NSString *)modelKeyPath;

/// 绑定输入框，输入后同步到模型对应keyPath中
/// @param textView 输入框
/// @param modelKeyPath 模型keyPath
- (void)bindingTextView:(UITextView *)textView
           modelKeyPath:(NSString *)modelKeyPath;

@end

