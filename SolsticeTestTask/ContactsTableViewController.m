//
//  ViewController.m
//  SolsticeTestTask
//
//  Created by alexander.pranevich on 12/14/14.
//  Copyright (c) 2014 AP. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "ContactTableViewCell.h"
#import "RequestManager.h"
#import "Contact+Custom.h"
#import "Phone+Custom.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "DetailViewController.h"

static NSString *CellIdentifier = @"ContactTableViewCell";

@interface ContactsTableViewController ()

@end

@implementation ContactsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadContacts];
    
    [self setupFetchedResultsController];
    NSError *error;
    [self.fetchedResultsController performFetch:&error];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

- (void)loadContacts
{
    [[RequestManager sharedInstance] getContacts:nil];
}

- (void)setupFetchedResultsController
{
    NSManagedObjectContext *moc = APP_DELEGATE().managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sort1]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:moc
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    self.fetchedResultsController.delegate = self;
}

- (void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath
{
    ContactTableViewCell *contactCell = (ContactTableViewCell*)cell;
    Contact *contact = [self.fetchedResultsController objectAtIndexPath:indexPath];
    contactCell.nameLabel.text = contact.name;
    contactCell.phoneLabel.text = contact.phone.mobile;
    [contactCell.contactImageView sd_setImageWithURL:[NSURL URLWithString:contact.smallImageURL]];
}

- (CGSize)tableContentSize
{
    CGFloat height = 0.0f;
    for (int i = 0; i < [[self.fetchedResultsController sections] count]; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
        id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][i];
        height += [self tableView:self.tableView heightForRowAtIndexPath:indexPath]*[sectionInfo numberOfObjects] + self.tableView.sectionHeaderHeight;
    }
    return CGSizeMake(320, height);
}

#pragma mark - NSFetchedResultsControllerDelegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:newIndexPath.section]
                     withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.fetchedResultsController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
            cell.textLabel.backgroundColor = [UIColor clearColor];
        }
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell *cell = (UITableViewCell*)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    DetailViewController *vc = (DetailViewController*)[segue destinationViewController];
    vc.contact = [self.fetchedResultsController objectAtIndexPath:indexPath];
}



@end
