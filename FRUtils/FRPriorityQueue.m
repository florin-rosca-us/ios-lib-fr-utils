//
//  FRPriorityQueue.m
//  FRUtils
//
//  Created by Florin Rosca on 7/27/16.
//  Copyright © 2016 Florin Rosca. All rights reserved.
//
//  A Java-style priority queue implemented as a min-heap.
//  We are using a block (Objective-C lambda) to compare objects.
//
//  See https://en.wikipedia.org/wiki/Priority_queue
//  See https://docs.oracle.com/javase/7/docs/api/java/util/PriorityQueue.html
//  See https://en.wikipedia.org/wiki/Binary_heap

#import "FRConstants.h"
#import "FRPriorityQueue.h"

// The default capacity
#define DEFAULT_CAPACITY 10

// Zero-based
#define parent(i) ((i + 1) / 2 - 1)
#define left(i) ((i + 1) * 2 - 1)
#define right(i) ((i + 1) * 2)


#pragma mark - FRPriorityQueue class

@implementation FRPriorityQueue

+ (instancetype)priorityQueueWithCapacity:(NSUInteger)capacity comparator:(NSComparisonResult (^)(id, id)) comparator {
    return [[FRPriorityQueue alloc] initWithCapacity:capacity comparator: comparator];
}

+ (instancetype)priorityQueueWithCapacity:(NSUInteger)capacity {
    return [FRPriorityQueue priorityQueueWithCapacity:capacity comparator: nil];
}

+ (instancetype)priorityQueue {
    return [FRPriorityQueue priorityQueueWithCapacity:DEFAULT_CAPACITY comparator: nil];
}

- (instancetype)initWithCapacity: (NSInteger)capacity comparator:(NSComparisonResult (^)(id, id)) comparator {
    self = [super init];
    if(self) {
        _list = [FRArrayList listWithCapacity: capacity];
        _comparator = comparator;
    }
    return self;
}

// Compares two arguments using the specified comparator. When the comparator is nil, this will attempt to convert both arguments to NSNumber.
+ (NSComparisonResult)compare:(id)o1 with:(id)o2 using:(NSComparisonResult (^)(id, id)) comparator {
    if(comparator) {
        return comparator(o1, o2);
    }
    // Compare numbers
    if([o1 isKindOfClass:[NSNumber class]] && [o2 isKindOfClass:[NSNumber class]]) {
        return [(NSNumber*)o1 compare:(NSNumber*) o2];
    }
    // Throw an exception if we cannot compare the objects. We could also return NSOrderedSame but it would make debugging harder
    @throw [NSException exceptionWithName:NSGenericException reason:FRErrCannotCompare userInfo:nil];
}

// Returns YES if the specified array is a min-heap using the specified comparator.
+ (BOOL) isMinHeapWithArray:(NSArray *)array comparator:(NSComparisonResult (^)(id, id)) comparator {
    if(!array) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:FRErrNil userInfo:nil];
    }
    if(array.count == 0) {
        return NO;
    }
    // elements after N/2 are leaves
    for(NSUInteger i = 0; i < array.count / 2; i++) {
        if(left(i) < array.count && [FRPriorityQueue compare:[array objectAtIndex:i] with:[array objectAtIndex:left(i)] using:comparator] == NSOrderedDescending) {
            return NO;
        }
        if(right(i) < array.count && [FRPriorityQueue compare:[array objectAtIndex:i] with:[array objectAtIndex:right(i)] using:comparator] == NSOrderedDescending) {
            return NO;
        }
    }
    return YES;
}

+ (BOOL) isMinHeapWithArray:(NSArray *)array {
    return [FRPriorityQueue isMinHeapWithArray:array comparator:nil];
}

+ (BOOL) isMinHeapWithList:(FRList *)list comparator:(NSComparisonResult (^)(id, id)) comparator {
    return [FRPriorityQueue isMinHeapWithArray:[list toArray] comparator:comparator];
}

