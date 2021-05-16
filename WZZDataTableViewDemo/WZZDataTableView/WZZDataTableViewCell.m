//
//  WZZDataTableViewCell.m
//  GoldenMan
//
//  Created by wyq_iMac on 2019/5/18.
//  Copyright © 2019 王泽众. All rights reserved.
//

#import "WZZDataTableViewCell.h"
#import <objc/runtime.h>

@interface WZZDataTableViewCell ()<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, weak) id<UITextFieldDelegate> tfDelegate;
@property (nonatomic, weak) id<UITextViewDelegate> tvDelegate;

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
    self.upButton.hidden = !model.onClick;
}

#pragma mark - 绑定输入

- (void)bindingTextField:(UITextField *)textField
            modelKeyPath:(NSString *)modelKeyPath {
    self.tfDelegate = textField.delegate;
    textField.delegate = self;
    objc_setAssociatedObject(textField, "WZZInputBindingCell_modelKeyPath", modelKeyPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)bindingTextView:(UITextView *)textView
           modelKeyPath:(NSString *)modelKeyPath {
    self.tvDelegate = textView.delegate;
    textView.delegate = self;
    objc_setAssociatedObject(textView, "WZZInputBindingCell_modelKeyPath", modelKeyPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - tf代理

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.tfDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.tfDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.tfDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.tfDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.tfDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.tfDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.tfDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.tfDelegate textFieldDidEndEditing:textField];
    }
    NSString * keyPath = objc_getAssociatedObject(textField, "WZZInputBindingCell_modelKeyPath");
    @try {
        [self.model setValue:textField.text forKeyPath:keyPath];
    } @catch (NSException *exception) {
        NSLog(@"设置%@.%@时失败:%@", NSStringFromClass([self.model class]), keyPath, exception);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([self.tfDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.tfDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([self.tfDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.tfDelegate textFieldShouldClear:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.tfDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.tfDelegate textFieldShouldReturn:textField];
    }
    return YES;
}

#pragma mark - tv代理

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.tvDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.tvDelegate textViewShouldBeginEditing:textView];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([self.tvDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.tvDelegate textViewShouldEndEditing:textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([self.tvDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.tvDelegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.tvDelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.tvDelegate textViewDidEndEditing:textView];
    }
    NSString * keyPath = objc_getAssociatedObject(textView, "WZZInputBindingCell_modelKeyPath");
    @try {
        [self.model setValue:textView.text forKeyPath:keyPath];
    } @catch (NSException *exception) {
        NSLog(@"设置%@.%@时失败:%@", NSStringFromClass([self.model class]), keyPath, exception);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([self.tvDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [self.tvDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([self.tvDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.tvDelegate textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if ([self.tvDelegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [self.tvDelegate textViewDidChangeSelection:textView];
    }
}


@end
