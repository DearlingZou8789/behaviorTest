//
//  snapViewController.m
//  behaviorTest
//
//  Created by Damon on 15/10/27.
//  Copyright © 2015年 zhangle.in.iMac. All rights reserved.
//

#import "snapViewController.h"

@interface snapViewController ()
{
    UIDynamicAnimator *animator;
    UISnapBehavior *snapBehavior;
    
    UIView *boxView;
}
@end

@implementation snapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    boxView = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 70, 70)];
    boxView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:boxView];
    boxView.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [boxView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [boxView addGestureRecognizer:tap];
    
    [pan requireGestureRecognizerToFail:tap];
    
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIInterpolatingMotionEffect *effect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"move" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    [self.view addMotionEffect:effect];
}

- (void)panView:(UIPanGestureRecognizer *)pan
{
    CGRect rect = pan.view.frame;
    CGPoint point = [pan translationInView:self.view];
    pan.view.frame = CGRectOffset(rect, point.x, point.y);
    [pan setTranslation:CGPointZero inView:self.view];
}

- (void)tapView:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.view];
    
    [animator removeBehavior:snapBehavior];
    
    snapBehavior = [[UISnapBehavior alloc] initWithItem:boxView snapToPoint:point];
    snapBehavior.damping = 0.5;
    [animator addBehavior:snapBehavior];
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
