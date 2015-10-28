//
//  DynamicViewController.m
//  behaviorTest
//
//  Created by Damon on 15/10/27.
//  Copyright © 2015年 zhangle.in.iMac. All rights reserved.
//

#import "DynamicViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface DynamicViewController ()

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *mountainView = [[UIView alloc] initWithFrame:CGRectMake(120, 30, 100, 130)];
    mountainView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:mountainView];
    
    UIView *treeView = [[UIView alloc] initWithFrame:CGRectMake(300, 70, 20, 70)];
    treeView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:treeView];
    
    UIView *cowBodyView = [[UIView alloc] initWithFrame:CGRectMake(150, 200, 40, 20)];
    cowBodyView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:cowBodyView];
    
    //设置山在X轴的偏移范围-50.0~50.0
    UIInterpolatingMotionEffect *effect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    effect.minimumRelativeValue = @-50.0;
    effect.maximumRelativeValue = @50.0;
    [mountainView addMotionEffect:effect];
    
    UIInterpolatingMotionEffect *effect1 = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    effect1.minimumRelativeValue = @-50.0;
    effect1.maximumRelativeValue = @50.0;
    [mountainView addMotionEffect:effect1];
    
    //设置树在X轴的偏移范围-100~100
    UIInterpolatingMotionEffect *effect2 = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    effect2.minimumRelativeValue = @-100;
    effect2.maximumRelativeValue = @100;
    [treeView addMotionEffect:effect2];
    UIInterpolatingMotionEffect *effect3 = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    effect3.minimumRelativeValue = @-100;
    effect3.maximumRelativeValue = @100;
    [treeView addMotionEffect:effect3];
    
    UIInterpolatingMotionEffect *effect4 = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    effect4.minimumRelativeValue = @-100;
    effect4.maximumRelativeValue = @100;
    [cowBodyView addMotionEffect:effect4];
    UIInterpolatingMotionEffect *effect5 = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    effect5.minimumRelativeValue = @-100;
    effect5.maximumRelativeValue = @100;
    [cowBodyView addMotionEffect:effect5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
