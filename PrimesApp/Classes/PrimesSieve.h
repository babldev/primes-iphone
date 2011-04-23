//
//  PrimesSieve.h
//  PrimesApp
//
//  Created by Brady Law on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PrimesSieve;

@protocol PrimesSieveDelegate <NSObject>
-(void)sieveCompleted;
@end


@interface PrimesSieve : NSObject {
    NSInteger range;
    NSInteger selectedInt;
    
    NSInteger *rangeDivisorsArray;
    
    id <PrimesSieveDelegate> delegate;
    NSInteger currentlySieving;
}

@property (readonly, assign) NSInteger range;
@property (readonly, assign) NSInteger *rangeDivisorsArray;
@property (readonly, assign) NSInteger currentlySieving;
@property (nonatomic, readwrite, assign) id <PrimesSieveDelegate> delegate;
@property (readwrite, assign) NSInteger selectedInt;

-(id)initWithRange:(NSInteger)aRange;
-(void)resetWithRange:(NSInteger)aRange;
-(NSInteger)divisorForInt:(NSInteger)aInt;

@end
