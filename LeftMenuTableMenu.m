//
//  LeftMenuTableMenu.m
//  LeftMenu
//
//  Created by mac1 on 16/7/17.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import "LeftMenuTableMenu.h"
#import "LeftMenuViewController.h"
#import "LeftMenuModel.h"

@interface LeftMenuTableMenu ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSArray *menus;

@end

@implementation LeftMenuTableMenu


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    self.dataSource = self;
    
    self.delegate = self;
    
}


#pragma mark - 懒加载数据
- (NSArray *) leftMenus {
    
    if (!_menus) {
        _menus = [LeftMenuModel menuModel];
    }
    return _menus;
}

#pragma mark ---delegate
- (NSInteger) numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.leftMenus.count;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    LeftMenuModel *menus = self.leftMenus[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    /**
     UITableViewCellAccessoryNone,                                                      // don't show any accessory view
     UITableViewCellAccessoryDisclosureIndicator,                                       // regular chevron. doesn't track
     UITableViewCellAccessoryDetailDisclosureButton __TVOS_PROHIBITED,                 // info button w/ chevron. tracks
     UITableViewCellAccessoryCheckmark,                                                 // checkmark. doesn't track
     UITableViewCellAccessoryDetailButton NS_ENUM_AVAILABLE_IOS(7_0)  __TVOS_PROHIBITED // info button. tracks
     */
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    //点击cell没有选中效果
    //    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    cell.textLabel.text = menus.text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //点击时有效果，返回时选中效果消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"push" object:indexPath];
    
}

@end
