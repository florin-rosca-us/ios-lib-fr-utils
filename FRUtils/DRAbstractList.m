//
//  DRAbstractList.m
//  DRUtils
//
//  Created by Florin on 2/1/16.
//  Copyright © 2016 Florin. All rights reserved.
//
//  An abstract list.
//
//  From http://stackoverflow.com/questions/1034373/creating-an-abstract-class-in-objective-c
//

#import "DRAbstractList.h"

@implementation DRAbstractList


- (BOOL)add:(id)item {
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}


- (BOOL)addAtIndex:(NSUInteger)index item:(id)item {
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}


- (void)clear {
    [self doesNotRecognizeSelector:_cmd];
}


- (id)get: (NSUInteger)index {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}


- (NSUInteger)indexOf:(id)item {
    [self doesNotRecognizeSelector:_cmd];
    return -1;
}


- (BOOL)contains:(id)item {
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

- (BOOL)isEmpty {
    return [self size] == 0;
}


- (BOOL)remove:(id)item {
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}


- (BOOL)removeAtIndex:(NSUInteger)index {
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}


- (NSUInteger)size {
    [self doesNotRecognizeSelector:_cmd];
    return 0;
}


- (NSArray*)toArray {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}


/*!
 * Enumerates over the items in this list.
 *
 * Enumerators from http://nshipster.com/enumerators/
 * Enumerator implemetations from https://www.mikeash.com/pyblog/friday-qa-2010-04-16-implementing-fast-enumeration.html
 * Simple enumerator for an array from https://www.bignerdranch.com/blog/fast-enumeration-part-1/
 * Conversion to solve wrong pointer type from http://stackoverflow.com/questions/8492029/xcode-4-arc-recheck-error-changes-retain-release-properties-of-pointer
 */
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])stackbuf count:(NSUInteger)len {
    return [self.toArray countByEnumeratingWithState:state objects:stackbuf count:len];
}

@end