+ (BOOL) isMinHeapWithList:(FRList *)list {
    return [FRPriorityQueue isMinHeapWithList:list comparator:nil];
}


- (instancetype)initWithCapacity: (NSInteger)capacity {
    return [self initWithCapacity:capacity comparator:nil];
}

- (instancetype)init {
    return [self initWithCapacity:DEFAULT_CAPACITY comparator:nil];
}


#pragma mark - FRPriorityQueue methods

- (NSComparisonResult)compare:(id)o1 with:(id)o2 {
    return [FRPriorityQueue compare:o1 with:o2 using:_comparator];
}

// Performs heap-down from the specified index (0-based). Min-heap: we swap the parent with the smallest child.
- (void) heapDownFromIndex: (NSUInteger)index {
    // the number of elements currently in heap
    NSUInteger size = [_list size];
    if(index >= size) {
        @throw [NSException exceptionWithName:NSRangeException reason:[NSString stringWithFormat:FRErrBadIndex, (unsigned long)index] userInfo:nil];
    }
    else if(index == size - 1) {
        // no heap-down for last element
        return;
    }
    else if(left(index) >= size) {
        // no children
        return;
    }
    // we have at least the left child
    NSUInteger smallest = index;
    if([self compare:[_list get:left(index)] with:[_list get:index]] == NSOrderedAscending) { smallest = left(index); }
    // and maybe the right child
    if(right(index) < size) {
        // which may be smaller
        if([self compare:[_list get:right(index)] with:[_list get:smallest]] == NSOrderedAscending) { smallest = right(index); }
    }
    if(index == smallest) {
        // the element at index is already the smallest
        return;
    }
    // swap
    id crt = [_list get:index];
    [_list setAtIndex:index item:[_list get:smallest]];
    [_list setAtIndex:smallest item:crt];
     // and go into recursion
    [self heapDownFromIndex:smallest];
}

// Performs heap-up from the specified index (0-based). Min-heap: we bubble up the smaller value.
- (void) heapUpFromIndex: (NSUInteger)index {
    // the number of elements currently in heap
    NSUInteger size = [self size];
    if(index >= size) {
        @throw [NSException exceptionWithName:NSRangeException reason:[NSString stringWithFormat:FRErrBadIndex, (unsigned long)index] userInfo:nil];
    }
    else if(index == 0) {
        // no heap-up for first element
        return;
    }
    if([self compare:[_list get:index] with:[_list get:parent(index)]] == NSOrderedAscending) {
        // swap
        id crt = [_list get:index];
        [_list setAtIndex: index item: [_list get: parent(index)]];
        [_list setAtIndex: parent(index) item: crt];
        [self heapUpFromIndex:parent(index)];
    }
}

// Heapifies the underlying array using Floyd's method. We need to call this when removing an element.
- (void)heapify {
    NSUInteger size = [self size];
    if(size == 0) {
        return;
    }
    // elements from N/2 to N-1 are leaves
    for(NSUInteger index = size / 2 ; index-- > 0;) {
        [self heapDownFromIndex:index];
    }
}
// Heap - end


#pragma mark - FRCollection methods

- (void)clear {
    [_list clear];
}

- (BOOL)isEmpty {
    return [_list isEmpty];
}

- (NSUInteger)size {
    return [_list size];
}

- (NSArray*)toArray {
    return [_list toArray];
}

// Enumerates over the items in this priority queue.
// Quick and dirty: uses the default enumerator for an array.
//
// Enumerators from http://nshipster.com/enumerators/
// Enumerator implemetations from https://www.mikeash.com/pyblog/friday-qa-2010-04-16-implementing-fast-enumeration.html
// Simple enumerator for an array from https://www.bignerdranch.com/blog/fast-enumeration-part-1/
// Conversion to solve wrong pointer type from http://stackoverflow.com/questions/8492029/xcode-4-arc-recheck-error-changes-retain-release-properties-of-pointer
//
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])stackbuf count:(NSUInteger)len {
    return [_list countByEnumeratingWithState:state objects:stackbuf count:len];
}


