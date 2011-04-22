//
//  PrimesSieve.h
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef _PRIMESSIEVE_H
#define _PRIMESSIEVE_H

#import <Foundation/Foundation.h>

@class PrimesSieve;

@protocol PrimesSieveDelegate <NSObject>
-(void)sieveCompleted;
@optional
-(void)sieveStarted;
-(void)sievePaused;
@end


@interface PrimesSieve : NSObject {
    NSInteger range;
    
    NSInteger *rangeDivisorsArray;
    NSMutableArray *primes;
    
    id <PrimesSieveDelegate> delegate;
    NSInteger currentlySieving;
}

@property (readonly, assign) NSInteger range;
@property (readonly, assign) NSInteger *rangeDivisorsArray;
@property (readonly, retain) NSMutableArray *primes;
@property (readonly, assign) NSInteger currentlySieving;
@property (nonatomic, readwrite, assign) id <PrimesSieveDelegate> delegate;

-(id)initWithRange:(NSInteger)aRange;
-(void)resetWithRange:(NSInteger)aRange;
-(NSInteger)divisorForInt:(NSInteger)aInt;

-(void)startSieve;
-(void)pauseSieve;

@end

#endif
