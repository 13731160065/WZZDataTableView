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

@end

