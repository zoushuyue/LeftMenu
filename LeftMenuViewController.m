//
//  LeftMenuViewController.m
//  LeftMenu
//
//  Created by mac1 on 16/7/17.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftMenuModel.h"
#import "LeftMenuTableMenu.h"
#import "MessageViewController.h"
#import "PhoneViewController.h"

@interface LeftMenuViewController () {
    //定义全局变量
    LeftMenuViewController *_MenuVC;
}
//左侧menu
@property (nonatomic, strong) LeftMenuTableMenu *menu;
//menu图片
@property (nonatomic, weak) UIImageView *image;
//触点位置
@property (nonatomic, assign) CGPoint touchPoint;
//点击视图
@property (nonatomic, weak) UIView *viewClick;
//分段控件
@property (nonatomic, strong) UISegmentedControl *segmentCon;

@end

//屏幕的高度和宽度
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

//menu的高度，判断menu是否为显示状态
#define MenuWidth self.menu.frame.size.width

//菜单的显示frame，宽度就是显示的尺寸
#define MenuFrame CGRectMake(0, 64, kScreenW / 4 * 3, kScreenH)

//菜单不显示的frame
#define MenusFrameAfter CGRectMake(0, 64, 0, kScreenH)

//背景图片在左侧菜单显示时的宽度（四分之一）
#define ImageFrame CGRectMake(kScreenW / 4 * 3, 0, kScreenW, kScreenH)

//背景图片在左侧菜单没有显示时的宽度（全屏）
#define Frame CGRectMake(0, 0, kScreenW, kScreenH)

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建顶部视图
    [self createTopView];
    }

#pragma mark - 创建顶部视图
- (void) createTopView {

    
    //添加背景图片
    UIImageView *image = [[UIImageView alloc] initWithFrame:Frame];
    
    image.image = [UIImage imageNamed:@"1"];
    
    self.image = image;
    [self.view addSubview:image];
    
    //2.创建左侧menu按钮
    UIBarButtonItem *letfBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-icon"]
                                                                style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(leftMenuAction)];
    self.navigationItem.leftBarButtonItem = letfBar;
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor blueColor]];
    
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(action:)
                                                 name:@"push" object:nil];
    //添加左侧菜单视图
    [self addLeftMenu];
    
    //添加手势
    [self addSwipeGestureRecognizer];
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //点击时从父视图上移除
    [self.viewClick removeFromSuperview];
    
    //背景图片不显示时的frame
    self.image.frame = Frame;
    //菜单不显示时的frame
    self.menu.frame = MenusFrameAfter;
}

#pragma mark -通知实现
- (void) action:(NSNotification *) action {
    
    NSIndexPath *index = [action object];
    
    NSLog(@"%ld个cell", index.row);
    
    LeftMenuViewController *menuVC = [LeftMenuViewController new];
    
    menuVC.title = [NSString stringWithFormat:@"第%ld个cell", index.row];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [self.navigationController pushViewController:menuVC animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}


#pragma mark ---移除通知
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 左侧菜单视图
- (void) addLeftMenu {
    
    
    LeftMenuTableMenu *menu = [[LeftMenuTableMenu alloc] initWithFrame:MenusFrameAfter];
    
    self.menu = menu;
    
    self.menu.scrollEnabled = NO;
    
    self.menu.tableFooterView = [UIView new];
    
    [self.view addSubview:self.menu];
}

#pragma mark -手势
- (void) addSwipeGestureRecognizer {
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popUpLeftMenu)];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(returnLeftMenu)];
    
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipe];
    [self.view addGestureRecognizer:swipeLeft];
}




#pragma mark -左侧菜单按钮点击事件响应
- (void)leftMenuAction {
    
    if (MenuWidth == 0 || self.menu == nil) {
        
        [UIView animateWithDuration:0.25 animations:^{
        
            [self tapGesture];
            
            self.menu.frame = MenuFrame;
            
            self.image.frame = ImageFrame;
            
        }];
        
    }else {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.viewClick removeFromSuperview];
            
            self.menu.frame = MenusFrameAfter;
            
            self.image.frame = Frame;
            
        }];
        
        
    }
}

#pragma mark --- 添加点击空白手势方法
- (void) tapGesture {

    UITapGestureRecognizer *tapGesture  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView)];
   
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kScreenH / 4 * 3, 0, kScreenW, kScreenH)];
    
    view.backgroundColor = [UIColor clearColor];
    
    [view addGestureRecognizer:tapGesture];
    
    [self.view addSubview:view];
    
    self.viewClick = view;
}

#pragma mark --- 右滑手势方法
- (void) popUpLeftMenu {
    
    if (MenuWidth == 0) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self tapGesture];
            
            self.menu.frame = MenuFrame;
            
            self.image.frame = ImageFrame;
            
        }];
    }else {
        
        return;
        
    }
}


#pragma mark --- 左滑手势方法
- (void) returnLeftMenu {
    
    if (MenuWidth != 0) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self tapGesture];
            
            self.menu.frame = MenuFrame;
            
            self.image.frame = ImageFrame;
            
        }];
    }else {
        
        return;
        
    }
}

#pragma mark ---获取点击坐标
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:[touch view]];
    
    self.touchPoint = touchPoint;
}

#pragma mark ---点击空白执行
- (void) clickView {
    
    if (self.touchPoint.x < kScreenW / 4 * 3) {
        
        [self.viewClick removeFromSuperview];
        
        [self returnLeftMenu];
        
        self.image.frame = Frame;
    } else {
        return;
    }
}


@end
