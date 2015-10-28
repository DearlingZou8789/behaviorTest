//
//  pushViewController.m
//  behaviorTest
//
//  Created by Damon on 15/10/27.
//  Copyright © 2015年 zhangle.in.iMac. All rights reserved.
//

#import "pushViewController.h"

@interface pushViewController ()<UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>
{
    BOOL firstContact;
    UIDynamicAnimator *animator;
    UIGravityBehavior *gravity;
    UIAttachmentBehavior *attachBehavior;
    UICollisionBehavior *collision;
    UIDynamicItemBehavior *dynamicBehavior;
    
    UIView *boxView;
    UIView *pointView;
    UIView *barrierView;
}
@end

@implementation pushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    boxView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 70, 70)];
    boxView.backgroundColor = [UIColor redColor];
    [self.view addSubview:boxView];
    
    /** 没有作用
     [boxView addObserver:self forKeyPath:@"frame" options:0 context:NULL];
     */
    
    boxView.userInteractionEnabled = YES;
    boxView.layer.delegate = self;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [boxView addGestureRecognizer:pan];
    
    barrierView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 120, 2)];
    barrierView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:barrierView];
    
    pointView = [[UIView alloc] initWithFrame:CGRectMake(120, 250, 10, 10)];
    pointView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:pointView];
    pointView.layer.cornerRadius = pointView.bounds.size.width / 2.0;
    pointView.layer.borderColor = pointView.backgroundColor.CGColor;
    pointView.layer.borderWidth = 1.0f;
    
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    animator.delegate = self;
    //重力行为
    gravity = [[UIGravityBehavior alloc] initWithItems:@[boxView]];
    gravity.gravityDirection = CGVectorMake(0.0, 0.1);
    gravity.magnitude = 2;
    //碰撞行为
    collision = [[UICollisionBehavior alloc] initWithItems:@[boxView]];
    [collision addBoundaryWithIdentifier:@"barrier" fromPoint:barrierView.frame.origin toPoint:CGPointMake(barrierView.frame.origin.x + barrierView.frame.size.width, barrierView.frame.origin.y)];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    collision.collisionDelegate = self;
    //行为限制
    dynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[boxView]];
    dynamicBehavior.elasticity = 0.5;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [animator addBehavior:gravity];
    [animator addBehavior:collision];
    [animator addBehavior:dynamicBehavior];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    NSString *str = (NSString *)identifier;
    if ([str isEqualToString:@"barrier"])
    {
        if (!firstContact)
        {
            firstContact = YES;
            
            //设置吸附行为
            attachBehavior = [[UIAttachmentBehavior alloc] initWithItem:pointView attachedToItem:boxView];
            [animator addBehavior:attachBehavior];
            //设置推行为
            UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[boxView] mode:UIPushBehaviorModeContinuous];
            //设置推动方向
            CGVector pushDirection = {0.5, -0.5};
            push.pushDirection = pushDirection;
            push.magnitude = 5.0f;
            [animator addBehavior:push];
        }
    }
}

- (void)panView:(UIPanGestureRecognizer *)pan
{
    CGRect rect = pan.view.frame;
    CGPoint point = [pan translationInView:self.view];
    pan.view.frame = CGRectOffset(rect, point.x, point.y);
    [pan setTranslation:CGPointZero inView:self.view];
}

- (void)dealloc
{
    NSLog(@"push -> dealloc");
    boxView.layer.delegate = nil;
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
