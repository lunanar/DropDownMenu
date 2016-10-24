//
//  MainViewController.m
//  DropDownMenu
//
//  Created by Lunar on 16/10/24.
//  Copyright © 2016年 Lunar. All rights reserved.
//

#import "MainViewController.h"
#import "DropDownMenuView.h"

@interface MainViewController ()<DropDownMenuViewDelegate>

@property (weak, nonatomic) IBOutlet DropDownMenuView *ageDropDownMenu;
@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSArray arrayWithObjects:
                   @"15岁以下",
                   @"16-18岁",
                   @"19-23岁",
                   @"24-29岁",
                   @"30岁以上",
                   nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    self.ageDropDownMenu.delegate = self;
    [self.ageDropDownMenu setFrame:self.ageDropDownMenu.frame];
    [self.ageDropDownMenu setDropMenuTitle:@"请选择年龄" withDataArr:self.dataArr withRowHeight:30];
}

#pragma mark - DropDownMenuViewDelegate 
- (void)dropdownMenu:(DropDownMenuView *)menu selectedCellNumber:(NSInteger)number {
    NSLog(@"choose:%@",self.dataArr[number]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - getter && setter
- (NSArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [[NSArray alloc] init];
    }
    return _dataArr;
}


@end
