//
//  PrimesTableViewCell.h
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrimesLabel.h"
#import "PrimesSieve.h"

#define PRIMES_CELL_COUNT 10

@interface PrimesTableViewCell : UITableViewCell {
    PrimesSieve* primesSieve;
    NSMutableArray *primesLabelGrid;
    NSInteger *rangePrimality;
    NSInteger startingValue;
}

- (id)initWithPrimesSieve:(PrimesSieve *)aPrimesSieve reuseIdentifier:(NSString *)aReuseIdentifier;
- (void)setStartingValue:(NSInteger)aStartingValue;
- (void)refreshCells;
- (void)onPrimesSieveUpdateNotification:(NSNotification *)notification;

@property (readwrite, assign) PrimesSieve *primesSieve;
@property (readonly, retain) NSMutableArray *primesLabelGrid;
@property (readwrite, assign) NSInteger startingValue;

@end
