//
//  AONewsTableViewCell.h
//  RssParseNews
//
//  Created by admin on 3/18/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AONewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageNewsImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleNewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubDateNewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *autorNewsLabel;

@end
