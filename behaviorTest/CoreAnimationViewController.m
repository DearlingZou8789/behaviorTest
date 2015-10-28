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
