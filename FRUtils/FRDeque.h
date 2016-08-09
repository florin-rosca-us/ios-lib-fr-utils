//
//  FRDeque.h
//  FRUtils
//
//  Created by Florin Rosca on 2/4/16.
//  Copyright © 2016 Florin Rosca. All rights reserved.
//
//  A Java-style deque.
//  See https://docs.oracle.com/javase/7/docs/api/java/util/Deque.html
//

#ifndef FRDeque_h
#define FRDeque_h

#import "FRQueue.h"
#import "FRStack.h"


#pragma mark - FRDeque base protocols

// A protocol that applies to all data types including primitive data types
@protocol FRDequeBase <FRQueueBase, FRStackBase>
@end

// A protocol that applies to data types derived from NSObject
@protocol FRDequeWithAny <FRDequeBase, FRQueueWithAny, FRStackWithAny>
- (BOOL)offerFirst:(id)item;
- (void)addFirst:(id)item;
- (id)peekFirst;
- (id)getFirst;
- (id)pollFirst;
- (id)removeFirst;
- (BOOL)offerLast:(id)item;
- (void)addLast:(id)item;
- (id)peekLast;
- (id)getLast;
- (id)pollLast;
-(id)removeLast;
@end


#pragma mark - FRDequeWith primitive data type protocols

// Extra protocols that apply to primitive data types
@protocol FRDequeWithInt <FRDequeBase, FRQueueWithInt, FRStackWithInt>
- (BOOL)offerFirstIntValue:(int)item;
- (void)addFirstIntValue:(int)item;
- (int)peekFirstIntValue;
- (int)getFirstIntValue;
- (int)pollFirstIntValue;
- (int)removeFirstIntValue;
- (BOOL)offerLastIntValue:(int)item;
- (void)addLastIntValue:(int)item;
- (int)peekLastIntValue;
- (int)getLastIntValue;
- (int)pollLastIntValue;
- (int)removeLastIntValue;
@end

@protocol FRDequeWithInteger <FRDequeBase, FRQueueWithInteger, FRStackWithInteger>
- (BOOL)offerFirstIntegerValue:(NSInteger)item;
- (void)addFirstIntegerValue:(NSInteger)item;
- (NSInteger)peekFirstIntegerValue;
- (NSInteger)getFirstIntegerValue;
- (NSInteger)pollFirstIntegerValue;
- (NSInteger)removeFirstIntegerValue;
- (BOOL)offerLastIntegerValue:(NSInteger)item;
- (void)addLastIntegerValue:(NSInteger)item;
- (NSInteger)peekLastIntegerValue;
- (NSInteger)getLastIntegerValue;
- (NSInteger)pollLastIntegerValue;
- (NSInteger)removeLastIntegerValue;
@end

@protocol FRDequeWithFloat <FRDequeBase, FRQueueWithFloat, FRStackWithFloat>
- (BOOL)offerFirstFloatValue:(float)item;
- (void)addFirstFloatValue:(float)item;
- (float)peekFirstFloatValue;
- (float)getFirstFloatValue;
- (float)pollFirstFloatValue;
- (float)removeFirstFloatValue;
- (BOOL)offerLastFloatValue:(float)item;
- (void)addLastFloatValue:(float)item;
- (float)peekLastFloatValue;
- (float)getLastFloatValue;
- (float)pollLastFloatValue;
- (float)removeLastFloatValue;
@end

@protocol FRDequeWithDouble <FRDequeBase, FRQueueWithDouble, FRStackWithDouble>
- (BOOL)offerFirstDoubleValue:(double)item;
- (void)addFirstDoubleValue:(double)item;
- (double)peekFirstDoubleValue;
- (double)getFirstDoubleValue;
- (double)pollFirstDoubleValue;
- (double)removeFirstDoubleValue;
- (BOOL)offerLastDoubleValue:(double)item;
- (void)addLastDoubleValue:(double)item;
- (double)peekLastDoubleValue;
- (double)getLastDoubleValue;
- (double)pollLastDoubleValue;
- (double)removeLastDoubleValue;
@end


#pragma mark - FRDeque protocol

// The FRDeque protocol applies to data types derived from NSObject
@protocol FRDeque <FRDequeBase, FRDequeWithAny>
@end


// There is no FRDeque class. Create an instance of FRLinkedList instead


#endif /* FRDeque_h */
