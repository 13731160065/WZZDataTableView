//
//  WZZDataTableViewModel.m
//  GoldenMan
//
//  Created by wyq_iMac on 2019/5/18.
//  Copyright © 2019 王泽众. All rights reserved.
//

#import "WZZDataTableViewModel.h"
#import <objc/runtime.h>

@implementation WZZDataTableViewModel

- (void)reloadTableView {
    void(^reloadTableViewBlock)(void) = objc_getAssociatedObject(self, "WZZInputBindingCell_reloadTableViewBlock");
    if (reloadTableViewBlock) {
        reloadTableViewBlock();
    }
}

@end
