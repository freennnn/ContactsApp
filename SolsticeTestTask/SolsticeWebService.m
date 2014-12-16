//
//  SolsticeWebService.m
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/14/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import "SolsticeWebService.h"
#define DEFAULT_TIMEOUT	60.0

@interface SolsticeWebService()
@property (nonatomic, weak) NSURLConnection *connection;
@property (nonatomic,strong) NSURLResponse* response;
@property (nonatomic,strong) NSMutableData* data;
@property (nonatomic,strong) NSURLRequest* request;
@property (nonatomic,copy) OCWebServiceCompletionHandler callback;
@end

@implementation SolsticeWebService

- (id)init
{
    if ((self = [super init]))
    {
        self.httpMethod             = @"POST";
        self.requestMimeType        = @"application/json";
        self.timeout                = DEFAULT_TIMEOUT;
    }
return self;
}

-(id)initWithURL:(NSString*)url
{
    if ((self = [self init]))
    {
        self.urlPath = url;
    }
    
    return self;
}
#pragma mark - Configuration

- (void)executeWithCompletionHandler:(OCWebServiceCompletionHandler)completion
{
    NSURL *url = [NSURL URLWithString:self.urlPath];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:self.timeout];
    //[request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    
    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithCapacity:0];
    [headers setObject:self.requestMimeType forKey:@"Content-Type"];
    [headers setObject:@"utf-8" forKey:@"charset"];
    
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPMethod:self.httpMethod];
    
    if (self.requestBody )
    {
        if ([self.requestBody isKindOfClass:[NSData class]])
        {
            [request setHTTPBody:self.requestBody];
        }
        else if ([self.requestMimeType isEqualToString:@"application/json"])
        {
            NSError *error;
            [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:self.requestBody options:0 error:&error]];
        }
        else if ([self.requestMimeType isEqualToString:@"application/xml"])
        {
            [request setHTTPBody:[self.requestBody dataUsingEncoding: NSUTF8StringEncoding]];
        }
    }

    self.callback	= completion;
    self.data		= [[NSMutableData alloc] init];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    [self performSelector:@selector(requestDidTimeout:) withObject:self.connection afterDelay:self.timeout];
}

- (void)requestDidFail:(NSError*)error
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    self.callback(nil, error);
}

- (void)requestDidTimeout:(NSURLConnection*)connection
{
   [connection cancel];
    NSString *timeoutMessage = @"timeout.message";
   [self requestDidFail:[NSError errorWithDomain:timeoutMessage code:404 userInfo:@{@"message":timeoutMessage}]];
}

- (void)requestDidFinishLoading:(NSURLConnection*)connection
{
    NSError *err;
    id result = _data ? [NSJSONSerialization JSONObjectWithData:_data options:0 error:&err] : nil;
    
    NSError *error;
    
    if ([result isKindOfClass:[NSArray class]])
    {
        
    }
    else if ([_response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)_response;
        if (httpResponse.statusCode == 400)
        {
            error = [NSError errorWithDomain:@"" code:httpResponse.statusCode userInfo:nil];
        }
    }
    
    self.callback(result, nil);
}

#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.response = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self requestDidFail:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self requestDidFinishLoading:connection];
}

@end
