//
//  behaviorTableViewController.m
//  behaviorTest
//
//  Created by Damon on 15/10/27.
//  Copyright © 2015年 zhangle.in.iMac. All rights reserved.
//

#import "behaviorTableViewController.h"
#import "GravityViewController.h"
#import "CollisionViewController.h"
#import "AttachmentViewController.h"
#import "pushViewController.h"
#import "snapViewController.h"
#import "DynamicViewController.h"
#import "CoreAnimationViewController.h"

@interface behaviorTableViewController ()
{
    NSArray *dataArray;
}
@end

@implementation behaviorTableViewController

#define cellIdentify @"behaviorCell"
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"力学行为特性";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataArray = @[@{@"UIGravityBehavior":@"重力行为"},
                  @{@"UICollisionBehavior":@"碰撞行为"},
                  @{@"UIAttachmentBehavior":@"吸附行为"},
                  @{@"UIPushBehavior":@"推行为"},
                  @{@"UISnapBehavior":@"甩行为"},
                  @{@"UIDynamicItemBehavior":@"行为限制"},
                  @{@"CoreAnimation":@"动画视图"}];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentify];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify forIndexPath:indexPath];
    NSDictionary *dict = dataArray[indexPath.row];
    cell.textLabel.text = [[dict allValues] lastObject];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.text = [[dict allKeys] lastObject];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = nil;
    switch (indexPath.row)
    {
        case 0:
            vc = [[GravityViewController alloc] init];
            break;
        case 1:
            vc = [[CollisionViewController alloc] init];
            break;
        case 2:
            vc = [[AttachmentViewController alloc] init];
            break;
        case 3:
            vc = [[pushViewController alloc] init];
            break;
        case 4:
            vc = [[snapViewController alloc] init];
            break;
        case 5:
            vc = [[DynamicViewController alloc] init];
            break;
        case 6:
            vc = [[CoreAnimationViewController alloc] init];
            break;
        default:
            break;
    }
    NSDictionary *dict = dataArray[indexPath.row];
    vc.title = [[dict allValues] lastObject];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
