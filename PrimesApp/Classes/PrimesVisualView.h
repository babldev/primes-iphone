//
//  PrimesVisualView.h
//  PrimesApp
//
//  Created by Brady Law on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "PrimesSieve.h"

@interface PrimesVisualView : UIView {
   // NSTimer *animationTimer;
    PrimesSieve *primesSieve;
}

@property (assign, readwrite) PrimesSieve *primesSieve;

//-(void)startAnimation;
//-(void)stopAnimation;

@end
