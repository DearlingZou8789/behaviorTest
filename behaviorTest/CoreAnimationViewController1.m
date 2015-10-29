//
//  CoreAnimationViewController1.m
//  behaviorTest
//
//  Created by Damon on 15/10/29.
//  Copyright © 2015年 zhangle.in.iMac. All rights reserved.
//

#import "CoreAnimationViewController1.h"

@interface CoreAnimationViewController1 ()
{
    UIView *planeView;
}
@end

@implementation CoreAnimationViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    planeView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 60, 30)];
    planeView.layer.opacity = 0.25;
    planeView.layer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view addSubview:planeView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击飞机飞了" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 500, 200, 40);
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick:(UIButton *)btn
{
//    [self animation1];
    [self animation2];
}

- (void)animation1
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 3.0;
    animation.fromValue = @.25;
    animation.toValue = @1.0;
    animation.cumulative = YES;
    animation.repeatCount = 2;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [planeView.layer addAnimation:animation forKey:@"animateOpacity"];
    
    CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(200, 500);
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    basicAnimation.duration = 6.0;
    basicAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeAffineTransform(moveTransform)];
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.repeatCount = 2;
    [planeView.layer addAnimation:basicAnimation forKey:@"animateTransform"];
}

- (void)animation2
{
    //关键帧动画效果
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 6.0;
    animation.values = @[@0.25, @0.75, @1.0];
    animation.keyTimes = @[@0.0, @0.5, @1.0];
    //设置动画结束时候状态,保持动画结束值
    animation.fillMode = kCAFillModeForwards;
    //设置动画结束时候不停止,必须先设置fillMode的属性
    animation.removedOnCompletion = NO;
    [planeView.layer addAnimation:animation forKey:@"animateOpacity"];
    
    CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(200, 500);
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    basicAnimation.duration = 6.0;
    basicAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeAffineTransform(moveTransform)];
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.repeatCount = 2;
    [planeView.layer addAnimation:basicAnimation forKey:@"animateTransform"];
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
