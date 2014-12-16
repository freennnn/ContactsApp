//
//  ContactTableViewCell.h
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/14/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewCell : UITableViewCell

@property (weak) IBOutlet UIImageView* contactImageView;
@property (weak) IBOutlet UILabel *nameLabel;
@property (weak) IBOutlet UILabel *phoneLabel;

@end
