//
//  PSGridCellButton.m
//  TicTacToe
//
//  Created by Justin Warmkessel on 5/23/14.
//  Copyright (c) 2014 Justin Warmkessel. All rights reserved.
//

#import "PSGridCellButton.h"

@implementation PSGridCellButton

- (id)init {
	self = [super init];
	[self setBackgroundColor:[UIColor whiteColor]];
	[self.layer setBorderColor:[[UIColor blackColor] CGColor]];
	[self.layer setBorderWidth:2.0f];
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	
	return self;
}
- (void) setFrame:(CGRect)frame	{
	
	[super setFrame:frame];
	self.titleLabel.font = [UIFont boldSystemFontOfSize: self.frame.size.height];
}
- (void)reset {
	[self setTitle:@"" forState:UIControlStateNormal];
	[self setUserInteractionEnabled: YES];
}

- (void)setPlayer: (NSNumber *) player {
	if ([player intValue] == 1) {
		[self setTitle:@"x" forState:UIControlStateNormal];
	} else {
		[self setTitle:@"o" forState:UIControlStateNormal];
	}
	[self setUserInteractionEnabled: NO];
}

@end
