//
//  PrimesAppDelegate.h
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrimesSieve.h"
#import "PrimesViewController.h"

@class PrimesTableViewController;

@interface PrimesAppDelegate : NSObject <UIApplicationDelegate, PrimesSieveDelegate> {
    UIWindow *window;
    PrimesViewController *viewController;
    
    PrimesSieve *primeGenerator;
    NSInteger range;
    
    NSOperation *primeGeneratorOp;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PrimesViewController *viewController;

@property (nonatomic, retain, readonly) PrimesSieve *primeGenerator;
@property (assign, readwrite) NSInteger range; 

@end

