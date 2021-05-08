//
//  TestCell.m
//  WZZDataTableViewDemo
//
//  Created by wyq_iMac on 2021/5/8.
//

#import "TestCell.h"

@interface TestCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *ageL;
@property (weak, nonatomic) IBOutlet UILabel *detailL;

@end

@implementation TestCell

- (void)cellWithModel:(TestModel *)model {
    [super cellWithModel:model];
    self.backgroundColor = [UIColor clearColor];
    self.nameL.text = model.name;
    self.ageL.text = model.age;
    self.detailL.text = model.detail;
}

@end
