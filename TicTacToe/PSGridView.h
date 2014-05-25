//
//  PSGridView.h
//  TicTacToe
//
//  Created by Justin Warmkessel on 5/23/14.
//  Copyright (c) 2014 Justin Warmkessel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSGridCellButton.h"

@interface PSGridView : UIView

@property (nonatomic , retain) id delegate;
@property (nonatomic , retain) NSMutableArray *buttons;
@property (nonatomic , retain) NSNumber *gridSize;

- (id)initWithFrame:(CGRect)frame;
- (void)buildGrid:(NSNumber *)size;
- (void)buildGridPanels;
- (void)retrieveGame;
- (void)resetButtons;
- (void)updateGridButton: (NSNumber *)gridButton withPlayer: (NSNumber *) player;
- (void)onGridButtonTouch: (UIButton *)btn;

@end

@protocol PSViewControllerDelegate
- (void)userClickedGridButton: (NSNumber *)buttonNumber;

@end
