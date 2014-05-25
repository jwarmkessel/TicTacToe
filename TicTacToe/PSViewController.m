//
//  PSViewController.m
//  TicTacToe
//
//  Created by Justin Warmkessel on 5/23/14.
//  Copyright (c) 2014 Justin Warmkessel. All rights reserved.
//

#import "PSViewController.h"
#import "PSPlayStudioAPI.h"

@interface PSViewController ()
@property (strong, nonatomic) UIButton *endGameButton;
@end

@implementation PSViewController
@synthesize gridView, gridModel, currentPlayer, endGameButton;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupGame];
	[self startGame];
    
    //Reset button.
    self.endGameButton = [[UIButton alloc] initWithFrame:CGRectMake(-300.0, 400.0, 300.0, 60.0)];
    [self.endGameButton setTitle:@"Play Again?" forState:UIControlStateNormal];
    [self.endGameButton setBackgroundColor:[UIColor redColor]];
    [self.endGameButton setAlpha:0];
    [self.view addSubview:endGameButton];
    [self.endGameButton addTarget:self action:@selector(resetGame) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupGame {
    
	self.gridModel = [[PSGridModel alloc] init];
	self.gridView = [[PSGridView alloc] init];
    [self.gridView setDelegate:self];
	[self setGridViewFrame];
	[self.view addSubview: self.gridView];
	[self.gridView buildGrid: self.gridModel.size];

    //Check if game exists.
    NSString *userId = [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"];
    if ([userId isEqualToString:@""] || userId == nil) {
        [PSPlayStudioAPI createGame];
    } else {
        [self.gridView retrieveGame];
    }
}

- (void)startGame {
	self.currentPlayer = [NSNumber numberWithInt:1];
	[self nextPlayerTurn];
}

- (void)resetGame {
    [PSPlayStudioAPI createGame];
    //Make button hidden.
    [UIView animateWithDuration:0.5 animations:^{
        [self.endGameButton setAlpha:0];
        CGRect rect = self.endGameButton.frame;
        rect.origin.x = -300;
        self.endGameButton.layer.frame = rect;
    }];
    
	[self.gridView resetButtons];
	[self.gridModel resetGrid];
	[self startGame];
}

- (void)setGridViewFrame {
	float width = self.view.bounds.size.width;
	float height = self.view.bounds.size.height;
	CGRect frame = CGRectMake(0, 0, width, height);
	[self.gridView setFrame:frame];
}

- (void)userClickedGridButton: (NSNumber *)buttonNumber {
    if ([self.currentPlayer intValue] == 2) {
        if ([self.gridModel setPlayer:[NSNumber numberWithInt:2] atGridLocation:buttonNumber]) {
            
            [self.gridView updateGridButton:buttonNumber withPlayer:[NSNumber numberWithInt:2]];
            [self endPlayerTurn];
        }
	}
}

- (void)endPlayerTurn {
    NSLog(@"endPlayerTurn");
	NSNumber *winner = [self.gridModel getWinner];
	if ([winner intValue] >= 0) { // game is over
        NSLog(@"Game is over"); 
        [PSPlayStudioAPI removeGame];
		if ([winner intValue] == 1) {
			[self.endGameButton setTitle:@"You lost, play again?" forState:UIControlStateNormal];
		} else if ([winner intValue] == 2) {
			[self.endGameButton setTitle:@"You win, play again?" forState:UIControlStateNormal];
		} else {
			[self.endGameButton setTitle:@"DRAW, play again?" forState:UIControlStateNormal];
		}
		self.currentPlayer = [NSNumber numberWithInt:0]; // no ones turn.
        
        //Make button visible.
        [UIView animateWithDuration:0.5 animations:^{
            [self.endGameButton setAlpha:1];
            CGRect rect = self.endGameButton.frame;
            rect.origin.x = 0;
            self.endGameButton.layer.frame = rect;
        }];

	} else {
		[self nextPlayerTurn];
	}
}

- (void)nextPlayerTurn {
	if ([self.currentPlayer intValue] == 1) {
		self.currentPlayer = [NSNumber numberWithInt: [self.currentPlayer intValue] + 1];
	} else {
		self.currentPlayer = [NSNumber numberWithInt: [self.currentPlayer intValue] - 1];
		[NSThread detachNewThreadSelector:@selector(startComputersTurn) toTarget:self withObject:nil];
	}
}

- (void)startComputersTurn {

	NSArray *bestMove = [PSAILogic getBestMoveForGrid: self.gridModel AndPlayer: [NSNumber numberWithInt:1] WithDepth: [NSNumber numberWithInt:0]];
	NSNumber *move = [bestMove objectAtIndex:0];
	if ([move intValue] < 0) {
		move = [self.gridModel getNextOpenSpot];
	}
	[self performSelectorOnMainThread:@selector(finishComputersTurnWithMove:) withObject:move waitUntilDone:YES];
}

- (void)finishComputersTurnWithMove: (NSNumber *)move {
	
	[self.gridModel setPlayer:[NSNumber numberWithInt:1] atGridLocation:move];
	[self.gridView updateGridButton: move withPlayer: [NSNumber numberWithInt:1]];
	[self endPlayerTurn];
}

@end
