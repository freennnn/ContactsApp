//
//  ContactDetails.h
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/15/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address, Contact;

@interface ContactDetails : NSManagedObject

@property (nonatomic, retain) NSNumber * employeeId;
@property (nonatomic, retain) NSNumber * favourite;
@property (nonatomic, retain) NSString * largeImageURL;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) Address *address;
@property (nonatomic, retain) Contact *contact;

@end
