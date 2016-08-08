//
//  FRPriorityQueue.h
//  FRUtils
//
//  Created by Florin on 7/27/16.
//  Copyright © 2016 Florin. All rights reserved.
//
//  A Java-style priority queue.
//  See http://docs.oracle.com/javase/7/docs/api/java/util/PriorityQueue.html
//

#ifndef FRPriorityQueue_h
#define FRPriorityQueue_h

#import "FRQueue.h"
#import "FRArrayList.h"

// A protocol that applies to all data types including primitive data types
@protocol FRPriorityQueueBase <FRQueueBase>
@end

// A protocol that applies to data types derived from NSObject
@protocol FRPriorityQueueWithAny <FRQueueWithAny>
@end

// Extra protocols that apply to primitive data types
@protocol FRPriorityQueueWithInt <FRPriorityQueueBase, FRQueueWithInt>
@end

@protocol FRPriorityQueueWithInteger <FRPriorityQueueBase, FRQueueWithInteger>
@end

@protocol FRPriorityQueueWithFloat <FRPriorityQueueBase, FRQueueWithFloat>
@end

@protocol FRPriorityQueueWithDouble <FRPriorityQueueBase, FRQueueWithDouble>
@end

// The FRPriorityQueue protocol applies to data types derived from NSObject
@protocol FRPriorityQueue <FRPriorityQueueBase, FRPriorityQueueWithAny>
@end


// The class
@interface FRPriorityQueue : FRCollection <FRPriorityQueue> {
    FRArrayList *_list;
    NSComparisonResult (^ _comparator)(id, id);
}
+ (instancetype)priorityQueueWithCapacity: (NSUInteger)capacity comparator:(NSComparisonResult (^)(id, id)) comparator;
+ (instancetype)priorityQueueWithCapacity: (NSUInteger)capacity;
+ (instancetype)priorityQueue;

+ (BOOL)isMinHeapWithArray: (NSArray*)array comparator:(NSComparisonResult (^)(id, id)) comparator;
+ (BOOL)isMinHeapWithArray: (NSArray*)array;
+ (BOOL)isMinHeapWithList: (FRList*)list comparator:(NSComparisonResult (^)(id, id)) comparator;
+ (BOOL)isMinHeapWithList: (FRList*)list;

- (instancetype)initWithCapacity: (NSInteger)capacity comparator:(NSComparisonResult (^)(id, id)) comparator;
- (instancetype)initWithCapacity: (NSInteger)capacity;
@end


// Categories add support for primitive data types
@interface FRPriorityQueue (WithInt) <FRPriorityQueueWithInt>
@end

@interface FRPriorityQueue (WithInteger) <FRPriorityQueueWithInteger>
@end

@interface FRPriorityQueue (WithFloat) <FRPriorityQueueWithFloat>
@end

@interface FRPriorityQueue (WithDouble) <FRPriorityQueueWithDouble>
@end

#endif /* FRPriorityQueue */