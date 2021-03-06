//
//  PatienteTableViewController.m
//  ArztTerminApp
//
//  Created by Simplice Tchoupkoua on 23.01.13.
//  Copyright (c) 2013 Simplice. All rights reserved.
//

#import "PatienteTableViewController.h"
#import "AddPatientViewController.h"
#import "JSMCoreDataHelper.h"
#import "Constants.h"
#import "Patient.h"

@interface PatienteTableViewController ()

@property (nonatomic, strong) NSFetchedResultsController *patientFetchedResultsController;

@end

@implementation PatienteTableViewController

@synthesize patientFetchedResultsController = _patientFetchedResultsController;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [JSMCoreDataHelper performFetchOnFetchedResultController:self.fetchedResultsController];
}

#pragma mark - must be overrite by the subclass
-(NSFetchedResultsController *) fetchedResultsController {
    if (self.patientFetchedResultsController != nil) {
        return self.patientFetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:cEntityPatient inManagedObjectContext:[JSMCoreDataHelper managedObjectContext]];
    fetchRequest.entity = entityDescription;
    fetchRequest.predicate = self.searchFetchPredicate; // Use by the searcbar
    fetchRequest.fetchBatchSize = 64;
    
    NSSortDescriptor *sortVorname = [[NSSortDescriptor alloc] initWithKey:cEntityAttributeVorname ascending:YES];
    NSArray *sortArray = [NSArray arrayWithObject:sortVorname];
    
    [fetchRequest setSortDescriptors:sortArray];
    
    self.patientFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[JSMCoreDataHelper managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    self.patientFetchedResultsController.delegate = self;
    
    return self.patientFetchedResultsController;
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PatientIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    Patient *patient = (Patient *) [self.fetchedResultsController objectAtIndexPath:indexPath];
    // 2- display data into the cell.
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", patient.vorname, patient.nachname];
    cell.detailTextLabel.text = patient.anrede;
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES]; 
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return self.tableView.isEditing;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[JSMCoreDataHelper managedObjectContext] deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showAddPatient"] || [segue.identifier isEqualToString:@"showEditPatient"]) {
        AddPatientViewController *addPatientViewController = [segue destinationViewController];
        addPatientViewController.selectedPatient = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
    }
}

#pragma mark - barButtonItems

-(void) barButtonItemAddPressed: (id) sender {
    [self performSegueWithIdentifier:@"showAddPatient" sender:self];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [super searchBar:searchBar textDidChange:searchText];
    if (searchText.length > 0) {
        NSPredicate *filterPredicate = [JSMCoreDataHelper filterPredicateForEntityAttribue:cEntityAttributeNachname withSearchText:searchText];
        self.searchFetchPredicate = filterPredicate;
    } else {
        self.searchFetchPredicate = nil;
    }
    self.patientFetchedResultsController = nil;
    [JSMCoreDataHelper performFetchOnFetchedResultController:self.fetchedResultsController];
    [self.tableView reloadData];
}

@end
