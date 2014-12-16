//
//  Address+Custom.h
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/15/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import "Address.h"

@interface Address (Custom)

+ (Address*)address:(Address*)address fromDictionary:(NSDictionary *)json context:(NSManagedObjectContext*)context;
- (NSString*)stringRepresentation;

@end
