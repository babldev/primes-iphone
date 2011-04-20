//
//  PrimesAppDelegate.h
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PrimesTableViewController;

@interface PrimesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PrimesTableViewController *primesTableViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PrimesTableViewController *primesTableViewController;

@end

