//
//  PSGridCellButton.h
//  TicTacToe
//
//  Created by Justin Warmkessel on 5/23/14.
//  Copyright (c) 2014 Justin Warmkessel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSGridCellButton : UIButton

- (id)init;
- (void)setFrame:(CGRect)frame;
- (void)reset;
- (void)setPlayer: (NSNumber *) player;

@end
