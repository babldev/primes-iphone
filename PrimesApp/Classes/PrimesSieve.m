//
//  PrimesSieve.m
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PrimesSieve.h"


@implementation PrimesSieve

@synthesize range, rangeDivisorsArray, primes, currentlySieving, delegate;

-(id)initWithRange:(NSInteger)aRange {
    if (self = [super init]) {
        [self resetWithRange:aRange];
    }
    return self;
}

-(void)resetWithRange:(NSInteger)aRange {
    if (rangeDivisorsArray != nil) {
        free(rangeDivisorsArray);
    }
    range = aRange;
    // We add an extra element for simplicity.
    // TODO: What if the malloc fails? We need to verify the range here.
    rangeDivisorsArray = malloc((range + 1) * sizeof(NSInteger));
    currentlySieving = 0;
}

-(void)startSieve {
    // Initialize the divisors of all integers to 0 aka Unprocessed.
    for (NSInteger i = 0; i <= range; i++) {
        rangeDivisorsArray[i] = 0;
    }
    
    currentlySieving = 0;
    // We'll start sieving with 2.
    for (NSInteger i = 2; i <= range; i++) {
        // Is this number unprocessed?
        if (rangeDivisorsArray[i] != 0) {
            continue;
        }
        
        currentlySieving = i;
        // By definition, if no positive integer <= i divides i then i is prime.
        rangeDivisorsArray[i] = 1;
        [primes addObject:[NSNumber numberWithInt:currentlySieving]];
        
        // Sieve through all multiples of the prime number.
        for (int sieve = currentlySieving * 2; sieve <= range; sieve += currentlySieving) {
            // Preserve the smallest divisor.
            if (rangeDivisorsArray[sieve] > 1) {
                continue;
            }
            rangeDivisorsArray[sieve] = currentlySieving;
        }
    }
    
    [delegate sieveCompleted];
}

-(void)pauseSieve {
}

-(NSInteger)divisorForInt:(NSInteger)aInt {
    return rangeDivisorsArray[aInt];
}

-(void)dealloc {
    free(rangeDivisorsArray);
    [primes release];
    [super dealloc];
}

@end