//
//  PrimesSieve.h
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PrimesSieve;

typedef enum _IntegerPrimality {
    IntegerUnprocessed  = 0,
    IntegerIsPrime      = 1,
    IntegerIsComposite  = 2
} IntegerPrimality;


@protocol PrimesSieveDelegate <NSObject>
-(void)sieveCompleted;
@optional
-(void)sieveStarted;
-(void)sievePaused;
@end


@interface PrimesSieve : NSObject {
    NSInteger range;
    
    IntegerPrimality *rangeArray;
    NSMutableArray *primes;
    
    id <PrimesSieveDelegate> delegate;
    NSInteger currentlySieving;
}

@property (readonly, assign) NSInteger range;
@property (readonly, assign) IntegerPrimality *rangeArray;
@property (readonly, retain) NSMutableArray *primes;
@property (readonly, assign) NSInteger currentlySieving;
@property (nonatomic, readwrite, assign) id <PrimesSieveDelegate> delegate;

-(id)initWithRange:(NSInteger)aRange;
-(void)resetWithRange:(NSInteger)aRange;

-(void)startSieve;
-(void)pauseSieve;

@end
