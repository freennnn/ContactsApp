//
//  Contact+Custom.m
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/14/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import "Contact+Custom.h"
#import "Phone+Custom.h"

@implementation Contact (Custom)

+ (Contact*)contactFromDictionary:(NSDictionary *)json
                          context:(NSManagedObjectContext*)context
{
    
    Contact *object = [Contact findContactWithName:json[@"name"]];
    
    if (!object)
    {
        object = (Contact*)[NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:context];
    }
    [object updateFromJson:json context:context];
    return object;
}

+ (Contact*)findContactWithName:(NSString*)name
{
    NSString *entityName = NSStringFromClass([self class]);
    NSManagedObjectContext *context = APP_DELEGATE().managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name == %@", name];
    [fetchRequest setPredicate:predicate];
    
    fetchRequest.returnsObjectsAsFaults = NO;
    
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:fetchRequest error:&error];
    if (array.count > 0) {
        return array[0];
    }
    
    return nil;
}

- (void)updateFromJson:(NSDictionary*)json context:(NSManagedObjectContext*)context
{
    self.name						= json[@"name"];
    self.employeeId                 = [json numberForKey:@"employeeId"];
    self.company                    = [json stringForKey:@"company"];
    self.detailsURL                 = [json stringForKey:@"detailsURL"];
    self.smallImageURL              = [json stringForKey:@"smallImageURL"];
    self.birthdate                  = [json numberForKey:@"birthdate"];
    
    NSDictionary* phoneDictionary = json[@"phone"];
    if (phoneDictionary)
    {
        Phone *phone = [Phone phone:self.phone fromDictionary:phoneDictionary context:APP_DELEGATE().managedObjectContext];
        self.phone = phone;
    }
}

- (void)logSelf
{
    NSLog(@"contact = %@", self);
}

- (NSString*)birthdayRespresentation
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.birthdate.doubleValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, yyyy"];
    return [formatter stringFromDate:date];
}

@end
