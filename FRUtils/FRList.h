//
//  FRList.h
//  FRUtils
//
//  Created by Florin Rosca on 2/1/16.
//  Copyright © 2016 Florin Rosca. All rights reserved.
//
//  A Java-style list.
//  See https://docs.oracle.com/javase/7/docs/api/java/util/List.html
//

#ifndef FRList_h
#define FRList_h

#import "FRCollection.h"

// A protocol that applies to all data types including primitive data types
@protocol FRListBase <FRCollectionBase>
@end

// A protocol that applies to data types derived from NSObject
@protocol FRListWithAny <FRListBase, FRCollectionWithAny>
- (void) addAtIndex:(NSUInteger)index item:(id)item;
- (id) setAtIndex: (NSUInteger)index item:(id)item;
- (id) removeAtIndex:(NSUInteger)index;
- (NSUInteger) indexOf:(id)item;
- (id) get:(NSUInteger)index;
@end

// Extra protocols that apply to primitive data types
@protocol FRListWithInt <FRListBase, FRCollectionWithInt>
- (void) addAtIndex:(NSUInteger)index intValue:(int)item;
- (int) setAtIndex: (NSUInteger)index intValue:(int)item;
- (int) removeIntValueAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfIntValue:(int)item;
- (int) getIntValue:(NSUInteger)index;
@end

@protocol FRListWithInteger <FRListBase, FRCollectionWithInteger>
- (void) addAtIndex:(NSUInteger)index integerValue:(NSInteger)item;
- (NSInteger) setAtIndex: (NSUInteger)index integerValue:(NSInteger)item;
- (NSInteger) removeIntegerValueAtIndex:(NSUInteger)index;
- (NSUInteger) indexOfIntegerValue:(NSInteger)item;
- (NSInteger) getIntegerValue:(NSUInteger)index;
@end

@protocol FRListWithFloat <FRListBase, FRCollectionWithFloat>
- (void) addAtIndex:(NSUInteger)index floatValue:(float)item;
- (float) setAtIndex: (NSUInteger)index floatValue:(float)item;
- (float) removeFloatValueAtIndex:(NSUInteger)index;
- (NSUInteger) indexOfFloatValue:(float)item;
- (float) getFloatValue:(NSUInteger)index;
@end

@protocol FRListWithDouble <FRListBase, FRCollectionWithDouble>
- (void) addAtIndex:(NSUInteger)index doubleValue:(double)item;
- (double) setAtIndex: (NSUInteger)index doubleValue:(double)item;
- (double) removeDoubleValueAtIndex:(NSUInteger)index;
- (NSUInteger) indexOfDoubleValue:(double)item;
- (double) getDoubleValue:(NSUInteger)index;
@end

// The FRList protocol applies to data types derived from NSObject
@protocol FRList <FRListBase, FRListWithAny>
@end


// The class 
@interface FRList : FRCollection <FRList>
@end

// Categories add support for primitive data types
@interface FRList (WithInt) <FRListWithInt>
@end

@interface FRList (WithInteger) <FRListWithInteger>
@end

@interface FRList (WithFloat) <FRListWithFloat>
@end

@interface FRList (WithDouble) <FRListWithDouble>
@end


#endif /* FRList_h */
