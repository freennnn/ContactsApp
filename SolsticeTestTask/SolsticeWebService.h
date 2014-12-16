//
//  SolsticeWebService.h
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/14/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OCWebServiceCompletionHandler)(id result, NSError *error);
typedef void(^OCWebServiceErrorHandler)(NSError *error);

@interface SolsticeWebService: NSObject

@property(nonatomic, strong) NSString* urlPath;

@property(nonatomic) NSTimeInterval timeout;

@property(nonatomic) BOOL needsAuthentication;
@property(nonatomic, strong) id requestBody;
@property(nonatomic, strong) NSString* httpMethod;
@property(nonatomic, strong) NSString* requestMimeType;

- (id)initWithURL:(NSString*)url;
- (void)executeWithCompletionHandler:(OCWebServiceCompletionHandler)completion;

@end
