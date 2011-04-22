//
//  PrimesTableViewController.h
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrimesSieve.h"

@interface PrimesTableViewController : UITableViewController <PrimesSieveDelegate> {
	NSInteger *rangeDivisorsArray;
	NSInteger primeDataRange;
    
    PrimesSieve *primeGenerator;
    NSInteger range;
    NSOperationQueue *operationQueue;
    
    IBOutlet UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain, readonly) PrimesSieve *primeGenerator;
@property (assign, readwrite) NSInteger range; 

@end
