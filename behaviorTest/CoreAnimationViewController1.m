//
//  CoreAnimationViewController1.m
//  behaviorTest
//
//  Created by Damon on 15/10/29.
//  Copyright © 2015年 zhangle.in.iMac. All rights reserved.
//

#import "CoreAnimationViewController1.h"
#import "UIColor+AddColor.h"

#define angle2Radian(angle)  ((angle)/180.0*M_PI)
@interface CoreAnimationViewController1 ()
{
    UIView *planeView;
    UIView *ballView;
    UIButton *btn2;
    CAKeyframeAnimation *keyAnimator1;
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
    
    ballView = [[UIView alloc] initWithFrame:CGRectMake(200, 50, 50, 50)];
    ballView.center = CGPointMake(160.0f, 100.0f);
    ballView.layer.opacity = 0.5;
    ballView.layer.backgroundColor = [UIColor greenSeaColor].CGColor;
    ballView.layer.cornerRadius = ballView.bounds.size.width / 6;
    [self.view addSubview:ballView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击飞机飞了" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 500, 200, 40);
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"圆球翻滚吧!" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(100, 560, 200, 40);
    btn2.backgroundColor = [UIColor silverColor];
    [btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
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

#define animatorTime 10.0f
- (void)btn2Click:(UIButton *)btn
{
    btn2.alpha = 0.0f;
    
    CGMutablePathRef startPath = CGPathCreateMutable();
    CGPathMoveToPoint(startPath, NULL, 160.0f, 100.0f);
    CGPathAddLineToPoint(startPath, NULL, 100.0f, 280.0f);
    CGPathAddLineToPoint(startPath, NULL, 260.0f, 170.0f);
    CGPathAddLineToPoint(startPath, NULL, 60.0f, 170.0f);
    CGPathAddLineToPoint(startPath, NULL, 220.0f, 280.0f);
    CGPathCloseSubpath(startPath);
    
    keyAnimator1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimator1.duration = animatorTime;
    keyAnimator1.delegate = self;
    keyAnimator1.path = startPath;
    keyAnimator1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    CFRelease(startPath);
    startPath = nil;
    [ballView.layer addAnimation:keyAnimator1 forKey:@"position"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    keyAnimator1.delegate = nil;
    [self addRotateAnimator];
    [self addLargeOrSmall];
    [UIView animateWithDuration:1.0f animations:^{
        btn2.alpha = 1.0f;
    }];
}

#define repeatCounts 2
/**
 *  添加抖动效果
 */
- (void)addRotateAnimator
{
    //添加抖动动画,对应layer的属性为transform.rotation
    CAKeyframeAnimation *key2 = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    //持续动画效果
    key2.duration = 0.8f;
    //设置图标抖动弧度
    //把度数转换弧度 度数/180*M_PI
    key2.values = @[@(angle2Radian(0)), @(angle2Radian(10)), @(angle2Radian(0)), @(-angle2Radian(10)), @(angle2Radian(0))];
    //设置动画的重复次数(设置为最大值)
    key2.repeatCount = repeatCounts;
    key2.fillMode = kCAFillModeRemoved;
    key2.removedOnCompletion = NO;
    [ballView.layer addAnimation:key2 forKey:@"transform.rotation"];
}

/**
 *  添加放大或者缩小
 */
- (void)addLargeOrSmall
{
    CAKeyframeAnimation *key2 = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    key2.duration = 0.8f;
    key2.values = @[[NSValue valueWithCGRect:CGRectMake(0, 0, 50, 50)], [NSValue valueWithCGRect:CGRectMake(0, 0, 70, 70)], [NSValue valueWithCGRect:CGRectMake(0, 0, 50, 50)]];
    key2.repeatCount = repeatCounts;
    key2.fillMode = kCAFillModeForwards;
    key2.removedOnCompletion = NO;
    [ballView.layer addAnimation:key2 forKey:nil];
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
