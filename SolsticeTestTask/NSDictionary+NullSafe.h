//
//  NSDictionary+NullSafe.h
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/14/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullSafe)

- (BOOL)boolForKey:(NSString*)key;
- (NSNumber*)numberForKey:(NSString*)key;
- (NSString*)stringForKey:(NSString*)key;

@end

@interface NSMutableDictionary (NullSafe)

@end;

