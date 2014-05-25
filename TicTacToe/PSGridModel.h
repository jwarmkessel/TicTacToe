//
//  PSGridModel.h
//  TicTacToe
//
//  Created by Justin Warmkessel on 5/23/14.
//  Copyright (c) 2014 Justin Warmkessel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSGridModel : NSObject

@property (nonatomic , retain) NSMutableArray *grid;
@property (nonatomic , retain) NSMutableArray *solves;
@property (nonatomic , retain) NSNumber *size;

- (id)init;
- (id)initWithSize:(NSNumber *) gridSize;
- (void)resetGrid;
- (BOOL)setPlayer: (NSNumber *)player atGridLocation: (NSNumber *)location;
- (void)createSolvables;
- (NSNumber *)getWinner;
- (NSNumber *)getNextOpenSpot;

@end
