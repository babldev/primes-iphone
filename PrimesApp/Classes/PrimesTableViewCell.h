//
//  PrimesTableViewCell.h
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "PrimesLabel.h"
#include "PrimesSieve.h"

#define PRIMES_CELL_COUNT 100
#define PRIMES_CELL_WIDTH 10

@interface PrimesTableViewCell : UITableViewCell {
    NSMutableArray *primesLabelGrid;
    NSInteger *rangePrimality;
    NSInteger startingValue;
}

- (id)initWithPrimesSieve:(PrimesSieve *)aPrimesSieve reuseIdentifier:(NSString *)aReuseIdentifier;
- (void)setStartingValue:(NSInteger)aStartingValue;
- (void)refreshCells;
- (void)onPrimesSieveUpdateNotification:(NSNotification *)notification;

@property (readonly, retain) NSMutableArray *primesLabelGrid;
@property (readwrite, assign) PrimesSieve *primesSieve;

@end
