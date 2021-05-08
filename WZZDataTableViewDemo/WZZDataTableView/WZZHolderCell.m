//
//  WZZHolderCell.m
//  GoldenMan
//
//  Created by wyq_iMac on 2019/5/18.
//  Copyright © 2019 王泽众. All rights reserved.
//

#import "WZZHolderCell.h"

@interface WZZHolderCell ()
@property (weak, nonatomic) IBOutlet UIView *holderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *holderHeight;

@end

@implementation WZZHolderCell

- (void)cellWithModel:(WZZHolderModel *)model {
    [super cellWithModel:model];
    if (model.height) {
        self.holderHeight.constant = model.height.doubleValue;
    } else {
        self.holderHeight.constant = 8;
    }
    if (model.holderColor) {
        self.holderView.backgroundColor = model.holderColor;
        self.backgroundColor = [UIColor clearColor];
    } else {
        self.holderView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
