//
//  PSGridView.m
//  TicTacToe
//
//  Created by Justin Warmkessel on 5/23/14.
//  Copyright (c) 2014 Justin Warmkessel. All rights reserved.
//

#import "PSGridView.h"
#import "PSPlayStudioAPI.h"

@implementation PSGridView
@synthesize delegate , buttons, gridSize;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)buildGrid:(NSNumber *)size {
	self.gridSize = size;
	int panelsCount = [size intValue] * [size intValue];
	int i;
	self.buttons = [NSMutableArray arrayWithCapacity:panelsCount];
	PSGridCellButton *btn;
	for (i = 0; i < panelsCount; i++) {
		btn = [[PSGridCellButton alloc] init];
		[btn addTarget:self action:@selector(onGridButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:btn];
		[self.buttons addObject:btn];
	}
    
	[self buildGridPanels];
}

- (void)buildGridPanels {
	PSGridCellButton *btn;
    
    float top = 0;
	float left = 0;
	float size = self.frame.size.width;
    
	float btnSize = size / [self.gridSize floatValue];
	
    int i;
    for(i = 0; i < [self.buttons count]; i++) {
        btn = [self.buttons objectAtIndex:i];
		[btn setFrame: CGRectMake((i % [self.gridSize intValue] * btnSize) + left, (floor(i / [self.gridSize floatValue]) * btnSize) + top, btnSize, btnSize)];
	}
}

- (void)retrieveGame {
    NSData * gameSettings = [PSPlayStudioAPI retrieveGame];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:gameSettings
                                                        options:kNilOptions
                                                          error:&error];
    
    NSArray* gameState = [json objectForKey:@"gameState"];
    
    for (NSDictionary * button in gameState) {
        NSString * player = [button objectForKey:@"player"];
        NSString * gridButton = [button objectForKey:@"gridButton"];
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        
        NSNumber * playerNum = [f numberFromString:player];
        
        [[self.buttons objectAtIndex:[gridButton intValue]] setPlayer: playerNum];
    }
}

- (void)resetButtons {
	int i;
	for (i = 0; i < [self.buttons count]; i++) {
		[[self.buttons objectAtIndex:i] reset];
	}
}

- (void)updateGridButton: (NSNumber *)gridButton withPlayer: (NSNumber *) player {

    //Update game state on server.
    [PSPlayStudioAPI saveGame:gridButton player:player];
    //Draw on selected button.
	[[self.buttons objectAtIndex:[gridButton intValue]] setPlayer: player];
	
}

- (void)onGridButtonTouch: (UIButton *)btn {
	NSNumber *i = [NSNumber numberWithUnsignedInt: (int)[self.buttons indexOfObject: btn]];
    [self.delegate userClickedGridButton: i];
}

@end
