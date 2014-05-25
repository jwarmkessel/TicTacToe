//
//  PSAILogic.m
//  TicTacToe
//
//  Created by Justin Warmkessel on 5/24/14.
//  Copyright (c) 2014 Justin Warmkessel. All rights reserved.
//

#import "PSAILogic.h"


@implementation PSAILogic
+ (NSArray *)getBestMoveForGrid: (PSGridModel *)gridModel AndPlayer: (NSNumber *)player WithDepth: (NSNumber *)depth {
	int i;
	int gridCount =(int)[gridModel.grid count];
	int gridHuge = gridCount * gridCount;
	
	NSNumber *bestMove = [NSNumber numberWithInt:-1];
	NSNumber *bestScore = [NSNumber numberWithInt:([player intValue] == 1 ? -gridHuge : gridHuge)];
	NSNumber *move;
	NSNumber *score;
	NSNumber *winner;
	NSArray *results;
	NSNumber *playerAtGridLocation;
    
	for (i = 0; i < gridCount; i++) {
		playerAtGridLocation = [gridModel.grid objectAtIndex:i];
		if ([playerAtGridLocation intValue] == 0) { // no one in there.
			[gridModel.grid replaceObjectAtIndex:i withObject:player]; // replace
			winner = [gridModel getWinner];
			if ([winner intValue] > 0) {
				score = ([player intValue] == 1 ? [NSNumber numberWithInt:[depth intValue] * -1] : [NSNumber numberWithInt:[depth intValue]]);
				move = [NSNumber numberWithInt:i];
			} else {
				results = [PSAILogic getBestMoveForGrid: gridModel
											  AndPlayer: ([player intValue] == 1 ? [NSNumber numberWithInt:2] : [NSNumber numberWithInt:1])
											  WithDepth: [NSNumber numberWithInt:[depth intValue] + 1]];
				move = [results objectAtIndex:0];
				score = [results objectAtIndex:1];
			}
			if ([player intValue] == 1 ? [score intValue] > [bestScore intValue] : [score intValue] < [bestScore intValue]) {
				bestScore = score;
				bestMove = move;
			}
			
			[gridModel.grid replaceObjectAtIndex:i withObject:playerAtGridLocation]; // replace
		}
		
	}
	return [NSArray arrayWithObjects: bestMove , bestScore , nil];
	
}


@end
