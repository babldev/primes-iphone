//
//  PrimesViewController.h
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrimesSieve.h"
#import "PrimesVisualView.h"

#define PRIMES_SIEVE_RANGE 1000000
#define PRIMES_SECTION_ROWS 10

@interface PrimesViewController : UIViewController
        <PrimesSieveDelegate, UITableViewDataSource, UISearchBarDelegate> {
    PrimesSieve *primesSieve;
    NSOperationQueue *operationQueue;
    NSNumberFormatter *numberFormatter;
}

@property (nonatomic, retain, readonly) PrimesSieve *primesSieve;

@property (nonatomic, retain) IBOutlet UITableView *primesTableView;
@property (nonatomic, retain) IBOutlet PrimesVisualView *primesVisualView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UILabel *selectedDetailView;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UIScrollView *visualScrollView;

- (IBAction)onSwitchView:(UISegmentedControl *)sender;
- (IBAction)onResetView:(UIBarButtonItem *)sender;

@end
