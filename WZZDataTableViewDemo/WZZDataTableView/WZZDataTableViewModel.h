//
//  WZZDataTableViewModel.h
//  GoldenMan
//
//  Created by wyq_iMac on 2019/5/18.
//  Copyright © 2019 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZZDataTableViewModel : NSObject

/**
 扩展字段，可以用来携带数据
 */
@property (strong, nonatomic) id extObj;

/**
 cell点击
 */
@property (strong, nonatomic) void(^onClick)(WZZDataTableViewModel * thisModel);

@end
