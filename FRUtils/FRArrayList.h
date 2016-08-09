//
//  FRArrayList.h
//  FRUtils
//
//  Created by Florin Rosca on 2/1/16.
//  Copyright © 2016 Florin Rosca. All rights reserved.
//
//  A Java-style array list using an internal NSMutableArray.
//  See https://docs.oracle.com/javase/7/docs/api/java/util/ArrayList.html
//

#ifndef FRArrayList_h
#define FRArrayList_h

#import "FRList.h"


#pragma mark - FRArrayList base protocols

// A protocol that applies to all data types including primitive data types
@protocol FRArrayListBase <FRListBase>
@end

// A protocol that applies to data types derived from NSObject
@protocol FRArrayListWithAny <FRArrayListBase, FRListWithAny>
@end


#pragma mark - FRArrayListWith primitive data type protocols

// Extra protocols that apply to primitive data types
@protocol FRArrayListWithInt <FRArrayListBase, FRListWithInt>
@end

@protocol FRArrayListWithInteger <FRArrayListBase, FRListWithInteger>
@end

@protocol FRArrayListWithFloat <FRArrayListBase, FRListWithFloat>
@end

@protocol FRArrayListWithDouble <FRArrayListBase, FRListWithDouble>
@end


#pragma mark - FRArrayList protocol

// The FRArrayList protocol applies to data types derived from NSObject
@protocol FRArrayList <FRArrayListBase, FRListWithAny> @end


#pragma mark - FRArrayList class

// The class
@interface FRArrayList : FRList <FRArrayList> {
    NSMutableArray* array;
}
+ (instancetype)listWithCapacity: (NSUInteger)capacity;
+ (instancetype)listWithList: (NSObject <FRList> *)list;
+ (instancetype)list;
- (instancetype)initWithCapacity: (NSInteger)capacity;
- (instancetype)initWithList: (NSObject <FRList> *)list;
@end


#pragma mark - FRArrayListWith categories

@interface FRArrayList (WithInt) <FRArrayListWithInt>
@end

@interface FRArrayList (WithInteger) <FRArrayListWithInteger>
@end

@interface FRArrayList (WithFloat) <FRArrayListWithFloat>
@end

@interface FRArrayList (WithDouble) <FRArrayListWithDouble>
@end

#endif /* FRArrayList_h */