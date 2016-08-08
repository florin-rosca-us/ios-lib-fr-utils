//
//  FRLinkedList.h
//  FRUtils
//
//  Created by Florin Rosca on 2/3/16.
//  Copyright © 2016 Florin Rosca. All rights reserved.
//
//  A Java-style double-linked list.
//  See https://docs.oracle.com/javase/7/docs/api/java/util/LinkedList.html
//

#ifndef FRLinkedList_h
#define FRLinkedList_h

#import "FRList.h"
#import "FRDeque.h"

// A protocol that applies to all data types including primitive data types
@protocol FRLinkedListBase <FRListBase, FRDequeBase>
@end

// A protocol that applies to data types derived from NSObject
@protocol FRLinkedListWithAny <FRListWithAny, FRDequeWithAny>
@end

// Extra protocols that apply to primitive data types
@protocol FRLinkedListWithInt <FRLinkedListBase, FRListWithInt, FRDequeWithInt>
@end

@protocol FRLinkedListWithInteger <FRLinkedListBase, FRListWithInteger, FRDequeWithInteger>
@end

@protocol FRLinkedListWithFloat <FRLinkedListBase, FRListWithFloat, FRDequeWithFloat>
@end

@protocol FRLinkedListWithDouble <FRLinkedListBase, FRListWithDouble, FRDequeWithDouble>
@end

// The FRLinkedList protocol applies to data types derived from NSObject
@protocol FRLinkedList <FRLinkedListBase, FRLinkedListWithAny>
@end


// The class
@interface FRLinkedList : FRList <FRLinkedList>
+ (instancetype) list;
@end

// Categories add support for primitive data types
@interface FRLinkedList (WithInt) <FRLinkedListWithInt> @end
@interface FRLinkedList (WithInteger) <FRLinkedListWithInteger> @end
@interface FRLinkedList (WithFloat) <FRLinkedListWithFloat> @end
@interface FRLinkedList (WithDouble) <FRLinkedListWithDouble> @end


#endif /* FRLinkedList_h */