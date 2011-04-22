//
//  PrimesVisualView.h
//  PrimesApp
//
//  Created by Brady Law on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "PrimesTableViewController.h"

@interface PrimesVisualView : UIView {
    NSTimer *animationTimer;
}

@property (nonatomic, assign) IBOutlet PrimesTableViewController *primesTableViewController;

-(void)startAnimation;
-(void)stopAnimation;

@end
