//
//  Test2Cell.m
//  WZZDataTableViewDemo
//
//  Created by wyq_iMac on 2021/5/8.
//

#import "Test2Cell.h"

@interface Test2Cell ()

@property (weak, nonatomic) IBOutlet UILabel *aTitleL;

@end

@implementation Test2Cell

- (void)cellWithModel:(Test2Model *)model {
    [super cellWithModel:model];
    
    self.backgroundColor = [UIColor clearColor];
    self.aTitleL.text = model.aTitle;
}

@end
