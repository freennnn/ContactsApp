//
//  Phone+Custom.m
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/14/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import "Phone+Custom.h"

@implementation Phone (Custom)

+ (Phone*)phone:(Phone*)phone fromDictionary:(NSDictionary *)json
                      context:(NSManagedObjectContext*)context
{
    if (!phone) {
        phone = (Phone*)[NSEntityDescription insertNewObjectForEntityForName:@"Phone" inManagedObjectContext:context];
    }

    [phone updateFromJson:json context:context];
    return phone;
}

- (void)updateFromJson:(NSDictionary*)json context:(NSManagedObjectContext*)context
{
    self.work	= [json stringForKey:@"work"];
    self.home   = [json stringForKey:@"home"];
    self.mobile = [json stringForKey:@"mobile"];
}


@end
