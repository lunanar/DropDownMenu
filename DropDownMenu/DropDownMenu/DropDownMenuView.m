//
//  DropDownMenuView.m
//  DropDownMenu
//
//  Created by Lunar on 16/10/24.
//  Copyright © 2016年 Lunar. All rights reserved.
//

#import "DropDownMenuView.h"
#import "UIColor+FlatUI.h"

#define cellTextFont 11.f
#define cellTextColor [UIColor blackColor]
#define dropBtnBorderColor [UIColor colorFromHexCode:@"f1f2f3"].CGColor
#define dropBtnTextColor [UIColor blackColor]
#define dropBtnTextFont 14.f

#define ViewHeight self.frame.size.height       //self的高
#define ViewWidth self.frame.size.width         //self的宽

#define AnimateTime 0.25f   // 下拉动画时间


@implementation DropDownMenuView {
    CGFloat _rowHeight;                //cell行高
    NSArray *_dataArr;                //数据源
    UITableView *_dropTableView;
    UIImageView *_arrowImgView;        //菜单栏的箭头
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initDropBtnFrame:frame];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self initDropBtnFrame:frame];
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        //cell的定制
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:cellTextFont];
        cell.textLabel.textColor = cellTextColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [_dropBtn setTitle:cell.textLabel.text forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenu:selectedCellNumber:)]) {
        [self.delegate dropdownMenu:self selectedCellNumber:indexPath.row];
    }
    
    [self hideDropTableView];
}

#pragma mark - PrivateFun
- (void)initDropBtnFrame:(CGRect)frame {
    //菜单按钮的定制
    [_dropBtn removeFromSuperview];    //不知道为啥会有一个1000＊1000的dropbtn在,所以要将之前那个移除
    _dropBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dropBtn setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [_dropBtn setTitleColor:dropBtnTextColor forState:UIControlStateNormal];
    [_dropBtn setTitle:@"choose" forState:UIControlStateNormal];              
    [_dropBtn addTarget:self action:@selector(dropBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _dropBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _dropBtn.titleLabel.font    = [UIFont systemFontOfSize:dropBtnTextFont];
    _dropBtn.titleEdgeInsets    = UIEdgeInsetsMake(0, 15, 0, 0);
    _dropBtn.selected           = NO;
    _dropBtn.backgroundColor    = [UIColor whiteColor];
    _dropBtn.layer.borderColor  = dropBtnBorderColor;
    _dropBtn.layer.borderWidth  = 1;
    [_dropBtn.layer setMasksToBounds:YES];
    [_dropBtn.layer setCornerRadius:5.f];
    [self addSubview:_dropBtn];
    
    //箭头
    _arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-25, 0, 20, 20)];
    _arrowImgView.center = CGPointMake(_arrowImgView.center.x, _dropBtn.center.y);
    [_arrowImgView setImage:[UIImage imageNamed:@"arrowDown"]];
    [_dropBtn addSubview:_arrowImgView];
}

- (void)setDropMenuTitle:(NSString *)titleStr withDataArr:(NSArray *)dataArr withRowHeight:(CGFloat)rowHeight {
    [_dropBtn setTitle:titleStr forState:UIControlStateNormal];
    _dataArr = [NSArray arrayWithArray:dataArr];
    _rowHeight = rowHeight;
    
    _dropTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+ViewHeight, ViewWidth, 0)];
    _dropTableView.delegate = self;
    _dropTableView.dataSource = self;
    _dropTableView.backgroundColor = [UIColor redColor];
}

- (void)dropBtnClicked:(UIButton *)btn{
    [self.superview addSubview:_dropTableView];
    if (btn.selected == NO) {
        [self showDropTableView];
    }else {
        [self hideDropTableView];
    }
}

//显示下拉的tableview
- (void)showDropTableView {
    [_dropTableView.superview bringSubviewToFront:_dropTableView];
    //箭头旋转的动画
    [UIView animateWithDuration:AnimateTime animations:^{
        _arrowImgView.transform = CGAffineTransformMakeRotation(M_PI);
        _dropTableView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+_dropBtn.frame.size.height, ViewWidth, _rowHeight * [_dataArr count]);
    }completion:^(BOOL finished){
        
    }];
    _dropBtn.selected = YES;
}

//隐藏
- (void)hideDropTableView {
    [UIView animateWithDuration:AnimateTime animations:^{
        _arrowImgView.transform = CGAffineTransformIdentity;
        _dropTableView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+_dropBtn.frame.size.height, ViewWidth,0);
        
    }completion:^(BOOL finished) {
        
    }];
    _dropBtn.selected = NO;
}

@end
