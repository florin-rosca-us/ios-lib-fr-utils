//
//  FRCollectionImpl.m
//  FRUtils
//
//  An "abstract" class
//
//  Created by Florin on 7/18/16.
//  Copyright © 2016 Florin. All rights reserved.
//
//  A Java-style collection.
//  See https://docs.oracle.com/javase/7/docs/api/java/util/Collection.html
//

#import "FRCollection.h"


@implementation FRCollection

- (void)clear _ABSTRACT;

- (BOOL)add:(id)item _ABSTRACT;

- (BOOL)contains:(id)item _ABSTRACT;

- (BOOL)isEmpty _ABSTRACT;

- (BOOL)remove:(NSObject*)item _ABSTRACT;

- (NSUInteger)size _ABSTRACT;

- (NSArray*) toArray _ABSTRACT;

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])stackbuf count:(NSUInteger)len _ABSTRACT;

@end


@implementation FRCollection (WithInt)

- (BOOL) addIntValue:(int)item {
    return [self add: [NSNumber numberWithInt:item]];
}

- (BOOL)containsIntValue:(int)item {
    return [self contains:[NSNumber numberWithInt:item]];
}

- (BOOL)removeIntValue:(int)item {
    return [self remove: [NSNumber numberWithInt:item]];
}

@end


@implementation FRCollection (WithInteger)

- (BOOL) addIntegerValue:(NSInteger)item {
    return [self add: [NSNumber numberWithInteger:item]];
}

- (BOOL)containsIntegerValue:(NSInteger)item {
    return [self contains:[NSNumber numberWithInteger:item]];
}

- (BOOL)removeIntegerValue:(NSInteger)item {
    return [self remove: [NSNumber numberWithInteger:item]];
}

@end


@implementation FRCollection (WithFloat)

- (BOOL) addFloatValue:(float)item {
    return [self add: [NSNumber numberWithFloat:item]];
}

- (BOOL)containsFloatValue:(float)item {
    return [self contains:[NSNumber numberWithFloat:item]];
}

- (BOOL)removeFloatValue:(float)item {
    return [self remove: [NSNumber numberWithFloat:item]];
}

@end


@implementation FRCollection (WithDouble)

- (BOOL) addDoubleValue:(double)item {
    return [self add: [NSNumber numberWithDouble:item]];
}

- (BOOL)containsDoubleValue:(double)item {
    return [self contains:[NSNumber numberWithDouble:item]];
}

- (BOOL)removeDoubleValue:(double)item {
    return [self remove: [NSNumber numberWithDouble:item]];
}

@end