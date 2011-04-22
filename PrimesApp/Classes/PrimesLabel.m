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
@synthesize divisor;

- (id)initWithFrame:(CGRect)aRect {
	if (self = [super initWithFrame:aRect]) {
		self.textAlignment = UITextAlignmentCenter;
	}
	
	return self;
}

- (void)setValue:(NSInteger)aValue {
    value = aValue;
    // Show only the last 2 digits of the number
	NSInteger displayDigits = value % 100;
	if (displayDigits < 10 && value >= 100) {
		self.text = [NSString stringWithFormat:@"0%d", displayDigits];
	} else {
		self.text = [NSString stringWithFormat:@"%d", displayDigits];
	}
}

- (void)setDivisor:(NSInteger)aDivisor {
    divisor = aDivisor;
    UIColor *color = nil;
    UIColor *bgColor = nil;
    
    switch (aDivisor) {
        case 0: // Unprocessed
            color = [UIColor blackColor];
            bgColor = [UIColor whiteColor];
            break;
        case 1: // Prime
            color = [UIColor blackColor];
            bgColor = [UIColor greenColor];
            break;
        default: // Composite
            color = [UIColor grayColor];
            bgColor = [UIColor whiteColor];
            break;
    }
    
    self.textColor = color;
    self.backgroundColor = bgColor;
}

- (void)dealloc {
    [super dealloc];
}


@end
