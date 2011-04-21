//
//  PrimesTableViewController.m
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PrimesTableViewController.h"
#import "PrimesTableViewCell.h"

@implementation PrimesTableViewController

@synthesize primeGenerator;
@synthesize range;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
	CGFloat viewWidth = self.tableView.bounds.size.width;
	self.tableView.rowHeight = viewWidth;
	self.tableView.allowsSelection = false;
	
    range = 10000000; // Default starting range.
    primeGenerator = [[PrimesSieve alloc] initWithRange:range];
    [primeGenerator setDelegate:self];
    
    operationQueue = [NSOperationQueue new];
    NSInvocationOperation *primeGeneratorOp = [[NSInvocationOperation alloc] initWithTarget:primeGenerator selector:@selector(startSieve) object:nil];
    [operationQueue addOperation:primeGeneratorOp];
    [activityIndicator startAnimating];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

	//primeDataRange = 1000;
	//primeData = calloc(primeDataRange, sizeof(IntegerPrimality));
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return range / PRIMES_CELL_COUNT;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"PrimesCell";
    
    PrimesTableViewCell *cell = (PrimesTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[PrimesTableViewCell alloc] init] autorelease];
    }
    
    // Configure the cell...]
    [cell setStartingValue:([indexPath section] * PRIMES_CELL_COUNT)];
	
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return @"XX";
	} else {
		return [NSString stringWithFormat:@"%dXX", section];
	}
}

#pragma mark -
#pragma mark Table view delegate


#pragma mark -
#pragma mark PrimesSieveDelegate
-(void)sieveCompleted {
    [activityIndicator stopAnimating];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	// free(primeData);
    [operationQueue release];
    [super dealloc];
}


@end

