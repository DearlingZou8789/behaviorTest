//
//  AttachmentViewController.m
//  behaviorTest
//
//  Created by Damon on 15/10/27.
//  Copyright © 2015年 zhangle.in.iMac. All rights reserved.
//

#import "AttachmentViewController.h"

@interface AttachmentViewController ()<UICollisionBehaviorDelegate, UIDynamicAnimatorDelegate>
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
    
    pointView = [[UIView alloc] initWithFrame:CGRectMake(140, 250, 10, 10)];
    pointView.backgroundColor = [UIColor blueColor];
    pointView.layer.cornerRadius = pointView.bounds.size.width / 2.0;
    pointView.layer.borderColor = pointView.backgroundColor.CGColor;
    [self.view addSubview:pointView];

    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    animator.delegate = self;
    //重力行为
    gravity = [[UIGravityBehavior alloc] initWithItems:@[boxView]];
    gravity.gravityDirection = CGVectorMake(0.0, 0.1);
    gravity.magnitude = 0.9;
    //碰撞行为
    collision = [[UICollisionBehavior alloc] initWithItems:@[boxView]];
    [collision addBoundaryWithIdentifier:@"barrier" fromPoint:barrierView.frame.origin toPoint:CGPointMake(barrierView.frame.origin.x + barrierView.frame.size.width, barrierView.frame.origin.y)];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    collision.collisionDelegate = self;
    collision.collisionMode = UICollisionBehaviorModeBoundaries;
    //行为限制
    dynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[boxView]];
    dynamicBehavior.elasticity = 0.5;
}

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    NSLog(@"layer.center = %@, boxView.frame = %@", NSStringFromCGPoint(layer.position), NSStringFromCGRect(boxView.frame));
    if (layer.position.y >= self.view.frame.size.height - boxView.frame.size.height / 2 - 0.001)
    {
        isGravity = NO;
    }
    return nil;
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

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(nonnull id<UIDynamicItem>)item withBoundaryIdentifier:(nullable id<NSCopying>)identifier
{
    NSString *identStr = (NSString *)identifier;
    isGravity = YES;
    if ([identStr isEqualToString:@"barrier"])
    {
        attachment = [[UIAttachmentBehavior alloc] initWithItem:pointView attachedToItem:boxView];
        [animator addBehavior:attachment];
    }
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    isGravity = NO;
}


- (void)dealloc
{
    NSLog(@"attachmentViewController did dealloc");
    boxView.layer.delegate = nil;
//    [boxView removeObserver:self forKeyPath:@"frame"];
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
