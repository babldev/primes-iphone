//
//  PrimesSieve.m
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PrimesSieve.h"


@implementation PrimesSieve

@synthesize range, rangeArray, primes, currentlySieving, delegate;

-(id)initWithRange:(NSInteger)aRange {
    if (self = [super init]) {
        [self resetWithRange:aRange];
    }
    return self;
}

-(void)resetWithRange:(NSInteger)aRange {
    if (rangeArray != nil) {
        free(rangeArray);
    }
    // We use calloc to init all elements in the array to IntegerUnprocessed.
    rangeArray = calloc(range + 1, sizeof(IntegerPrimality));
    // TODO: What if the malloc fails? We need to verify the range here.
    
    range = aRange;
    currentlySieving = 0;
}

-(void)startSieve {
    if (range >= 2) {
        // We'll just call 0 and 1 composite for simplicity.
        rangeArray[0] = rangeArray[1] = IntegerIsComposite;
    }
    // TODO: This needs to be a concurrent operation.
    currentlySieving = 0;
    
    for (int i = 0; i <= range; i++) {
        if (rangeArray[currentlySieving] != IntegerUnprocessed) {
            continue;
        }
        
        currentlySieving = i;
        // By definition, if no positive integer <= i divides i then i is prime.
        rangeArray[currentlySieving] = IntegerIsPrime;
        [primes addObject:[NSNumber numberWithInt:currentlySieving]];
        
        // Sieve through all multiples of the prime number.
        for (int sieve = 0; sieve <= range; sieve += currentlySieving) {
            rangeArray[sieve] = IntegerIsComposite;
        }
    }
}

-(void)pauseSieve {
}

-(void)dealloc {
    free(rangeArray);
    [primes release];
    [super dealloc];
}

@end