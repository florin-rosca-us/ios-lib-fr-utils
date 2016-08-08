//
//  FRQueue.h
//  FRUtils
//
//  Created by Florin Rosca on 2/4/16.
//  Copyright © 2016 Florin Rosca. All rights reserved.
//
//  A Java-style FIFO (First In, First Out) queue. New elements are inserted at the tail of the queue. Existing elements are removed from the head of the queue.
//  See https://docs.oracle.com/javase/7/docs/api/java/util/Queue.html
//

#ifndef FRQueue_h
#define FRQueue_h

#import "FRCollection.h"

// A protocol that applies to all data types including primitive data types
@protocol FRQueueBase <FRCollectionBase>
@end

// A protocol that applies to data types derived from NSObject
@protocol FRQueueWithAny <FRQueueBase, FRCollectionWithAny>
- (BOOL) offer:(id)item;
- (id)element;
- (id)peek;
- (id)remove;
- (id)poll;
@end

// Extra protocols that apply to primitive data types
@protocol FRQueueWithInt <FRQueueBase, FRCollectionWithInt>
- (BOOL)offerIntValue: (int)item;
- (int)elementIntValue;
- (int)peekIntValue;
- (int)removeIntValue;
- (int)pollIntValue;
@end

@protocol FRQueueWithInteger <FRQueueBase, FRCollectionWithInteger>
- (BOOL)offerIntegerValue: (NSInteger)item;
- (NSInteger)elementIntegerValue;
- (NSInteger)peekIntegerValue;
- (NSInteger)removeIntegerValue;
- (NSInteger)pollIntegerValue;
@end

@protocol FRQueueWithFloat <FRQueueBase, FRCollectionWithFloat>
- (BOOL)offerFloatValue: (float)item;
- (float)elementFloatValue;
- (float)peekFloatValue;
- (float)removeFloatValue;
- (float)pollFloatValue;
@end

@protocol FRQueueWithDouble <FRQueueBase, FRCollectionWithDouble>
- (BOOL)offerDoubleValue: (double)item;
- (double)elementDoubleValue;
- (double)peekDoubleValue;
- (double)removeDoubleValue;
- (double)pollDoubleValue;
@end

// The FRQueue protocol applies to data types derived from NSObject
@protocol FRQueue <FRQueueBase, FRQueueWithAny>
@end


// There is no FRQueue class. Create an instance of FRLinkedList instead

#endif /* FRQueue_h */
