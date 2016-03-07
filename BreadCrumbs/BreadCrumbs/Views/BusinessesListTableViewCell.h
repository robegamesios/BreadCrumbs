//
//  BusinessesListTableViewCell.h
//  BreadCrumbs
//
//  Created by Rob Enriquez on 3/6/16.
//  Copyright © 2016 Rob Enriquez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessesListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;

@end
