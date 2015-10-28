//
//  CoreAnimationViewController.m
//  behaviorTest
//
//  Created by zmj27404 on 15/10/28.
//  Copyright © 2015年 zhangle.in.iMac. All rights reserved.
//

#import "CoreAnimationViewController.h"

@interface CoreAnimationViewController ()
{
    CALayer *ballLayer;
    UIView *planView;
    
    CGRect souceRect, toRect;
}
@end

@implementation CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    ballLayer = [CALayer layer];
    ballLayer.backgroundColor = [UIColor redColor].CGColor;
    ballLayer.bounds = CGRectMake(50, 50, 125, 125);
    ballLayer.contentsGravity = kCAGravityResizeAspect;
    ballLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    ballLayer.cornerRadius = ballLayer.bounds.size.width / 2;
    ballLayer.borderWidth = 1.0f;
    ballLayer.borderColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:ballLayer];
    
    souceRect = CGRectMake(140, 20, 30, 30);
    toRect = CGRectMake(300, 600, 30, 30);
    planView = [[UIView alloc] initWithFrame:souceRect];
    planView.backgroundColor = [UIColor blueColor];
    planView.layer.opacity = 0.25;
    [self.view addSubview:planView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnce:)];
    planView.userInteractionEnabled = YES;
    [planView addGestureRecognizer:tap];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(120, 20, 30, 30) cornerRadius:5];
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.frame = planView.frame;
    shapLayer.path = path.CGPath;
    shapLayer.fillColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:shapLayer];
}

- (void)tapOnce:(UITapGestureRecognizer *)tap
{
    CGAffineTransform moveTransform;
    if (CGRectEqualToRect(tap.view.frame, souceRect))
    {
        moveTransform = CGAffineTransformMakeTranslation(CGRectGetMinX(toRect) - CGRectGetMinX(souceRect), CGRectGetMinY(toRect) - CGRectGetMinY(souceRect));
    }
    else if(CGRectEqualToRect(tap.view.frame, toRect))
    {
        moveTransform = CGAffineTransformMakeTranslation(CGRectGetMinX(souceRect) - CGRectGetMinX(toRect), CGRectGetMinY(souceRect) - CGRectGetMinY(toRect));
    }
    [planView.layer setAffineTransform:moveTransform];
    planView.layer.opacity = 1.0f;
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
