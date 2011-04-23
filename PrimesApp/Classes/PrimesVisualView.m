//
//  PrimesVisualView.m
//  PrimesApp
//
//  Created by Brady Law on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PrimesVisualView.h"


@implementation PrimesVisualView

@synthesize primesSieve;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    NSInteger width = 320;
    NSInteger height = 331;
    NSInteger pixels = width*height;
    // TODO: This is a dangerous call, we need to have a lock to avoid data races. Also, this code 
    // needs to be reorganized. Why is everything linking to the TableViewController?
    
    NSInteger *rangeDivisorsArray = [primesSieve rangeDivisorsArray];
    NSInteger range = [primesSieve range];
    NSInteger pixelsUsed = (pixels < range) ? pixels : range;
    
    // If we have more data than pixels, we'll just take a subset of the data.
    for (NSInteger p = 0; p < pixelsUsed; p++) {
        switch (rangeDivisorsArray[p]) {
            case 0: // Unprocessed
                // Black
                CGContextSetRGBFillColor(myContext, 0.5, 0.5, 0.5, 1);
                break;
            case 1: // Prime
                // Blue
                CGContextSetRGBFillColor(myContext, 0, 0.9, 0, 1);
                // CGContextSetRGBFillColor(myContext, 0, 0, 0.6+diff, 1);
                break;
            default:
                CGContextSetRGBFillColor(myContext, 0, 0, 0, 1);
                break;
        }
        CGContextFillRect(myContext, CGRectMake(p % width,
                                                p / height, 1, 1));
    }
}

/*
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
*/

- (void)dealloc {
    // [animationTimer invalidate];
    // [animationTimer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


@end
