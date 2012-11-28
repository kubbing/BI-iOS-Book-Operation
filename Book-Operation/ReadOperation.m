//
//  ReadOperation.m
//  Book-Operation
//
//  Created by Jakub Hladík on 28.11.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import "ReadOperation.h"

@implementation ReadOperation
{
    BOOL _isExecuting;
    BOOL _isFinished;
    BOOL _isCanceled;
}

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isExecuting
{
    return _isExecuting;
}

- (BOOL)isFinished
{
    return _isFinished;
}

- (id)initWithName:(NSString *)aName
{
    self = [super init];
    if (self) {
        _name = aName;
    }
    return self;
}

- (void)cancel
{
    _isCanceled = YES;
}

//- (void)start
//{
//    [self performSelectorInBackground:@selector(main) withObject:nil];
//}

- (void)startOperation
{
    NSLog(@"%@ startOperation", _name);
    
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)finishOperation
{
    NSLog(@"%@ finishOperation", _name);
    
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = NO;
    [self didChangeValueForKey:@"isExecuting"];
    
    [self willChangeValueForKey:@"isFinished"];
    _isFinished = YES;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)main
{
    NSLog(@"%@ main", _name);
    
    if ([self isCancelled]) {
        NSLog(@"%@ isCancelled", _name);
        [self finishOperation];
        return;
    }
    
    [self startOperation];
    
    /*
     
     */
    system("sleep 2");
    
    [self finishOperation];   
}

@end
