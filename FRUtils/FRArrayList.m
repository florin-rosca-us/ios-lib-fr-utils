//
//  FRArrayList.m
//  FRUtils
//
//  Created by Florin Rosca on 2/1/16.
//  Copyright © 2016 Florin Rosca. All rights reserved.
//
//  A Java-style array list using an internal NSMutableArray.
//  See https://docs.oracle.com/javase/7/docs/api/java/util/ArrayList.html
//

#import "FRConstants.h"
#import "FRArrayList.h"

#pragma mark - FRArrayList class
@implementation FRArrayList


+ (instancetype) listWithCapacity:(NSUInteger)capacity {
    return [[self alloc] initWithCapacity:capacity];
}

+ (instancetype) listWithList:(NSObject <FRList> *)list {
    return [[self alloc] initWithList: list];
}

+ (instancetype) list {
    return [[self alloc] init];
}


- (instancetype)initWithCapacity:(NSInteger)capacity {
    self = [super init];
    if(self) {
        array = [NSMutableArray arrayWithCapacity:capacity];
    }
    return self;
}

- (instancetype) initWithList: (NSObject <FRList> *)list {
    self = [super init];
    if(self) {
        array = [NSMutableArray arrayWithArray:list.toArray];
    }
    return self;
}

- (instancetype)init {
    return [self initWithCapacity:10];
}


#pragma mark - FRArrayList methods

- (BOOL) add:(id)item {
    if(!item) { return NO; }
    [array addObject:item];
    return YES;
}

- (void) addAtIndex:(NSUInteger)index item:(id)item {
    if(!item) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:FRErrNil userInfo:nil];
    }
    if(index > self.size) {
        @throw [NSException exceptionWithName:NSRangeException reason:[NSString stringWithFormat:FRErrBadIndex, (unsigned long)index] userInfo:nil];
    }
    [array insertObject:item atIndex:index];
}

- (id) get:(NSUInteger)index {
    return [array objectAtIndex:index];
}

- (NSUInteger)indexOf:(id)item {
    return [array indexOfObject:item];
}

- (BOOL)contains:(id)item {
    return [array containsObject:item];
}

- (void) clear {
    [array removeAllObjects];
}

- (BOOL) remove:(id)item {
    if(!item) {
        return NO;
    }
    [array removeObject:item];
    return YES;
}

- (id)setAtIndex:(NSUInteger)index item:(id)item {
    if(index >= self.size) {
        @throw [NSException exceptionWithName:NSRangeException reason:[NSString stringWithFormat:FRErrBadIndex, (unsigned long)index] userInfo:nil];
    }
    id replaced = [array objectAtIndex:index];
    [array replaceObjectAtIndex:index withObject:item];
    return replaced;
}

- (id)removeAtIndex:(NSUInteger)index {
    if(index >= self.size) {
        @throw [NSException exceptionWithName:NSRangeException reason:[NSString stringWithFormat:FRErrBadIndex, (unsigned long)index] userInfo:nil];
    }
    id removed = [array objectAtIndex:index];
    [array removeObjectAtIndex:index];
    return removed;
}

- (BOOL)isEmpty {
    return [array count] == 0;
}

- (NSUInteger) size {
    return array.count;
}

- (NSArray*) toArray {
    return [NSArray arrayWithArray:array];
}

// Enumerates over the items in this list.
// Quick and dirty: uses the default enumerator for an array.
//
// Enumerators from http://nshipster.com/enumerators/
// Enumerator implemetations from https://www.mikeash.com/pyblog/friday-qa-2010-04-16-implementing-fast-enumeration.html
// Simple enumerator for an array from https://www.bignerdranch.com/blog/fast-enumeration-part-1/
// Conversion to solve wrong pointer type from http://stackoverflow.com/questions/8492029/xcode-4-arc-recheck-error-changes-retain-release-properties-of-pointer
//
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])stackbuf count:(NSUInteger)len {
    return [array countByEnumeratingWithState:state objects:stackbuf count:len];
}

@end
