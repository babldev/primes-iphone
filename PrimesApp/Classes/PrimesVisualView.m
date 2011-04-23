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

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        // Register for integer selection notifications.
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onIntSelectedNotification:)
                                                     name:@"intSelectedNotification"
                                                   object:nil];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(myContext, false);
    
    // TODO: This is a dangerous call, we need to have a lock to avoid data races. Also, this code 
    // needs to be reorganized. Why is everything linking to the TableViewController?
    
    NSInteger *rangeDivisorsArray = [primesSieve rangeDivisorsArray];
    NSInteger range = [primesSieve range];
    
    CGSize viewSize = self.bounds.size;
    NSInteger width = viewSize.width;
    NSInteger height = viewSize.height;
    NSInteger pixels = width*height;
    NSInteger pixelsUsed = (range < pixels) ? range : pixels;
        
    // If we have more data than pixels, we'll just take a subset of the data.
    NSInteger p = 0;
    for (NSInteger y = 0; y < height; y++) {
        for (NSInteger x = 0; x < width; x++) {
            if (p >= range) {
                break;
            }
            if (rangeDivisorsArray[p] == 1) {
                CGContextSetRGBFillColor(myContext, 0, 0.9, 0, 1);
                CGContextFillRect(myContext, CGRectMake(x, y, 1, 1));
            }
            p++;
        }
    }
    
    // TODO: Fix this
    NSInteger selectedInt = primesSieve.selectedInt;
    if (selectedInt >= 0 && selectedInt <= pixelsUsed) {
        // Draw red crosshair
        CGContextSetRGBFillColor(myContext, 1, 0, 0, 0.8);
        // Horizontal line
        CGContextFillRect(myContext, CGRectMake(0, selectedInt / width, width, 1));
        // Vertical line
        CGContextFillRect(myContext, CGRectMake(selectedInt % width, 0, 1, height));
    }
}

#pragma mark UIResponder
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        if (touch.tapCount >= 1) {
            CGPoint point = [touch locationInView:self];
            primesSieve.selectedInt = point.x + point.y * self.bounds.size.width;
            break;
        }
    }
}

#pragma mark -
#pragma mark integerSelectedNotification handler
- (void)onIntSelectedNotification:(NSNotification *)notification {
    [self setNeedsDisplay];
}


- (void)dealloc {
    // [animationTimer invalidate];
    // [animationTimer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


@end
