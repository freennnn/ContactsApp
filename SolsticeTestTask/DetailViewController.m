//  DetailViewController.m
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/15/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import "DetailViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "Phone+Custom.h"
#import "RequestManager.h"
#import "ContactDetails+Custom.h"
#import "Address+Custom.h"

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[RequestManager sharedInstance] getDetailsForContact:self.contact withHandler:^(NSDictionary *result, NSError *error)
    {
        [self updateUI];
    }];
    
    [self updateUI];

}

- (void)updateUI
{
    ContactDetails *details = self.contact.details;
    [self.contactImageView sd_setImageWithURL:[NSURL URLWithString:details.largeImageURL]];
    self.nameValueLabel.text = self.contact.name;
    self.companyValueLabel.text = self.contact.company;
    self.phoneValueLabel.text = self.contact.phone.home;
    self.addressValueLabel.text = [details.address stringRepresentation];
    self.birthdayValueLabel.text = [self.contact birthdayRespresentation];
    self.emailValueLabel.text = details.email;
}


@end
