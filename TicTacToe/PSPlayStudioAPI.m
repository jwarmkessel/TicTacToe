//
//  PSPlayStudioAPI.m
//  TicTacToe
//
//  Created by Justin Warmkessel on 5/24/14.
//  Copyright (c) 2014 Justin Warmkessel. All rights reserved.
//

#import "PSPlayStudioAPI.h"
#import "PSGridModel.h"

#define BASE_URI @"http://www.goosii.com:3100"

@implementation PSPlayStudioAPI

+ (void)createGame {
    NSString *urlStr = [NSString stringWithFormat:@"%@/createGame", BASE_URI];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    NSError *NSURLConnectionError = nil;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
                               if(!NSURLConnectionError) {
                                   NSString* userId = [[NSString alloc] initWithData:data
                                                                     encoding:NSASCIIStringEncoding];
                
                                   userId = [userId stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                                   [[NSUserDefaults standardUserDefaults]setObject:userId forKey:@"userId"];
                                   NSLog(@"server response: %@", userId);                                   
                               } else {
                                   NSLog(@"NSURLConnection Error");
                               }
                           }];
}

+ (void)removeGame {
    NSString *urlStr = [NSString stringWithFormat:@"%@/removeGame/%@", BASE_URI, [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"]];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    NSError *NSURLConnectionError = nil;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               if(!NSURLConnectionError) {
                                   [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
                                   NSString* response = [[NSString alloc] initWithData:data
                                                                            encoding:NSASCIIStringEncoding];
                                   
                                   NSLog(@"server response: %@", response);
                               } else {
                                   NSLog(@"NSURLConnection Error");
                               }
                           }];

}

+ (void)saveGame:(NSNumber *)gridButton player:(NSNumber *)player {
    NSString *urlStr = [NSString stringWithFormat:@"%@/saveGame/%@/%@/%@", BASE_URI, [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"], [player stringValue], [gridButton stringValue]];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    NSError *NSURLConnectionError = nil;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        if(!NSURLConnectionError) {
        NSString* responseString = [[NSString alloc] initWithData:data
                                                         encoding:NSASCIIStringEncoding];

            NSLog(@"server response: %@", responseString);
        } else {
            NSLog(@"NSURLConnection Error");
        }
    }];
}

+ (NSData *)retrieveGame {
    NSString *urlStr = [NSString stringWithFormat:@"%@/retrieveGame/%@", BASE_URI, [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"]];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    NSURLResponse* response = nil;
    NSError *error = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    if(!error) {
        // your data or an error will be ready here
        NSString* newStr = [[NSString alloc] initWithData:data
                                                 encoding:NSUTF8StringEncoding];
        
        NSLog(@"ReceivedData %@", newStr);
        
        return data;
    }
    return nil;
}
@end
