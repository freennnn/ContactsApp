//
//  RequestManager.h
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/14/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Contact;

@interface RequestManager : NSObject

typedef void(^RequestManagerCompletionWithDictionary)(NSDictionary *result, NSError *error);
typedef void(^RequestManagerCompletionWithArray)(NSArray *results, NSError *error);
typedef void(^RequestManagerCompletionWithSuccess)(BOOL success, NSError *error);

+ (RequestManager*)sharedInstance;

- (void)getContacts:(RequestManagerCompletionWithArray)handler;
- (void)getDetailsForContact:(Contact*)contact withHandler:(RequestManagerCompletionWithDictionary)handler;

@end
