//
//  DRSynchronizedArrayList.m
//  DRUtils
//
//  Created by Florin on 2/2/16.
//  Copyright © 2016 Florin. All rights reserved.
//

#import "DRSynchronizedArrayList.h"

@implementation DRSynchronizedArrayList

// Adds an item
- (BOOL) add:(id)item {
    @synchronized(self) {
        return [super add:item];
    }
}

// Adds an item at index
- (BOOL) addAtIndex:(NSUInteger)index item:(id)item {
    @synchronized(self) {
        return [super addAtIndex:index item:item];
    }
}

// Clears the list
- (void) clear {
    @synchronized(self) {
        [super clear];
    }
}

// Returns the element at index
- (id) get: (NSUInteger)index {
    @synchronized(self) {
        return [super get:index];
    }
}

// Returns the index of the specified item
- (NSUInteger) indexOf:(id)item {
    @synchronized(self) {
        return [super indexOf:item];
    }
}

// Looks for an item
- (BOOL) contains:(id)item {
    @synchronized(self) {
        return [super contains:item];
    }
}

// Removes an item
- (BOOL) remove:(id)item {
    @synchronized(self) {
        return [super remove:item];
    }
}

// Adds an item at index
- (BOOL) removeAtIndex:(NSUInteger)index {
    @synchronized(self) {
        return [super removeAtIndex:index];
    }
}

// Returns the size
- (NSUInteger) size {
    @synchronized(self) {
        return [super size];
    }
}

// Returns the list as array (preferably immutable).
- (NSArray*)toArray {
    @synchronized(self) {
        return [super toArray];
    }
}

@end
