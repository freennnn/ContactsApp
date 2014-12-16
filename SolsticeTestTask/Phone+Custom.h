//
//  Phone+Custom.h
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/14/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import "Phone.h"

@interface Phone (Custom)

+ (Phone*)phone:(Phone*)phone fromDictionary:(NSDictionary *)json
        context:(NSManagedObjectContext*)context;

@end
