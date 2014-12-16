//
//  Contact.h
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/15/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ContactDetails, Phone;

@interface Contact : NSManagedObject

@property (nonatomic, retain) NSNumber * birthdate;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * detailsURL;
@property (nonatomic, retain) NSNumber * employeeId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * smallImageURL;
@property (nonatomic, retain) Phone *phone;
@property (nonatomic, retain) ContactDetails *details;

@end
