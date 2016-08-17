//
//  PhoneViewController.m
//  LeftMenu
//
//  Created by mac1 on 16/7/17.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import "PhoneViewController.h"
#import "LeftMenuViewController.h"

@interface PhoneViewController ()

@end

//定义屏幕的宽度和高度
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:0.0/255
                                                green:85.0/255
                                                 blue:100.0/255
                                                alpha:0.618];
   
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(130, 200, 150, 50);
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

}

#pragma mark - 点击事件的响应
- (void) backAction {
    //1.初始化
    LeftMenuViewController *_MenuVC = [[LeftMenuViewController alloc] init];
    //2. 设置弹窗模式
    _MenuVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    //3. 关闭模态视图
    [self dismissViewControllerAnimated:_MenuVC completion:nil];
}



@end
