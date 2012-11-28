//
//  ReadOperation.m
//  Book-Operation
//
//  Created by Jakub Hladík on 28.11.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import "ReadOperation.h"

@implementation ReadOperation

- (id)initWithName:(NSString *)aName
{
    self = [super init];
    if (self) {
        _name = aName;
    }
    return self;
}

//- (void)start
//{
//    [self performSelectorInBackground:@selector(main) withObject:nil];
//}

- (void)main
{
    NSLog(@"%@ main", _name);
}

@end
