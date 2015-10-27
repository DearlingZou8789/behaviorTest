//
//  CollisionViewController.m
//  behaviorTest
//
//  Created by Damon on 15/10/27.
//  Copyright © 2015年 zhangle.in.iMac. All rights reserved.
//

#import "CollisionViewController.h"

@interface CollisionViewController ()<UICollisionBehaviorDelegate>
{
    UICollisionBehavior *collision;
    UIDynamicAnimator *animator;
    UIGravityBehavior *gravity;
}
@end

@implementation CollisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 20, 50, 50)];
    redView.backgroundColor = [UIColor redColor];
    redView.layer.borderColor = [UIColor redColor].CGColor;
    redView.layer.cornerRadius = redView.frame.size.width / 2;
    [self.view addSubview:redView];
    
    redView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [redView addGestureRecognizer:pan];
    
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    //重力行为
    gravity = [[UIGravityBehavior alloc] initWithItems:@[redView]];
    //设置重力的方向
    CGVector gravityDirection = {0.0, 0.1};
    [gravity setGravityDirection:gravityDirection];
    
    //碰撞行为
    collision = [[UICollisionBehavior alloc] initWithItems:@[redView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    collision.collisionDelegate = self;
}

- (void)panView:(UIPanGestureRecognizer *)pan
{
    CGRect rect = pan.view.frame;
    CGPoint point = [pan translationInView:self.view];
    pan.view.frame = CGRectOffset(rect, point.x, point.y);
    [pan setTranslation:CGPointZero inView:self.view];
    if (pan.state == UIGestureRecognizerStateEnded)
    {
        [self beginBehaviro];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animator];
    [self beginBehaviro];
}

- (void)beginBehaviro
{
    [animator addBehavior:gravity];
    [animator addBehavior:collision];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2
{
    [animator removeBehavior:gravity];
    [animator removeBehavior:collision];
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
