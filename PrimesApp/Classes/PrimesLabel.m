//
//  PrimesLabel.m
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PrimesLabel.h"


@implementation PrimesLabel

@synthesize value;
@synthesize primality;

- (void)setValue:(NSInteger)aValue {
    value = aValue;
    // Show only the last 2 digits of the number
    self.text = [NSString stringWithFormat:@"%d", value % 100];
}

- (void)setPrimality:(IntegerPrimality)aPrimality {
    primality = aPrimality;
    UIColor *color = nil;
    
    switch (primality) {
        case IntegerUnprocessed:
            color = [UIColor blackColor];
            break;
        case IntegerIsPrime:
            color = [UIColor greenColor];
            break;
        case IntegerIsComposite:
            color = [UIColor grayColor];
        default:
            break;
    }
    
    self.textColor = color;
}

- (void)dealloc {
    [super dealloc];
}


@end
