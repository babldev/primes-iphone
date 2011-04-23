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
@synthesize highlighted;
@synthesize primesSieve;

- (id)initWithFrame:(CGRect)aRect {
	if (self = [super initWithFrame:aRect]) {
        foregroundText = [[UILabel alloc] initWithFrame:self.bounds];
        foregroundText.textAlignment = UITextAlignmentCenter;
        foregroundText.userInteractionEnabled = YES;
        foregroundText.highlightedTextColor = [UIColor redColor];
        
        backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(1, 2, self.bounds.size.width - 2, self.bounds.size.height - 2)];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"primebg" ofType:@"png"];
        backgroundImg.image = [UIImage imageWithContentsOfFile:imagePath];
        
        [self addSubview:backgroundImg];
        [self addSubview:foregroundText];
        
		[[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onIntSelectedNotification:)
                                                     name:@"intSelectedNotification"
                                                   object:nil];
	}
	
	return self;
}
- (void)setValue:(NSInteger)aValue {
    value = aValue;
    // Show only the last 2 digits of the number
	NSInteger displayDigits = value % 100;
	if (displayDigits < 10 && value >= 100) {
		foregroundText.text = [NSString stringWithFormat:@"0%d", displayDigits];
	} else {
		foregroundText.text = [NSString stringWithFormat:@"%d", displayDigits];
	}
    
    self.highlighted = (primesSieve.selectedInt == value);
}

- (void)setHighlighted:(BOOL)aBool {
    highlighted = aBool;
    if (highlighted) {
        foregroundText.highlighted = YES;
    } else {
        foregroundText.highlighted = NO;
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
            backgroundImg.hidden = YES;
            break;
        case 1: // Prime
            color = [UIColor blackColor];
            bgColor = [UIColor clearColor];
            backgroundImg.hidden = NO;
            break;
        default: // Composite
            color = [UIColor whiteColor];
            bgColor = [UIColor clearColor];
            backgroundImg.hidden = YES;
            break;
    }
    
    foregroundText.textColor = normalColor = color;
    foregroundText.backgroundColor = bgColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        if (touch.tapCount >= 1) {
            primesSieve.selectedInt = value;
            break;
        }
    }
}

#pragma mark -
#pragma mark integerSelectedNotification handler
- (void)onIntSelectedNotification:(NSNotification *)notification {
    self.highlighted = (primesSieve.selectedInt == value);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [foregroundText release];
    [backgroundImg release];
    [super dealloc];
}


@end
