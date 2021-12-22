//
//  TestContentCell.m
//  WZZDataTableViewDemo
//
//  Created by 王泽众 on 2021/7/7.
//

#import "TestContentCell.h"

@interface TestContentCell()

@property (strong, nonatomic) NSString * name;

@end

@implementation TestContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)cellWithModel:(WZZDataTableViewModel *)model {
    [super cellWithModel:model];
}

@end

@implementation TestContentModel

@end
