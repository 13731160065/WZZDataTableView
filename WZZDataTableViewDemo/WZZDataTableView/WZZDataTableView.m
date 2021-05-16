//
//  WZZDataTableView.m
//  GoldenMan
//
//  Created by wyq_iMac on 2019/5/18.
//  Copyright © 2019 王泽众. All rights reserved.
//

#import "WZZDataTableView.h"

@interface WZZDataTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray <WZZDataTableViewModel *>* dataArrf;

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
}

- (void)registerCell:(Class)cellClass model:(Class)modelClass {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(modelClass)];
}

- (void)registerCodeCell:(Class)cellClass model:(Class)modelClass {
    [self.tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(modelClass)];
}

- (void)reloadData:(NSArray<WZZDataTableViewModel *> *)dataArr {
    [self setDataArr:dataArr];
    [self.tableView reloadData];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)setDataArr:(NSArray<WZZDataTableViewModel *> *)dataArr {
    self.dataArrf = [NSMutableArray arrayWithArray:dataArr];
}

#pragma mark - tableview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrf.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WZZDataTableViewModel * model = self.dataArrf[indexPath.row];
    WZZDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(model.class)];
    
    [cell cellWithModel:model];
    [cell layoutIfNeeded];
    
    if (self.cellForRowAtIndexPath) {
        UITableViewCell * cell2 = self.cellForRowAtIndexPath(tableView, cell, indexPath);
        if (cell2) {
            return cell2;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WZZDataTableViewModel * model = self.dataArrf[indexPath.row];
    if (model.onClick) {
        model.onClick(model);
    }
}

@end
