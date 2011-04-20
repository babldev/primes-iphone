//
//  PrimesTableViewController.h
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum _IntegerPrimality {
	IntegerUnknown = 0,
	IntegerIsPrime = 1,
	IntegerIsComposite = 2
} IntegerPrimality;

@interface PrimesTableViewController : UITableViewController {
	IntegerPrimality *primeData;
	NSInteger primeDataRange;
}

@end
