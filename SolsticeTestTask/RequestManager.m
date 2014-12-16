//
//  RequestManager.m
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/14/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import "RequestManager.h"
#import "SolsticeWebService.h"
#import "Contact+Custom.h"
#import "ContactDetails+Custom.h"

@implementation RequestManager

+ (instancetype)sharedInstance
{
    static id sharedInstance;

    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)getContacts:(RequestManagerCompletionWithArray)handler
{
    SolsticeWebService *webService	= [[SolsticeWebService alloc] initWithURL:@"https://solstice.applauncher.com/external/contacts.json"];
    
    [webService executeWithCompletionHandler:^(id result, NSError *error) {
        //NSLog(@"getContacts: %@", result);
        
        if ([result isKindOfClass:[NSArray class]])
        {
            NSMutableArray *array = [NSMutableArray array];
            NSManagedObjectContext *context = APP_DELEGATE().managedObjectContext;
            
            NSArray *results = result;
            for(NSDictionary *item in results)
            {
                Contact *contact = [Contact contactFromDictionary:item context:context];
                [array addObject:contact];
            }
            
            [context save:&error];
            
            if (handler)
            {
                handler(array, error);
            }
        }
        else if (handler)
        {
            handler(nil, error);
        }
    }];
}

- (void)getDetailsForContact:(Contact*)contact withHandler:(RequestManagerCompletionWithDictionary)handler
{
    SolsticeWebService *webService	= [[SolsticeWebService alloc] initWithURL:contact.detailsURL];
    [webService executeWithCompletionHandler:^(id result, NSError *error) {
       // NSLog(@"getContacts: %@", result);
        
        if ([result isKindOfClass:[NSDictionary class]])
        {
            NSManagedObjectContext *context = APP_DELEGATE().managedObjectContext;
            ContactDetails *contactDetails = [ContactDetails contactDetails:contact.details
                                                            fromDictionary:result
                                                                    context:context];
            contact.details = contactDetails;
           
            [context save:&error];
            
            if (handler)
            {
                handler(result, error);
            }
        }
        else if (handler)
        {
            handler(nil, error);
        }
    }];
}

@end
