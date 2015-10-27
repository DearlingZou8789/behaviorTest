//
//  AttachmentViewController.m
//  behaviorTest
//
//  Created by Damon on 15/10/27.
//  Copyright © 2015年 zhangle.in.iMac. All rights reserved.
//

#import "AttachmentViewController.h"

@interface AttachmentViewController ()<UICollisionBehaviorDelegate>
{
    UIDynamicAnimator *animator;
    UIGravityBehavior *gravity;
    UICollisionBehavior *collision;
    UIAttachmentBehavior *attachment;
    UIDynamicItemBehavior *dynamicBehavior;
    
    UIView *boxView;
    UIView *pointView;
    UIView *barrierView;
    BOOL isGravity;
}
@end

@implementation AttachmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    boxView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 70, 70)];
    boxView.backgroundColor = [UIColor redColor];
    [self.view addSubview:boxView];
    [boxView addObserver:self forKeyPath:@"frame" options:0 context:NULL];

    boxView.userInteractionEnabled = YES;
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
    //重力行为
    gravity = [[UIGravityBehavior alloc] initWithItems:@[boxView]];
    gravity.gravityDirection = CGVectorMake(0.0, 0.1);
    //碰撞行为
    collision = [[UICollisionBehavior alloc] initWithItems:@[boxView]];
    [collision addBoundaryWithIdentifier:@"barrier" fromPoint:barrierView.frame.origin toPoint:CGPointMake(barrierView.frame.origin.x + barrierView.frame.size.width, barrierView.frame.origin.y)];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    collision.collisionDelegate = self;
    //行为限制
    dynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[boxView]];
    dynamicBehavior.elasticity = 0.5;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"])
    {
        CGRect rect = [change[@"new"] CGRectValue];
        NSLog(@"rect = %@", NSStringFromCGRect(rect));
        if (rect.origin.y + rect.size.height == self.view.frame.size.height)
        {
            isGravity = NO;
            [animator removeAllBehaviors];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animator];
    [self addBehavior];
}

- (void)panView:(UIPanGestureRecognizer *)pan
{
    if (isGravity)
    {
        return;
    }
    CGRect rect = pan.view.frame;
    CGPoint point = [pan translationInView:self.view];
    pan.view.frame = CGRectOffset(rect, point.x, point.y);
    [pan setTranslation:CGPointZero inView:self.view];
}

- (void)addBehavior
{
    [animator addBehavior:gravity];
    [animator addBehavior:collision];
    [animator addBehavior:dynamicBehavior];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    NSString *identStr = (NSString *)identifier;
    isGravity = YES;
    if ([identStr isEqualToString:@"barrier"])
    {
        attachment = [[UIAttachmentBehavior alloc] initWithItem:pointView attachedToItem:boxView];
        [animator addBehavior:attachment];
    }
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2
{
    
}


- (void)dealloc
{
    NSLog(@"attachmentViewController did dealloc");
    [boxView removeObserver:self forKeyPath:@"frame"];
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
