//
//  ViewController.m
//  个人首页
//
//  Created by Yahui on 15/7/31.
//  Copyright (c) 2015年 Yahui. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extension.h"
#define headerH 200
#define tabH    44
#define navH    64


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *tabView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerConH;

@property (assign,nonatomic)CGFloat lastOffsetY;

@end

@implementation ViewController

static NSString *ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastOffsetY = - (headerH + tabH);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    // 给导航条的背景图片传递一个空图片的UIImage对象
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 隐藏底部阴影条，传递一个空图片的UIImage对象
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.titleBtn.alpha = 0.0;
    
    self.icon.layer.cornerRadius = self.icon.bounds.size.width * 0.5;
    
    UIEdgeInsets inset = UIEdgeInsetsMake(headerH + tabH , 0, 0, 0);
    self.tableView.contentInset = inset;
    
   
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat det =  offsetY - self.lastOffsetY;
    NSLog(@"det %@",@(det));
    
    CGFloat headerNewH = headerH - det;
    if (headerNewH < navH) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        headerNewH = navH;
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    self.headerConH.constant = headerNewH;
    CGFloat alpha = 0;
    if (det > 0) {
        alpha =  det /  (headerH - navH);
        if (alpha >= 1) {
            alpha = 0.99;
        }
    }
    self.titleBtn.alpha = alpha ;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]] forBarMetrics:UIBarMetricsDefault];
    NSLog(@"%@",@(alpha));
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"cell %@",@(indexPath.row)];

    return cell;
}



@end
