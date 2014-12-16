//
//  ContactDetails+Custom.m
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/15/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import "ContactDetails+Custom.h"
#import "Address+Custom.h"

@implementation ContactDetails (Custom)

+ (ContactDetails*)contactDetails:(ContactDetails*)contactDetails fromDictionary:(NSDictionary *)json
                                        context:(NSManagedObjectContext*)context
{
    if (!contactDetails)
    {
        contactDetails = (ContactDetails*)[NSEntityDescription insertNewObjectForEntityForName:@"ContactDetails" inManagedObjectContext:context];
    }
    [contactDetails updateFromJson:json context:context];
    return contactDetails;
}

- (void)updateFromJson:(NSDictionary*)json context:(NSManagedObjectContext*)context
{
    self.favourite                  = json[@"favourite"];
    self.employeeId                 = [json numberForKey:@"employeeId"];
    self.largeImageURL              = [json stringForKey:@"largeImageURL"];
    self.email                      = [json stringForKey:@"email"];
    self.website                    = [json stringForKey:@"website"];
    
    NSDictionary* addressDictionary = json[@"address"];
    if (addressDictionary)
    {
        Address *address = [Address address:self.address
                             fromDictionary:addressDictionary
                                    context:APP_DELEGATE().managedObjectContext];
        self.address = address;
    }
}


@end
