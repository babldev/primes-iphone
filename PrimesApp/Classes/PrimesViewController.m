//
//  PrimesViewController.m
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PrimesViewController.h"
#import "PrimesTableViewCell.h"

@implementation PrimesViewController

@synthesize primesSieve;
@synthesize primesTableView;
@synthesize primesVisualView;
@synthesize activityIndicator;
@synthesize selectedDetailView;
@synthesize searchBar;

NSString *kDefaultDetailText = @"to see if it is prime!";

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger range = 1000000; // Default starting range.
    primesSieve = [[PrimesSieve alloc] initWithRange:range];
    [primesSieve setDelegate:self];
    
    operationQueue = [NSOperationQueue new];
    NSInvocationOperation *primeGeneratorOp = [[NSInvocationOperation alloc] initWithTarget:primesSieve
                                                                                   selector:@selector(startSieve)
                                                                                     object:nil];
    
    // Set up UITableView
    CGFloat viewWidth = primesTableView.bounds.size.width;
	primesTableView.rowHeight = viewWidth / PRIMES_CELL_COUNT;
	primesTableView.allowsSelection = false;
    
    // Set up PrimesVisualView
    primesVisualView.primesSieve = primesSieve;
    
    // Register for integer selection notifications.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onIntSelectedNotification:)
                                                 name:@"intSelectedNotification"
                                               object:nil];
    
    // Create the number formatter.
    numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:kCFNumberFormatterDecimalStyle];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setGroupingSeparator:@","];
    
    // Set up the initial text values for the info bar.
    selectedDetailView.text = kDefaultDetailText;
    
    [operationQueue addOperation:primeGeneratorOp];
    [activityIndicator startAnimating];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark PrimesSieveDelegate
-(void)sieveCompleted {
    // TODO: Use a global variable instead of directly giving the notification name.
    NSNotification *sieveCompletedNotification =
    [NSNotification notificationWithName:@"primeSieveUpdateNotification"
                                  object:self];
    [[NSNotificationCenter defaultCenter] postNotification:sieveCompletedNotification];
    [primesVisualView setNeedsDisplay];
    [activityIndicator stopAnimating];
}

#pragma mark -
#pragma mark IBAction
- (IBAction)onSwitchView:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            primesTableView.hidden = NO;
            // primesVisualView.hidden = YES;
            break;
        case 1:
            primesTableView.hidden = YES;
            // primesVisualView.hidden = NO;
            break;
    }
}

- (IBAction)onResetView:(UIBarButtonItem *)sender {
    // Hack to to zoom to the top.
    [primesTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
    // Reset the text labels.
    searchBar.text = nil;
    selectedDetailView.text = kDefaultDetailText;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return primesSieve.range / (PRIMES_CELL_COUNT * 10);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return PRIMES_SECTION_ROWS;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *PrimesCellIdentifier = @"PrimesCell";
    
    PrimesTableViewCell *cell = (PrimesTableViewCell *) [tableView dequeueReusableCellWithIdentifier:PrimesCellIdentifier];
    if (cell == nil) {
        cell = [[[PrimesTableViewCell alloc] initWithPrimesSieve:primesSieve
                                                 reuseIdentifier:PrimesCellIdentifier] autorelease];
    }
    
    // Configure the cell...]
    [cell setStartingValue:([indexPath section] * PRIMES_SECTION_ROWS * PRIMES_CELL_COUNT +
                            [indexPath row] * PRIMES_CELL_COUNT)];
	
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return @"0-99";
	} else {
        NSNumber *startNumber = [NSNumber numberWithInt:section * 100];
        NSString *startValue = [numberFormatter stringFromNumber:startNumber];
		return startValue;
	}
}

#pragma mark -
#pragma mark integerSelectedNotification handler
- (void)onIntSelectedNotification:(NSNotification *)notification {
    NSNumber *numberSelected = (NSNumber *) [notification object];
    NSInteger intNumberSelected = [numberSelected intValue];
    NSInteger smallestDivisor = [primesSieve divisorForInt:intNumberSelected];
    
    NSString *details;
    selectedDetailView.textColor = [UIColor whiteColor];
    NSNumber *smallestDivisorNum = [NSNumber numberWithInt:smallestDivisor];
    switch (smallestDivisor) {
        case 0:
            details = @"is special!";
            break;
        case 1:
            details = @"is prime!";
            selectedDetailView.textColor = [UIColor greenColor];
            break;
        default:
            details = [NSString stringWithFormat:@"is divisible by %@.",
                       [numberFormatter stringFromNumber:smallestDivisorNum]];
            break;
    }
    selectedDetailView.text = details;
    
    if ([searchBar.text intValue] != intNumberSelected) {
        searchBar.text = [numberSelected stringValue];
    }
    NSInteger section = intNumberSelected / (PRIMES_SECTION_ROWS * PRIMES_CELL_COUNT);
    NSInteger row = (intNumberSelected % (PRIMES_SECTION_ROWS * PRIMES_CELL_COUNT)) / PRIMES_SECTION_ROWS;
    [primesTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]
                           atScrollPosition:UITableViewScrollPositionTop
                                   animated:YES];
}

#pragma mark -
#pragma mark UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSInteger intQuery = [searchText intValue];
    if (intQuery >= 0 && intQuery <= primesSieve.range) {
        NSNotification *intSelectedNotification =
                [NSNotification notificationWithName:@"intSelectedNotification"
                                              object:[NSNumber
                                                      numberWithInt:intQuery]];
        [[NSNotificationQueue defaultQueue] enqueueNotification:intSelectedNotification
                                                   postingStyle:NSPostNow
                                                   coalesceMask:NSNotificationCoalescingOnName
                                                       forModes:nil];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar {
    [aSearchBar resignFirstResponder];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [numberFormatter release];
    
    [primesSieve release];
    [operationQueue release];
    
    [primesTableView release];
    [primesVisualView release];
    [activityIndicator release];
    
    [super dealloc];
}


@end
