//
//  WZZDataTableViewCell.m
//  GoldenMan
//
//  Created by wyq_iMac on 2019/5/18.
//  Copyright © 2019 王泽众. All rights reserved.
//

#import "WZZDataTableViewCell.h"
#import <objc/runtime.h>

@interface WZZDataTableViewCell ()<UITextFieldDelegate>

@property (nonatomic, weak) id<UITextFieldDelegate> tfDelegate;

@property (nonatomic, strong) UIButton * upButton;

@end

@implementation WZZDataTableViewCell

- (void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.upButton];
    self.upButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.upButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.upButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.upButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.upButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    [self.upButton addTarget:self action:@selector(upClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)upClick {
    if (self.model.onClick) {
        self.model.onClick(self.model);
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)cellWithModel:(WZZDataTableViewModel *)model {
    _model = model;
    if (model.isSectionHeader) {
        self.upButton.hidden = !model.onClick;
    } else {
        self.upButton.hidden = YES;
    }
}

#pragma mark - 绑定输入

- (void)bindingTextField:(UITextField *)textField
            modelKeyPath:(NSString *)modelKeyPath {
    if (![textField.allTargets containsObject:self]) {
        [textField addTarget:self action:@selector(endEditClick:) forControlEvents:UIControlEventEditingDidEnd];
    }
    objc_setAssociatedObject(textField, "WZZInputBindingCell_modelKeyPath", modelKeyPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)endEditClick:(UITextField *)tf {
        NSString * keyPath = objc_getAssociatedObject(tf, "WZZInputBindingCell_modelKeyPath");
        @try {
            [self.model setValue:tf.text forKeyPath:keyPath];
        } @catch (NSException *exception) {
            NSLog(@"设置%@.%@时失败:%@", NSStringFromClass([self.model class]), keyPath, exception);
        }
}

@end
