//
//  ReadOperation.m
//  Book-Operation
//
//  Created by Jakub Hladík on 28.11.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import "ReadOperation.h"
#import <AddressBook/AddressBook.h>
#import "Person.h"

@implementation ReadOperation
{
    BOOL _isConcurrent;
    BOOL _isExecuting;
    BOOL _isFinished;
}


- (id)initWithName:(NSString *)aName
{
    NSLog(@"%@: init", aName);
    self = [super init];
    if (self) {
        _isConcurrent = YES;
        _isExecuting = NO;
        _isFinished = NO;
        
        _name = aName;
        _people = [NSMutableArray array];
    }
    
    return self;
}

- (BOOL)isConcurrent
{
    NSLog(@"%@: isConcurrent", _name);
    return _isConcurrent;
}

- (BOOL)isFinished
{
    NSLog(@"%@: isFinished %d", _name, _isFinished);
    return _isFinished;
}

- (void)start
{
    NSLog(@"%@: start", _name);
    [self performSelectorInBackground:@selector(main) withObject:nil];
}

- (void)beginOperation
{
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)endOperation
{
    NSLog(@"%@: finish", _name);
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    _isExecuting = NO;
    _isFinished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (void)main
{
    NSLog(@"%@: main", _name);
    if ([self isCancelled]) {
        NSLog(@"%@: canceled", _name);
        [self endOperation];
        return;
    }
    
    [self beginOperation];
    
    [self getABInfo];
    
    [self endOperation];
}

- (void)addPerson:(Person *)aPerson
{
    [_people addObject:aPerson];
}

- (void)getABInfo
{
    CFErrorRef errorRef;
    ABAddressBookRef abRef = ABAddressBookCreateWithOptions(NULL, &errorRef);
    
    __block BOOL accessGranted;
    ABAddressBookRequestAccessWithCompletion(abRef, ^(bool granted, CFErrorRef error) {
        accessGranted = granted;
        if (error) {
            NSLog(@"%@", (__bridge NSString *)error);
        }
    });
    
    if (!accessGranted) {
        return;
    }
    
    CFArrayRef peopleRef = ABAddressBookCopyArrayOfAllPeople(abRef);
    for (CFIndex i = 0; i < CFArrayGetCount(peopleRef); i++) {
        ABRecordRef recordRef = CFArrayGetValueAtIndex(peopleRef, i);
        
        NSString *first = (__bridge NSString *)ABRecordCopyValue(recordRef, kABPersonFirstNameProperty);
        NSString *last = (__bridge NSString *)ABRecordCopyValue(recordRef, kABPersonLastNameProperty);
        
        Person *person = [[Person alloc] init];
        person.firstName = first;
        person.lastName = last;
        
        [self addPerson:person];
    }
    
    
    CFRelease(peopleRef);
    CFRelease(abRef);
}

@end
