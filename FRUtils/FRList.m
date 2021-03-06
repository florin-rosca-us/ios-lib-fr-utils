//
//  FRList.m
//  FRUtils
//
//  Created by Florin Rosca on 7/18/16.
//  Copyright © 2016 Florin Rosca. All rights reserved.
//
//  A Java-style list.
//  See https://docs.oracle.com/javase/7/docs/api/java/util/List.html
//

#import "FRList.h"


@implementation FRList

- (void)addAtIndex:(NSUInteger)index item:(id)item _ABSTRACT;

- (id)setAtIndex:(NSUInteger)index item:(id)item _ABSTRACT;

- (id)removeAtIndex:(NSUInteger)index _ABSTRACT;

- (void)clear _ABSTRACT;

- (NSUInteger)indexOf:(id)item _ABSTRACT;

- (id)get:(NSUInteger)index _ABSTRACT;

@end


#pragma mark - Support for primitive data type: int

@implementation FRList (WithInt)

- (void)addAtIndex:(NSUInteger)index intValue:(int)item {
    return [self addAtIndex:index item:[NSNumber numberWithInt:item]];
}

- (int)setAtIndex:(NSUInteger)index intValue:(int)item {
    return [(NSNumber*)[self setAtIndex:index item:[NSNumber numberWithInt:item]] intValue];
}

- (int)removeIntValueAtIndex:(NSUInteger)index {
    return [(NSNumber*)[self removeAtIndex:index] intValue];
}

- (NSUInteger)indexOfIntValue:(int)item {
    return [self indexOf:[NSNumber numberWithInt:item]];
}

- (int)getIntValue:(NSUInteger)index {
    return [((NSNumber*)[self get:index]) intValue];
}

@end


#pragma mark - Support for primitive data type: NSInteger

@implementation FRList (WithInteger)

- (void)addAtIndex:(NSUInteger)index integerValue:(NSInteger)item {
    return [self addAtIndex:index item:[NSNumber numberWithInteger:item]];
}

- (NSInteger)setAtIndex:(NSUInteger)index integerValue:(int)item {
    return [(NSNumber*)[self setAtIndex:index item:[NSNumber numberWithInt:item]] integerValue];
}

- (NSInteger)removeIntegerValueAtIndex:(NSUInteger)index {
    return [(NSNumber*)[self removeAtIndex:index] integerValue];
}

- (NSUInteger)indexOfIntegerValue:(NSInteger)item {
    return [self indexOf:[NSNumber numberWithInteger:item]];
}

- (NSInteger)getIntegerValue:(NSUInteger)index {
    return [((NSNumber*)[self get:index]) integerValue];
}

@end


#pragma mark - Support for primitive data type: float

@implementation FRList (WithFloat)

- (void)addAtIndex:(NSUInteger)index floatValue:(float)item {
    return [self addAtIndex:index item:[NSNumber numberWithFloat:item]];
}

- (float)setAtIndex:(NSUInteger)index floatValue:(float)item {
    return [(NSNumber*)[self setAtIndex:index item:[NSNumber numberWithFloat:item]] floatValue];
}

- (float)removeFloatValueAtIndex:(NSUInteger)index {
    return [(NSNumber*)[self removeAtIndex:index] floatValue];
}

- (NSUInteger)indexOfFloatValue:(float)item {
    return [self indexOf:[NSNumber numberWithFloat:item]];
}

- (float)getFloatValue:(NSUInteger)index {
    return [((NSNumber*)[self get:index]) floatValue];
}

@end


#pragma mark - Support for primitive data type: double

@implementation FRList (WithDouble)

- (void)addAtIndex:(NSUInteger)index doubleValue:(double)item {
    return [self addAtIndex:index item:[NSNumber numberWithDouble:item]];
}

- (double)setAtIndex:(NSUInteger)index doubleValue:(double)item {
    return [(NSNumber*)[self setAtIndex:index item:[NSNumber numberWithDouble:item]] doubleValue];
}

- (double)removeDoubleValueAtIndex:(NSUInteger)index {
    return [(NSNumber*)[self removeAtIndex:index] doubleValue];
}

- (NSUInteger)indexOfDoubleValue:(double)item {
    return [self indexOf:[NSNumber numberWithDouble:item]];
}

- (double)getDoubleValue:(NSUInteger)index {
    return [((NSNumber*)[self get:index]) doubleValue];
}

@end