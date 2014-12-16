//
//  ViewController.h
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/14/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
}
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

