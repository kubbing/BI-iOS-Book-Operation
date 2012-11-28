//
//  ReadOperation.h
//  Book-Operation
//
//  Created by Jakub Hladík on 28.11.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadOperation : NSOperation

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *people;

- (id)initWithName:(NSString *)aName;

@end
