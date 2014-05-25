//
//  PSAILogic.h
//  TicTacToe
//
//  Created by Justin Warmkessel on 5/24/14.
//  Copyright (c) 2014 Justin Warmkessel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSGridModel.h"

@interface PSAILogic : NSObject
+ (NSArray *)getBestMoveForGrid: (PSGridModel *)gridModel AndPlayer: (NSNumber *)player WithDepth: (NSNumber *)depth;
@end
