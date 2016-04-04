//
//  BusinessesListTableViewControllerDataSource.m
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/6/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import "BusinessesListTableViewControllerDataSource.h"
#import "BusinessDetailsViewController.h"
#import "BusinessesListTableViewCell.h"
#import "YelpBusiness.h"

static NSString *const BusinessesListCellIdentifier = @"BusinessesListCellIdentifier";
static NSInteger const DefaultRowHeight = 250;

@implementation BusinessesListTableViewControllerDataSource

- (id)initWithTableView:(UITableView *)tableView {
    self = [super init];
    
    if (self) {
        self.tableView = tableView;
        self.tableView.delegate = self;
    }
    return self;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.businessesArray.count) {
        return self.businessesArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BusinessesListCellIdentifier forIndexPath:indexPath];
    
    //RE: TODO: add cell info here
    YelpBusiness *currentBusiness = [self.businessesArray objectAtIndex:indexPath.row];
    
    cell.name.text = currentBusiness.name;
    cell.phoneNumber.text = currentBusiness.location.city;
    
    //RE: Configure photoImage
    UIImage *photoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:currentBusiness.imageUrl]]];
    cell.photoImageView.image = photoImage;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return DefaultRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //RE: TODO:
    NSLog(@"cell tapped");
    [self showStoreItemDetailsScreen];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - StoreItemDetailsTableViewController

- (void)showStoreItemDetailsScreen {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:StoryboardName.main bundle:nil];
    
    BusinessDetailsViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:ScreenStoryboardId.businessDetailsViewController];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
