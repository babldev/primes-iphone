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

- (id)init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PrimeCell"];
    if (self) {
        startingValue = 1;
        primesLabelGrid = [[NSMutableArray arrayWithCapacity:PRIMES_CELL_COUNT] retain];
        
        // Initialize our grid of cells.
        for (NSInteger i = 0; i < PRIMES_CELL_COUNT; i++) {
            PrimesLabel *label = [[[PrimesLabel alloc] init] autorelease];
            [primesLabelGrid insertObject:label atIndex:i];
            [self addSubview:label];
        }
    }
    
    return self;
}

- (void)setStartingValue:(NSInteger)aStartingValue {
    startingValue = aStartingValue;
    for (NSInteger i = 0; i < PRIMES_CELL_COUNT; i++) {
        PrimesLabel *label = [primesLabelGrid objectAtIndex:i];
        [label setValue:(i+startingValue)];
    }
    
    self.textLabel.text = @"Cell here";
}

- (void)dealloc {
    [primesLabelGrid release];
    [super dealloc];
}


@end
