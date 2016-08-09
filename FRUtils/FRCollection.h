//
//  FRCollection.h
//  FRUtils
//
//  Created by Florin Rosca on 2/4/16.
//  Copyright © 2016 Florin Rosca. All rights reserved.
//
//  A Java-style collection.
//  See https://docs.oracle.com/javase/7/docs/api/java/util/Collection.html
//

#ifndef FRCollection_h
#define FRCollection_h


#import <Foundation/Foundation.h>
#import "FRConstants.h"

#define _ABSTRACT { @throw [NSException exceptionWithName:FRErrNotImplemented reason:@"Abstract class" userInfo:nil]; }


#pragma mark - FRCollection base protocols

// A protocol that applies to all data types including primitive data types
@protocol FRCollectionBase <NSFastEnumeration>
- (void)clear;
- (BOOL)isEmpty;
- (NSUInteger)size;
- (NSArray*)toArray;
@end

// A protocol that applies to data types derived from NSObject
@protocol FRCollectionWithAny <FRCollectionBase>
- (BOOL)add:(id)item;
- (BOOL)contains:(id)item;
- (BOOL)remove:(id)item;
@end


#pragma mark - FRCollection primitive data type protocols

// Extra protocols that apply to primitive data types
@protocol FRCollectionWithInt <FRCollectionBase>
- (BOOL)addIntValue:(int)item;
- (BOOL)containsIntValue:(int)item;
- (BOOL)removeIntValue:(int)item;
@end
@protocol FRCollectionWithInteger <FRCollectionBase>
- (BOOL)addIntegerValue:(NSInteger)item;
- (BOOL)containsIntegerValue:(NSInteger)item;
- (BOOL)removeIntegerValue:(NSInteger)item;
@end
@protocol FRCollectionWithFloat <FRCollectionBase>
- (BOOL)addFloatValue:(float)item;
- (BOOL)containsFloatValue:(float)item;
- (BOOL)removeFloatValue:(float)item;
@end
@protocol FRCollectionWithDouble <FRCollectionBase>
- (BOOL)addDoubleValue:(double)item;
- (BOOL)containsDoubleValue:(double)item;
- (BOOL)removeDoubleValue:(double)item;
@end


#pragma mark - FRCollection protocol

// The FRCollection protocol applies to data types derived from NSObject
@protocol FRCollection <FRCollectionBase, FRCollectionWithAny>
@end


#pragma mark - FRCollection class

// The class
@interface FRCollection : NSObject <FRCollection>
@end

#pragma mark - FRCollectionWith categories

// Categories add support for primitive data types
@interface FRCollection (WithInt) <FRCollectionWithInt> @end
@interface FRCollection (WithInteger) <FRCollectionWithInteger> @end
@interface FRCollection (WithFloat) <FRCollectionWithFloat> @end
@interface FRCollection (WithDouble) <FRCollectionWithDouble> @end


#endif /* FRCollection_h */
