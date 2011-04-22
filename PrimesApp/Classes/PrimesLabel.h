//
//  PrimesLabel.h
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "PrimesSieve.h"

@interface PrimesLabel : UILabel {
    NSInteger value;
    NSInteger divisor;
}

@property (readwrite, assign) NSInteger value;
@property (readwrite, assign) NSInteger divisor;

@end