#pragma mark - FRQueue methods

- (BOOL)add:(id)item {
    if(![self offer:item]) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:FRErrCannotInsert userInfo:nil];
    }
    return YES;
}

- (BOOL)offer:(id)item {
    if(![_list add:item]) {
        return NO;
    }
    [self heapUpFromIndex:[self size] - 1];
    return YES;
}

- (BOOL)contains:(id)item {
    return [_list contains:item];
}

- (id)peek {
    return [_list size] == 0 ? nil : [_list get:0];
}

- (id)element {
    if([_list size] == 0) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:FRErrEmpty userInfo:nil];
    }
    return [_list get:0];
}

- (id)poll {
    if([_list size] == 0) {
        return nil;
    }
    id first = [_list get:0];
    id last = [_list removeAtIndex:[_list size] - 1];
    if([_list size] > 0) {
        [_list setAtIndex:0 item:last];
        [self heapDownFromIndex:0];
    }
    return first;
}

- (id)remove {
    if([_list size] == 0) {
         @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:FRErrEmpty userInfo:nil];
    }
    return [self poll];
}

- (BOOL)remove:(id)item {
    if(![_list remove:item]) {
        return NO;
    }
    [self heapify];
    return YES;
}

@end


#pragma mark - Support for primitive data type: int

@implementation FRPriorityQueue (WithInt)

- (int)elementIntValue {
    return [(NSNumber*)[self element] intValue];
}

- (BOOL)offerIntValue:(int)item {
    return [self offer:[NSNumber numberWithInt:item]];
}

- (int)peekIntValue {
    return [(NSNumber*)[self peek] intValue];
}

- (int)pollIntValue {
    return [(NSNumber*)[self poll] intValue];
}

- (int)removeIntValue {
    return [(NSNumber*)[self remove] intValue];
}

@end


#pragma mark - Support for primitive data type: NSInteger

@implementation FRPriorityQueue (WithInteger)

- (NSInteger)elementIntegerValue {
    return [(NSNumber*)[self element] integerValue];
}

- (BOOL)offerIntegerValue:(NSInteger)item {
    return [self offer:[NSNumber numberWithInteger:item]];
}

- (NSInteger)peekIntegerValue {
    return [(NSNumber*)[self peek] integerValue];
}

- (NSInteger)pollIntegerValue {
    return [(NSNumber*)[self poll] integerValue];
}

- (NSInteger)removeIntegerValue {
    return [(NSNumber*)[self remove] integerValue];
}

@end


#pragma mark - Support for primitive data type: float

@implementation FRPriorityQueue (WithFloat)

- (float)elementFloatValue {
    return [(NSNumber*)[self element] floatValue];
}

- (BOOL)offerFloatValue:(float)item {
    return [self offer:[NSNumber numberWithFloat:item]];
}

- (float)peekFloatValue {
    return [(NSNumber*)[self peek] floatValue];
}

- (float)pollFloatValue {
    return [(NSNumber*)[self poll] floatValue];
}

- (float)removeFloatValue {
    return [(NSNumber*)[self remove] floatValue];
}

@end


#pragma mark - Support for primitive data type: double

@implementation FRPriorityQueue (WithDouble)

- (double)elementDoubleValue {
    return [(NSNumber*)[self element] doubleValue];
}

- (BOOL)offerDoubleValue:(double)item {
    return [self offer:[NSNumber numberWithDouble:item]];
}

- (double)peekDoubleValue {
    return [(NSNumber*)[self peek] doubleValue];
}

- (double)pollDoubleValue {
    return [(NSNumber*)[self poll] doubleValue];
}

- (double)removeDoubleValue {
    return [(NSNumber*)[self remove] doubleValue];
}

@end

