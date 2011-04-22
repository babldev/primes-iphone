//
//  PrimesTableViewCell.m
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PrimesTableViewCell.h"

@implementation PrimesTableViewCell

@synthesize primesLabelGrid;
@synthesize primesSieve;

- (id)initWithPrimesSieve:(PrimesSieve*)aPrimesSieve reuseIdentifier:(NSString*)aReuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aReuseIdentifier];
	
    if (self) {
        self.primesSieve = aPrimesSieve;
        
        CGFloat cellWidth = self.bounds.size.width;
        // TODO: This is hack, we are getting the wrong height for some reason.
        CGFloat cellHeight = cellWidth / PRIMES_CELL_COUNT;
        
        startingValue = 1;
        primesLabelGrid = [[NSMutableArray arrayWithCapacity:PRIMES_CELL_COUNT] retain];
        
        // Initialize our grid of cells.
        for (NSInteger i = 0; i < PRIMES_CELL_COUNT; i++) {
			CGRect frame = CGRectMake(
                    i * (cellWidth / PRIMES_CELL_COUNT), 
                    0,
                    cellWidth / PRIMES_CELL_COUNT,
                    cellHeight);
            PrimesLabel *label = [[[PrimesLabel alloc] initWithFrame:frame] autorelease];
            [primesLabelGrid insertObject:label atIndex:i];
			
            [self addSubview:label];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onPrimesSieveUpdateNotification:)
                                                     name:@"primeSieveUpdateNotification"
                                                   object:nil];
    }
    
    return self;
}

- (void)setStartingValue:(NSInteger)aStartingValue {
    startingValue = aStartingValue;
    for (NSInteger i = 0; i < PRIMES_CELL_COUNT; i++) {
        PrimesLabel *label = [primesLabelGrid objectAtIndex:i];
        [label setValue:(i+startingValue)];
    }
    [self refreshCells];
}

- (void)refreshCells {
    NSEnumerator *gridEnumerator = [primesLabelGrid objectEnumerator];
    PrimesLabel *label;
    while (label = (PrimesLabel *) [gridEnumerator nextObject]) {
        label.divisor = [primesSieve divisorForInt:label.value];
    }
}

#pragma mark -
#pragma mark primeSieveUpdateNotification handler
- (void)onPrimesSieveUpdateNotification:(NSNotification *)notification {
    [self refreshCells];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
    [primesLabelGrid release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


@end
