//
//  FRStack.h
//  FRUtils
//
//  Created by Florin Rosca on 2/4/16.
//  Copyright © 2016 Florin Rosca. All rights reserved.
//
//  A Java-style LIFO (Last In, First Out) queue/stack. New elements are inserted at the head of the queue. Existing elements are removed from the head of the queue.
//  See https://docs.oracle.com/javase/7/docs/api/java/util/Stack.html
//

#ifndef FRStack_h
#define FRStack_h

#import "FRCollection.h"

#pragma mark - FRStack base protocols

// A protocol that applies to all data types including primitive data types
@protocol FRStackBase <FRCollectionBase>
@end

// A protocol that applies to data types derived from NSObject
@protocol FRStackWithAny <FRStackBase, FRCollectionWithAny>
- (id) peek;
- (id)pop;
- (void)push:(id)item;
@end

#pragma mark - FRStack primitive data type protocols

// Extra protocols that apply to primitive data types
@protocol FRStackWithInt <FRStackBase, FRCollectionWithInt>
- (int) peekIntValue;
- (int)popIntValue;
- (void)pushIntValue:(int)item;
@end

@protocol FRStackWithInteger <FRStackBase, FRCollectionWithInteger>
- (NSInteger) peekIntegerValue;
- (NSInteger)popIntegerValue;
- (void)pushIntegerValue:(NSInteger)item;
@end

@protocol FRStackWithFloat <FRStackBase, FRCollectionWithFloat>
- (float) peekFloatValue;
- (float)popFloatValue;
- (void)pushFloatValue:(float)item;
@end

@protocol FRStackWithDouble <FRStackBase, FRCollectionWithDouble>
- (double) peekDoubleValue;
- (double)popDoubleValue;
- (void)pushDoubleValue:(double)item;
@end


#pragma mark - FRStack protocol

// The FRStack protocol applies to data types derived from NSObject
@protocol FRStack <FRStackBase, FRStackWithAny>
@end


// There is no FRStack class. Create an instance of FRLinkedList instead

#endif /* FRStack_h */
