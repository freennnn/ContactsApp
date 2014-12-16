//
//  Phone.h
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/14/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Phone : NSManagedObject

@property (nonatomic, retain) NSString * work;
@property (nonatomic, retain) NSString * home;
@property (nonatomic, retain) NSString * mobile;
@property (nonatomic, retain) NSManagedObject *contact;

@end
