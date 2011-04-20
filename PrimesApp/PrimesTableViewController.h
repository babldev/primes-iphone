//
//  PrimesTableViewController.h
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrimesSieve.h"

@interface PrimesTableViewController : UITableViewController {
	IntegerPrimality *primeData;
	NSInteger primeDataRange;
    
    IBOutlet UIActivityIndicatorView *activityIndicator;
}

@end
