//
//  PrimesLabel.h
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrimesSieve.h"

@interface PrimesLabel : UIView {
    NSInteger value;
    NSInteger divisor;
    UIColor *normalColor;
    
    UILabel *foregroundText;
    UIImageView *backgroundImg;
    
    BOOL highlighted;
    
    PrimesSieve *primesSieve;
}

@property (readwrite, assign) NSInteger value;
@property (readwrite, assign) NSInteger divisor;
@property (readwrite, assign) BOOL highlighted;
@property (readwrite, assign) PrimesSieve *primesSieve;

@end
