//
//  PSPlayStudioAPI.h
//  TicTacToe
//
//  Created by Justin Warmkessel on 5/24/14.
//  Copyright (c) 2014 Justin Warmkessel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSPlayStudioAPI : NSObject
+ (void)createGame;
+ (void)removeGame;
+ (void)saveGame:(NSNumber *)gridButton player:(NSNumber *)player;
+ (NSData *)retrieveGame;
@end
