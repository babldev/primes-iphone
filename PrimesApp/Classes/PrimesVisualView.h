//
//  PrimesVisualView.h
//  PrimesApp
//
//  Created by Brady Law on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrimesSieve.h"

@class PrimesViewController;

@interface PrimesVisualView : UIView {
    PrimesSieve *primesSieve;
}

@property (assign, readwrite) PrimesSieve *primesSieve;


@end
