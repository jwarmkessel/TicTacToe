//
//  PSViewController.h
//  TicTacToe
//
//  Created by Justin Warmkessel on 5/23/14.
//  Copyright (c) 2014 Justin Warmkessel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSGridView.h"
#import "PSGridModel.h"
#import "PSAILogic.h"

@interface PSViewController : UIViewController <PSViewControllerDelegate>

@property (retain , nonatomic) PSGridModel *gridModel;
@property (retain , nonatomic) PSGridView *gridView;
@property (retain , nonatomic) NSNumber *currentPlayer;

@end
