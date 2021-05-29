# WZZDataTableView
数据驱动tableview



## 快速开始

### 创建Model

1. 创建一个Model继承于WZZDataTableViewModel
2. 添加需要的属性

### 创建Cell

1. 创建一个Cell继承于WZZDataTableViewCell
2. 重写复用加载数据方法

```objective-c
- (void)cellWithModel:(WZZDataTableViewModel *)model {
  [super cellWithModel:model]//一定要调用父类的复用方法，否则在其他方法中self.model将获取不到
  //在此通过model的属性给cell进行赋值操作，此处的model即为数据源中对应的model子类实例
}
```

### 创建视图

1. 创建视图

- 纯代码创建视图

```objective-c
WZZDataTableView * mainTableView = [[WZZDataTableView alloc] init];
```

- xib创建视图

直接在xib中拖出一个`UIView`，将Class设置为`WZZDataTableView`即可。

*当然也可以拖出一个普通`UIView`来用纯代码的方式创建*

![img](https://raw.githubusercontent.com/13731160065/WZZDataTableView/main/Image/img0.png)

2. 注册cell

* 调用注册方法注册model对应的cell

```objective-c
[mainTableView registerCell:[TestCell class] model:[TestModel class]];
```

* 按照xxxCell、xxxModel格式命名的Cell和Model将会由table自动根据model查找对应的cell可以不注册

```objective-c
//例如这两个类，table在注册的cell中查找不到时将会自动根据“Test”关联两个类
@interface TestModel : WZZDataTableViewModel
@end

@interface TestCell : WZZDataTableViewCell
@end
```

3. 设置数据源并刷新

```objective-c
NSMutableArray * dataArr = [NSMutableArray array];
for (int i = 0; i < 10; i++) {
    TestModel * model = [[TestModel alloc] init];
    [dataArr addObject:dataArr];
}
[mainTableView reloadData:dataArr];
```

完成，祝贺你已经掌握了最基本的操作🎉

### 所有代码展示

TestModel.h

```objective-c
#import "WZZDataTableViewModel.h"

@interface TestModel : WZZDataTableViewModel
  
@property (strong, nonatomic) NSString * name;//假设有一个名称属性

@end
```

TestModel.m

```objective-c
#import "TestModel.h"

@implementation TestModel
  
@end
```

TestCell.h

```objective-c
#import "WZZDataTableViewCell.h"
#import "TestModel.h"

@interface TestCell : WZZDataTableViewCell
  
@end
```

TestCell.m

```objective-c
@interface TestCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//假设cell中有一个名称label

@end

@implementation TestCell

- (void)cellWithModel:(TestModel *)model {
    [super cellWithModel:model];
    self.nameLabel.text = model.name;//将model中的属性赋值到cell控件中
}

@end
```

ViewController.m

```objective-c
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  	//注册cell
    [self.mainTableView registerCell:[TestCell class] model:[TestModel class]];//此处如果遵循xxxCell、xxxModel格式创建类可以不需要注册
    
  	//创建数据
  	for (int i = 0; i < 10; i++) {
        TestModel * model = [[TestModel alloc] init];
        m1.name = @"姓名";
        [dataArr addObject:model];
        m1.onClick = ^(TestModel * thisModel) {
            NSLog(@"“%@”被点击啦", thisModel.name);
        };
    }
  
  	//刷新数据源
    [self.mainTableView reloadData:dataArr];
}

@end
```

## 学习更多

* `WZZDataTableViewModel`类属性`onClick`是一个点击事件回调，当触发cell点击事件的时候会调用该回调响应给开发者。

* `WZZDataTableViewModel`类属性`extObj`是一个预留属性，开发者可以让该model携带任何数据。

* `WZZDataTableViewModel`类属性`isSectionHeader`设置为`YES`时这个cell将被作为tableView的tableHeaderView，而且需要设置`sectionHeaderHeight`头部高度。该段头有头部保留效果。`sectionHeaderReuse`默认为`NO`不复用。

* `WZZDataTableViewModel`类属性`cellNoReuse`设置为`YES`时cell将不复用，每一个model单独创建一个cell，可以用来处理特殊的视图。

* 输入框可以使用cell的绑定方法，将输入框和model的某个属性绑定，绑定后输入框结束编辑方法调用时会将输入框的`text`赋值给model的对应属性。

  ```objective-c
  /// 绑定输入框，输入后同步到模型对应keyPath中
  /// @param textField 输入框
  /// @param modelKeyPath 模型keyPath
  - (void)bindingTextField:(UITextField *)textField
              modelKeyPath:(NSString *)modelKeyPath;
  ```

* 本仓库中自带一个`WZZHolderCell`和`WZZHolderModel`，用于填充设置空白高度

