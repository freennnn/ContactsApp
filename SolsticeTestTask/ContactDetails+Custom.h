//
//  ContactDetails+Custom.h
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/15/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import "ContactDetails.h"

@interface ContactDetails (Custom)

+ (ContactDetails*)contactDetails:(ContactDetails*)contactDetails fromDictionary:(NSDictionary *)json
                          context:(NSManagedObjectContext*)context;
@end
