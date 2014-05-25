//
//  PSGridModel.m
//  TicTacToe
//
//  Created by Justin Warmkessel on 5/23/14.
//  Copyright (c) 2014 Justin Warmkessel. All rights reserved.
//

#import "PSGridModel.h"

@implementation PSGridModel

@synthesize grid, size, solves;

- (id)init {
	return [self initWithSize: [NSNumber numberWithUnsignedInt: 3]];
}

- (id)initWithSize:(NSNumber *) gridSize {
	self = [super init];
	self.size = gridSize;
	unsigned int fullSize = [gridSize unsignedIntValue] * [gridSize unsignedIntValue];
	self.grid = [NSMutableArray arrayWithCapacity: fullSize];
	for (int i = 0; i < fullSize; i++) {
		[self.grid insertObject:[NSNumber numberWithInt:0] atIndex:i];
	}
	[self createSolvables];
	
	return self;
}

- (void)resetGrid {
	for (int i = 0; i < [self.grid count]; i++) {
		[self.grid replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:0]];
	}
}

- (BOOL)setPlayer: (NSNumber *)player atGridLocation: (NSNumber *)location {
    NSLog(@"gridModel setPlayer %d", [player intValue]);
    
	NSNumber *playerInSpace = [self.grid objectAtIndex: [location unsignedIntValue]];
	if ([playerInSpace isEqualToNumber: [NSNumber numberWithInt:0]]) {
		[self.grid replaceObjectAtIndex:[location unsignedIntValue] withObject:player];
		return YES;
	}
	return NO;
}

- (void)createSolvables {
	int gridSize = [self.size intValue];
	int solveSize = gridSize * 2 + 2;
	self.solves = [NSMutableArray arrayWithCapacity: solveSize];
	int y;
	int x;
	NSMutableArray *innerSolve; // solveable
	for(x=0; x < solveSize; x++) { // init them all up
		[self.solves addObject: [NSMutableArray arrayWithCapacity: gridSize]]; // pre init hte size, cause we know it.
	}
	for(x = 0; x < gridSize; x++) {
		for(y = 0; y < gridSize; y++) {
			
			innerSolve = [self.solves objectAtIndex:x];// X axis solves
			[innerSolve addObject: [NSNumber numberWithInt:(x * gridSize) + y]];
			
			innerSolve = [self.solves objectAtIndex: gridSize + y];// Y axis solves
			[innerSolve addObject: [NSNumber numberWithInt:(x * gridSize) + y]];
			
			if (x == y) {
				innerSolve = [self.solves objectAtIndex: gridSize * 2]; // top left going down diagnoally
				[innerSolve addObject: [NSNumber numberWithInt:(x * gridSize) + y]];
			}
			
			if ((x + y) == (gridSize - 1)) {
				innerSolve = [self.solves objectAtIndex: gridSize * 2 + 1]; // top right
				[innerSolve addObject: [NSNumber numberWithInt: x * gridSize + y]];
			}
		}
	}
}

- (NSNumber *)getWinner {
	int i;
	int j;
	NSMutableArray *solve;
	NSNumber *location;
	int player;
	int gridPlayer;
	NSNumber *gridLocationPlayer;
	for(i = 0; i < [self.solves count]; i++) {
		solve = [self.solves objectAtIndex:i];
		player = 0;
		for(j = 0; j < [solve count]; j++) {
			location = [solve objectAtIndex:j];
			gridLocationPlayer = [self.grid objectAtIndex: [location unsignedIntValue]];
			gridPlayer = [gridLocationPlayer intValue];
			if (gridPlayer == 0) {
				player = 0;
				break;
			}
			if (player > 0 && player != gridPlayer) {
				player = 0;
				break;
			} else {
				player = gridPlayer;
			}
		}
		
		if (player > 0) {
			return [NSNumber numberWithInt: player];
		}
	}
	/// check if its draw, or still in progress
	for (i = 0; i < [self.grid count]; i++) {
		if ([[self.grid objectAtIndex: i] intValue] == 0) {
			return [NSNumber numberWithInt: -1]; // -1 = in progress
		}
	}
	return [NSNumber numberWithInt: 0]; // 0 = draw
}

- (NSNumber *)getNextOpenSpot {
	int i = 0;
	int c = (int)[self.grid count];
	NSNumber *playerAtGridLocation;
	for (i = 0; i < c; i++) {
		playerAtGridLocation = [self.grid objectAtIndex:i];
		if ([playerAtGridLocation intValue] == 0) {
			return [NSNumber numberWithInt:i];
		}
	}
	return [NSNumber numberWithInt:-1];
}

@end
