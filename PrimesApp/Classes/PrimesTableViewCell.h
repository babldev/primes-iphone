//
//  PrimesTableViewCell.h
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "PrimesSieve.h"

@interface PrimesTableViewCell : UITableViewCell {
    NSInteger value;
    IntegerPrimality primality;
}

@end
