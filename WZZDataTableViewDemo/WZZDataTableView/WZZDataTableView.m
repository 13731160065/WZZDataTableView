//
//  WZZDataTableView.m
//  GoldenMan
//
//  Created by wyq_iMac on 2019/5/18.
//  Copyright © 2019 王泽众. All rights reserved.
//

#import "WZZDataTableView.h"
#import <objc/runtime.h>

@interface WZZDataTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray <WZZDataTableViewModel *>* dataArrf;
@property (strong, nonatomic) NSMutableArray <NSMutableDictionary *>* sectionDataArr;

@end

@implementation WZZDataTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setup {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor clearColor];
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    
    self.tableView.estimatedRowHeight = 44;
}

- (void)registerCell:(Class)cellClass model:(Class)modelClass {
    UINib * nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
    if (nib) {
        [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass(modelClass)];
    } else {
        [self registerCodeCell:cellClass model:modelClass];
    }
}

- (void)registerCodeCell:(Class)cellClass model:(Class)modelClass {
    [self.tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(modelClass)];
}

- (void)reloadData:(NSArray<WZZDataTableViewModel *> *)dataArr {
    [self setDataArr:dataArr];
    [self reloadData];
}

- (void)reloadData {
    __weak WZZDataTableView * weakSelf = self;
    self.sectionDataArr = [NSMutableArray array];
    NSMutableArray * currentArr;
    for (int i = 0; i < self.dataArrf.count; i++) {
        WZZDataTableViewModel * item = self.dataArrf[i];
        objc_setAssociatedObject(item, "WZZInputBindingCell_reloadTableViewBlock", ^{
            [weakSelf reloadData];
        }, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        if (item.isSectionHeader) {
            NSMutableDictionary * hh = [NSMutableDictionary dictionary];
            hh[@"header"] = item;
            currentArr = [NSMutableArray array];
            hh[@"dataArr"] = currentArr;
            [self.sectionDataArr addObject:hh];
            continue;
        } else {
            if (i == 0) {
                NSMutableDictionary * hh = [NSMutableDictionary dictionary];
                currentArr = [NSMutableArray array];
                hh[@"dataArr"] = currentArr;
                [self.sectionDataArr addObject:hh];
            }
        }
        
        [currentArr addObject:item];
    }
    [self.tableView reloadData];
}

- (void)setDataArr:(NSArray<WZZDataTableViewModel *> *)dataArr {
    self.dataArrf = [NSMutableArray arrayWithArray:dataArr];
    
    //注册cell
    for (WZZDataTableViewModel * model in dataArr) {
        WZZDataTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass(model.class)];
        if (!cell) {
            //未注册
            NSString * string = NSStringFromClass(model.class);
            if (string) {
                NSRegularExpression * reg = [NSRegularExpression regularExpressionWithPattern:@"(.*)Model$" options:NSRegularExpressionCaseInsensitive error:nil];
                //正则检索
                NSTextCheckingResult * res = [reg firstMatchInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
                NSRange range = [res rangeAtIndex:1];
                @try {
                    NSString * nameStr = [string substringWithRange:range];
                    NSString * cellStr = [NSString stringWithFormat:@"%@Cell", nameStr];
                    Class cellClass = NSClassFromString(cellStr);
                    [self registerCell:cellClass model:model.class];
                } @catch (NSException *exception) {
                    
                }
            }
        }
    }
}

#pragma mark - tableview代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numm = 1;
    if (self.sectionDataArr.count == 0) {
        NSArray * aaa = self.sectionDataArr.firstObject[@"dataArr"];
        if (aaa.count == 0) {
            numm = 0;
        }
    }
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        [self.dataSource numberOfSectionsInTableView:tableView];
    }
    return self.sectionDataArr.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    WZZDataTableViewModel * model = self.sectionDataArr[section][@"header"];
//    if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
//        [self.delegate tableView:tableView heightForHeaderInSection:section];
//    }
//    return model.sectionHeaderHeight;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WZZDataTableViewModel * model = self.sectionDataArr[section][@"header"];
    WZZDataTableViewCell * cell;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(model.class)];
    [cell cellWithModel:model];
    
    if ([self.dataSource respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        [self.delegate tableView:tableView viewForHeaderInSection:section];
    }

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray * subArr = self.sectionDataArr[section][@"dataArr"];
    if ([self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        [self.dataSource tableView:tableView numberOfRowsInSection:section];
    }
    return subArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray * subArr = self.sectionDataArr[indexPath.section][@"dataArr"];
    WZZDataTableViewModel * model = subArr[indexPath.row];
    
    NSString * cid = NSStringFromClass(model.class);
    
    
    if (model.noReuseName) {
        [cid stringByAppendingFormat:@"%@", model.noReuseName];
    }
    WZZDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cid];
    
    [cell cellWithModel:model];
    [cell layoutIfNeeded];
    
    if ([self.dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        UITableViewCell * cell2 = [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell2;
    }
    
    if (!cell) {
        NSAssert(NO, @"cell为空");
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = -1;
    if ([self.delegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
        height = [self.delegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    return (height >= 0)?height:44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray * subArr = self.sectionDataArr[indexPath.section][@"dataArr"];
    WZZDataTableViewModel * model = subArr[indexPath.row];
    if (model.onClick) {
        model.onClick(model);
    }
}

@end
