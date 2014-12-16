//
//  NSDictionary+NullSafe.m
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/14/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import "NSDictionary+NullSafe.h"

@implementation NSMutableDictionary (NullSafe)

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if (obj)
    {
        [self setObject:obj forKey:key];
    }
    else
    {
        [self setObject:[NSNull null] forKey:key];
    }
}

@end;


@implementation NSDictionary (NullSafe)

- (id)objectForKeyedSubscript:(id)key
{
    id value = [self objectForKey:key];
    return value == [NSNull null] ? nil : value;
}

- (BOOL)boolForKey:(NSString*)key
{
    NSNumber *value = self[key];
    return value ? [value boolValue] : NO;
}

- (NSNumber *) numberForKey:(NSString*)key
{
    return @([self[key] doubleValue]);
}

- (NSString *) stringForKey:(NSString*)key
{
    id value = self[key];
    NSString *str = nil;
    if ([value isKindOfClass:[NSString class]]) {
        str = value;
    }
    else if (value){
        str = [NSString stringWithFormat:@"%@", value];
    }
    
    return str;
}

@end