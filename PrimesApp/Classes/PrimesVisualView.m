//
//  PrimesVisualView.m
//  PrimesApp
//
//  Created by Brady Law on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PrimesVisualView.h"


@implementation PrimesVisualView

@synthesize primesTableViewController;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    NSInteger width = 320;
    NSInteger height = 480;
    
    // TODO: This is a dangerous call, we need to have a lock to avoid data races. Also, this code 
    // needs to be reorganized. Why is everything linking to the TableViewController?
    
    PrimesSieve *sieve = self.primesTableViewController.primeGenerator;
    NSInteger *rangeDivisorsArray = [sieve rangeDivisorsArray];
    NSInteger range = [sieve range];
    
    
    CGSize viewSize = self.bounds.size;
    NSInteger screenPixels = viewSize.width * viewSize.height;
    
    // If we have more data than pixels, we'll just take a subset of the data.
    NSInteger dataStepSize = 1;
    if (range > screenPixels) {
        dataStepSize = range / screenPixels;
    }

    NSInteger pixel = 0;
    for (NSInteger i = 1; i < range; i += dataStepSize) {
        pixel++;
        NSInteger colorSeed;
        NSInteger colorSeed2;
        NSInteger colorSeed3;
        CGFloat blue;
        CGFloat green;
        CGFloat red;
        switch (rangeDivisorsArray[i]) {
            case 0: // Unprocessed
                // Black
                CGContextSetRGBFillColor(myContext, 0, 0, 0, 1);
                break;
            case 1: // Prime
                // Blue
                CGContextSetRGBFillColor(myContext, 0, 1.0, 0, 1);
                // CGContextSetRGBFillColor(myContext, 0, 0, 0.6+diff, 1);
                break;
            default:
                // Black-White gradient depending on divisor.
                
                colorSeed = rangeDivisorsArray[i] % 100;
                colorSeed2 = rangeDivisorsArray[i] % 50;
                colorSeed3 = rangeDivisorsArray[i] % 25;
                red = ((CGFloat) colorSeed3 / 25) * 0.4;
                blue = 0.3 + ((CGFloat) colorSeed / 100) * 0.7;
                green = ((CGFloat) colorSeed2 / 50) * 0.4;
                CGContextSetRGBFillColor(myContext, red, green, blue, 1);
                 
                // CGContextSetRGBFillColor(myContext, 0, 0, 0, 1);
                break;
        }
        CGContextFillRect(myContext, CGRectMake(pixel % width,
                                                pixel / height, 1, 1));
    }
}

- (void)animateOnTimer:(NSTimer *)theTimer {
    [self setNeedsDisplay];
}

-(void)startAnimation {
    if (animationTimer == nil) {
        animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.016 target:self selector:@selector(animateOnTimer) userInfo:nil repeats:YES];
    }
}

-(void)stopAnimation {
    if (animationTimer != nil) {
        [animationTimer invalidate];
        animationTimer = nil;
    }
}

- (void)dealloc {
    [animationTimer invalidate];
    [animationTimer release];
    [super dealloc];
}


@end
