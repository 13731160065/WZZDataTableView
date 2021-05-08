//
//  ViewController.m
//  WZZDataTableViewDemo
//
//  Created by wyq_iMac on 2021/5/8.
//

#import "ViewController.h"
#import "WZZDataTableView.h"
#import "TestCell.h"
#import "Test2Cell.h"
#import "WZZHolderCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet WZZDataTableView *mainTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mainTableView registerCell:[TestCell class] model:[TestModel class]];
    [self.mainTableView registerCell:[Test2Cell class] model:[Test2Model class]];
    [self.mainTableView registerCell:[WZZHolderCell class] model:[WZZHolderModel class]];
    
    [self loadData];
}

- (void)loadData {
    WZZHolderModel * h1 = [[WZZHolderModel alloc] init];
    h1.holderColor = [UIColor clearColor];
    h1.height = @(10);
    
    NSMutableArray * dataArr = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        Test2Model * t1 = [[Test2Model alloc] init];
        t1.aTitle = [NSString stringWithFormat:@"这个是标题%d", i];
        [dataArr addObject:t1];
        [dataArr addObject:h1];
        
        for (int j = 0; j < 10; j++) {
            TestModel * m1 = [[TestModel alloc] init];
            m1.name = [NSString stringWithFormat:@"姓名%d", j];
            m1.age = [NSString stringWithFormat:@"%d岁", j];
            m1.detail = arc4random()%2?@"我诶蚧佛额外i将否未婚夫iu未婚夫i无ehfuiwehfwieuhfiweuhfwieuhfiwuehf为UI回复i额u我回复为u富含维u凤凰网i额u和iu未婚夫为i额u符合iu未婚夫iu未婚夫":@"我诶蚧佛为i俄方将哦额和iu往何方";
            [dataArr addObject:m1];
        }
    }
    
    [self.mainTableView setDataArr:dataArr];
    [self.mainTableView reloadData];
}

@end
