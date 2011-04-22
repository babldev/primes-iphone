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
        self.userInteractionEnabled = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onIntSelectedNotification:)
                                                     name:@"intSelectedNotification"
                                                   object:nil];
        self.highlightedTextColor = [UIColor redColor];
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
            color = [UIColor grayColor];
            bgColor = [UIColor clearColor];
            break;
        case 1: // Prime
            color = [UIColor blackColor];
            bgColor = [UIColor greenColor];
            break;
        default: // Composite
            color = [UIColor whiteColor];
            bgColor = [UIColor clearColor];
            break;
    }
    
    self.textColor = normalColor = color;
    self.backgroundColor = bgColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        if (touch.tapCount >= 1) {
            // Let the app know this integer was selected.
            NSNotification *intSelectedNotification = [NSNotification notificationWithName:@"intSelectedNotification" object:[NSNumber numberWithInt:self.value]];
            [[NSNotificationQueue defaultQueue] enqueueNotification:intSelectedNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
            self.highlighted = YES;
        }
    }
}

#pragma mark -
#pragma mark integerSelectedNotification handler
- (void)onIntSelectedNotification:(NSNotification *)notification {
    NSNumber *numberSelected = (NSNumber *) [notification object];    
    if ([numberSelected intValue] == self.value) {
        self.highlighted = YES;
    } else {
        self.highlighted = NO;
    }
}

- (void)dealloc {
    [super dealloc];
}


@end
