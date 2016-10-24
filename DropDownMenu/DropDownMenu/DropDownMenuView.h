//
//  DropDownMenuView.h
//  DropDownMenu
//
//  Created by Lunar on 16/10/24.
//  Copyright © 2016年 Lunar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropDownMenuView;

@protocol DropDownMenuViewDelegate <NSObject>

@optional

- (void)dropdownMenu:(DropDownMenuView *)menu selectedCellNumber:(NSInteger)number; // 当选择某个选项时调用

@end

@interface DropDownMenuView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) id <DropDownMenuViewDelegate> delegate;

//下拉菜单的按钮
@property (nonatomic,strong) UIButton *dropBtn;

- (void)setDropMenuTitle:(NSString *)titleStr withDataArr:(NSArray *)dataArr withRowHeight:(CGFloat)rowHeight;

@end
