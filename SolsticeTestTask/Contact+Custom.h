//
//  Contact+Custom.h
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/14/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import "Contact.h"
@interface Contact (Custom)

- (void)logSelf;
+ (Contact*)contactFromDictionary:(NSDictionary *)json
                          context:(NSManagedObjectContext*)context;
- (NSString*)birthdayRespresentation;

@end
