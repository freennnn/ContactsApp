//
//  DetailViewController.h
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/15/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact+Custom.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) Contact *contact;

@property (nonatomic, weak) IBOutlet UILabel *nameValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *companyValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *birthdayValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *emailValueLabel;
@property (nonatomic, weak) IBOutlet UIImageView *contactImageView;


@end
