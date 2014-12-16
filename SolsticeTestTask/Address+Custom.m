//
//  Address+Custom.m
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/15/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import "Address+Custom.h"

@implementation Address (Custom)

+ (Address*)address:(Address*)address fromDictionary:(NSDictionary *)json context:(NSManagedObjectContext*)context
{
    if (!address) {
        address = (Address*)[NSEntityDescription insertNewObjectForEntityForName:@"Address" inManagedObjectContext:context];
    }
    
    [address updateFromJson:json context:context];
    return address;
}

- (void)updateFromJson:(NSDictionary*)json context:(NSManagedObjectContext*)context
{
    self.street     = [json stringForKey:@"street"];
    self.city       = [json stringForKey:@"city"];
    self.state      = [json stringForKey:@"state"];
    self.country    = [json stringForKey:@"country"];
    self.zip        = [json numberForKey:@"zip"];
    self.longitude  = [json numberForKey:@"longitude"];
    self.latitude   = [json numberForKey:@"latitude"];
}

- (NSString*)stringRepresentation
{
    return [NSString stringWithFormat:@"%@ \n%@, %@", self.street, self.city, self.state];
}

@end
