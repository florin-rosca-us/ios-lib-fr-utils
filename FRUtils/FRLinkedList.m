//
//  FRLinkedList.m
//  FRUtils
//
//  The FRLinkedList implementation. Also contains the implementations for FRStack, FRQueue and FRDeque
//
//  Created by Florin Rosca on 2/3/16.
//  Copyright © 2016 Florin Rosca. All rights reserved.
//
//  A Java-style double-linked list.
//  See https://docs.oracle.com/javase/7/docs/api/java/util/LinkedList.html
//

#import "FRConstants.h"
#import "FRLinkedList.h"


#pragma mark - Node class

@interface Node: NSObject
@property(nonatomic,retain) Node *prev;
@property(nonatomic,retain) Node *next;
@property(nonatomic,retain) id item;

+ (instancetype)nodeWithPrev:(Node*)prev item:(id)item next:(Node*)next;
- (instancetype)initWithPrev: (Node*)prev item:(id)item next:(Node*)next;

@end


@implementation Node

+ (instancetype)nodeWithPrev:(Node *)prev item:(id)item next:(Node *)next {
    return [[Node alloc] initWithPrev:prev item:item next:next];
}

- (instancetype)initWithPrev: (Node*)prev item:(id)item next:(Node*)next {
    self = [super init];
    if(self) {
        _prev = prev;
        _item = item;
        _next = next;
    }
    return self;
}

@end


#pragma mark - FRLinkedList class

@implementation FRLinkedList {
    Node *head;
    Node *tail;
    // Use unsigned long instead of NSUInteger so that countByEnumerationWithState does not complain about wrong pointer type
    unsigned long size;
}


// Class factory method. Creates a new instance
+ (instancetype)list { return [[self alloc] init]; }


// Initializes this instance
- (instancetype)init {
    if(self = [super init]) {
        head = nil;
        tail = nil;
        size = 0;
    }
    return self;
}

- (Node*)nodeAtIndex:(NSUInteger)index {
    if(index >= size) {
        @throw [NSException exceptionWithName:NSRangeException reason:[NSString stringWithFormat:FRErrBadIndex, (unsigned long)index] userInfo:nil];
    }
    Node *crt = head;
    for(NSUInteger i = 0; i < index; i++) {
        crt = crt.next;
    }
    // TODO: optimization? When index > size/2 count from the end of the list
    return crt;
}

- (BOOL)offerOriginItem:(id)item {
    if(!item || head || tail) {
        return NO;
    }
    head = tail = [Node nodeWithPrev:nil item:item next:nil];
    size = 1;
    return YES;
}

- (BOOL)offerBeforeNode:(Node*)node item:(id)item {
    if(!node || !item) {
        return NO;
    }
    Node *added = [Node nodeWithPrev:node.prev item:item next:node];
    node.prev = added;
    if(added.prev) {
        added.prev.next = added;
    }
    if(head == node) {
        head = added;
    }
    size++;
    return YES;
}

- (BOOL)offerAfterNode:(Node*)node item:(id)item {
    if(!node || !item) {
        return NO;
    }
    Node *added = [Node nodeWithPrev:node item:item next:node.next];
    node.next = added;
    if(added.next) {
        added.next.prev = added;
    }
    if(tail == node) {
        tail = added;
    }
    size++;
    return YES;
}

- (BOOL)removeNode:(Node*)node {
    if(!node) {
        return NO;
    }
    if(head == node) {
        head = node.next;
    }
    if(tail == node) {
        tail = node.prev;
    }
    if(node.prev) {
        node.prev.next = node.next;
    }
    if(node.next) {
        node.next.prev = node.prev;
    }
    node.prev = node.next = nil;
    node.item = nil;
    size--;
    return YES;
}


#pragma mark - FRCollection methods

- (BOOL)add:(id)item {
    return [self offerLast:item];
}

- (BOOL)contains:(id)item {
    if(!item) { return NO; }
    for(Node *node = head; node; node = node.next) {
        if([node.item isEqual: item]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isEmpty {
    return !head && !tail;
}

- (BOOL)remove:(id)item {
    if(!item) {
        return NO;
    }
    for(Node *node = head; node; node = node.next) {
        if([node.item isEqual: item]) {
            return [self removeNode:node];
        }
    }
    return NO;
}

- (NSUInteger)size {
    return size;
}

- (NSArray*)toArray {
    NSMutableArray *a = [NSMutableArray arrayWithCapacity:[self size]];
    for(Node *node = head; node; node = node.next) {
        [a addObject:node.item];
    }
    return [NSArray arrayWithArray:a];
}

// Enumerates over the items in this list. From http://cocoawithlove.com/2008/05/implementing-countbyenumeratingwithstat.html
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])stackbuf count:(NSUInteger)len {
    assert (sizeof(Node *) <= sizeof(unsigned long));
    if(state->state == 0) {
        state->mutationsPtr = &size;
        state->extra[0] = (long)head;
        state->state = 1;
    }
    Node *node = (__bridge Node *)((void *)state->extra[0]);
    NSUInteger i;
    for (i = 0; i < len && node != nil; i++) {
        stackbuf[i] = node.item;
        node = node.next;
    }
    state->extra[0] = (unsigned long)node;
    state->itemsPtr = stackbuf;
    return i;
}


#pragma mark - FRList methods

- (void)addAtIndex:(NSUInteger)index item:(id)item {
    if(index > size) {
        @throw [NSException exceptionWithName:NSRangeException reason:[NSString stringWithFormat:FRErrBadIndex, (unsigned long)index] userInfo:nil];
    }
    else if(index == size) {
        [self offerAfterNode:tail item:item];
    }
    else {
        [self offerBeforeNode:[self nodeAtIndex:index] item:item];
    }
}

- (void)clear {
    for(Node *node = head, *next=nil; node; node = next) {
        next = node.next;
        node.prev = node.next = nil;
        node.item = nil;
    }
    head = tail = nil;
    size = 0;
}

- (NSUInteger)indexOf:(id)item {
    if(!item)  { return NSNotFound; }
    NSUInteger index = 0;
    for(Node *node = head; node; node = node.next) {
        if([node.item isEqual: item]) { return index; }
        index++;
    }
    return NSNotFound;
}

- (id)get:(NSUInteger)index {
    return [self nodeAtIndex:index].item;
}

- (id)removeAtIndex:(NSUInteger)index {
    Node* node = [self nodeAtIndex:index];
    [self removeNode:node];
    return node.item;
}


#pragma mark - FRQueue methods

- (BOOL)offer:(id)item {
    return [self offerLast:item];
}

- (id)element {
    if(!head) {
        @throw [NSException exceptionWithName:NSRangeException reason:FRErrEmpty userInfo:nil];
    }
    return [self peekFirst];
}

- (id)peek {
    return [self peekFirst];
}

- (id)remove {
    if(!head) {
        @throw [NSException exceptionWithName:NSRangeException reason:FRErrEmpty userInfo:nil];
    }
    return [self removeFirst];
}

- (id)poll {
    return [self pollFirst];
}


#pragma mark - FRDeque methods

- (BOOL)offerFirst:(id)item {
    return head ? [self offerBeforeNode:head item:item] : [self offerOriginItem:item];
}

- (void)addFirst:(id)item {
    if(![self offerFirst:item]) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:FRErrCannotInsert userInfo:nil];
    }
}

- (id)peekFirst {
    return head ? head.item : nil;
}

- (id)getFirst {
    if(!head) {
        @throw [NSException exceptionWithName:NSRangeException reason:FRErrEmpty userInfo:nil];
    }
    return [self peekFirst];
}

- (id)pollFirst {
    return head ? [self removeFirst] : nil;
}

- (id)removeFirst {
    if(!head) {
        @throw [NSException exceptionWithName:NSRangeException reason:FRErrEmpty userInfo:nil];
    }
    id item = head.item;
    [self removeNode:head];
    return item;
}

- (BOOL)offerLast:(id)item {
    return tail ? [self offerAfterNode:tail item:item] : [self offerOriginItem:item];
}

- (void)addLast:(id)item {
    if(![self offerLast:item]) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:FRErrCannotInsert userInfo:nil];
    }
}

- (id)peekLast {
    return tail ? tail.item : nil;
}

- (id)getLast {
    if(!tail) {
        @throw [NSException exceptionWithName:NSRangeException reason:FRErrEmpty userInfo:nil];
    }
    return [self peekLast];
}

- (id)pollLast {
    return tail ? [self removeLast] : nil;
}

- (id)removeLast {
    if(!tail) {
        @throw [NSException exceptionWithName:NSRangeException reason:FRErrEmpty userInfo:nil];
    }
    id item = tail.item;
    [self removeNode:tail];
    return item;
}


#pragma mark - FRStack methods

- (id)pop {
    if(!head) {
        @throw [NSException exceptionWithName:NSRangeException reason:FRErrEmpty userInfo:nil];
    }
    return [self removeFirst];
}

- (void)push:(id)item {
    [self addFirst:item];
}

@end


#pragma mark - Support for primitive data type: int

@implementation FRLinkedList (WithInt)

- (BOOL)offerIntValue:(int)item {
    return [self offer:[NSNumber numberWithInt:item]];
}

- (int)elementIntValue {
    return [(NSNumber*)[self element] intValue];
}

- (int)peekIntValue {
    return [(NSNumber*)[self peek] intValue];
}

- (int)removeIntValue {
    return [(NSNumber*)[self remove] intValue];
}

- (int)pollIntValue {
    return [(NSNumber*)[self poll] intValue];
}

- (BOOL)offerFirstIntValue:(int)item {
    return [self offerFirst:[NSNumber numberWithInt:item]];
}

- (void)addFirstIntValue:(int)item {
    [self addFirst:[NSNumber numberWithInt:item]];
}

- (int)peekFirstIntValue {
    return [(NSNumber*)[self peekFirst] intValue];
}

- (int)getFirstIntValue {
    return [(NSNumber*)[self getFirst] intValue];
}

- (int)pollFirstIntValue {
    return [(NSNumber*)[self pollFirst] intValue];
}

- (int)removeFirstIntValue {
    return [(NSNumber*)[self removeFirst] intValue];
}

- (BOOL)offerLastIntValue:(int)item {
    return [self offerLast:[NSNumber numberWithInt:item]];
}

- (void)addLastIntValue:(int)item {
    [self addLast:[NSNumber numberWithInt:item]];
}

- (int)peekLastIntValue {
    return [(NSNumber*)[self peekLast] intValue];
}

- (int)getLastIntValue {
    return [(NSNumber*)[self getLast] intValue];
}

- (int)pollLastIntValue {
    return [(NSNumber*)[self pollLast] intValue];
}

- (int)removeLastIntValue {
    return [(NSNumber*)[self removeLast] intValue];
}

- (int)popIntValue {
    return [((NSNumber*)[self pop]) intValue];
}

- (void)pushIntValue:(int)item {
    [self push:[NSNumber numberWithInt:item]];
}

@end


#pragma mark - Support for primitive data type: NSInteger

@implementation FRLinkedList (WithInteger)

- (BOOL)offerIntegerValue:(NSInteger)item {
    return [self offer:[NSNumber numberWithInteger:item]];
}

- (NSInteger)elementIntegerValue {
    return [(NSNumber*)[self element] integerValue];
}

- (NSInteger)peekIntegerValue {
    return [(NSNumber*)[self peek] integerValue];
}

- (NSInteger)removeIntegerValue {
    return [(NSNumber*)[self remove] integerValue];
}

- (NSInteger)pollIntegerValue {
    return [(NSNumber*)[self poll] integerValue];
}

- (BOOL)offerFirstIntegerValue:(NSInteger)item {
    return [self offerFirst:[NSNumber numberWithInteger:item]];
}

- (void)addFirstIntegerValue:(NSInteger)item {
    [self addFirst:[NSNumber numberWithInteger:item]];
}

- (NSInteger)peekFirstIntegerValue {
    return [(NSNumber*)[self peekFirst] integerValue];
}

- (NSInteger)getFirstIntegerValue {
    return [(NSNumber*)[self getFirst] integerValue];
}

- (NSInteger)pollFirstIntegerValue {
    return [(NSNumber*)[self pollFirst] integerValue];
}

- (NSInteger)removeFirstIntegerValue {
    return [(NSNumber*)[self removeFirst] integerValue];
}

- (BOOL)offerLastIntegerValue:(NSInteger)item {
    return [self offerLast:[NSNumber numberWithInteger:item]];
}

- (void)addLastIntegerValue:(NSInteger)item {
    [self addLast:[NSNumber numberWithInteger:item]];
}

- (NSInteger)peekLastIntegerValue {
    return [(NSNumber*)[self peekLast] integerValue];
}

- (NSInteger)getLastIntegerValue {
    return [(NSNumber*)[self getLast] integerValue];
}

- (NSInteger)pollLastIntegerValue {
    return [(NSNumber*)[self pollLast] integerValue];
}

- (NSInteger)removeLastIntegerValue {
    return [(NSNumber*)[self removeLast] integerValue];
}

- (NSInteger)popIntegerValue {
    return [((NSNumber*)[self pop]) integerValue];
}

- (void)pushIntegerValue:(NSInteger)item {
    [self push:[NSNumber numberWithInteger:item]];
}

@end


#pragma mark - Support for primitive data type: float

@implementation FRLinkedList (WithFloat)

- (BOOL)offerFloatValue:(float)item {
    return [self offer:[NSNumber numberWithFloat:item]];
}

- (float)elementFloatValue {
    return [(NSNumber*)[self element] floatValue];
}

- (float)peekFloatValue {
    return [(NSNumber*)[self peek] floatValue];
}

- (float)removeFloatValue {
    return [(NSNumber*)[self remove] floatValue];
}

- (float)pollFloatValue {
    return [(NSNumber*)[self poll] floatValue];
}

- (BOOL)offerFirstFloatValue:(float)item {
    return [self offerFirst:[NSNumber numberWithFloat:item]];
}

- (void)addFirstFloatValue:(float)item {
    [self addFirst:[NSNumber numberWithFloat:item]];
}

- (float)peekFirstFloatValue {
    return [(NSNumber*)[self peekFirst] floatValue];
}

- (float)getFirstFloatValue {
    return [(NSNumber*)[self getFirst] floatValue];
}

- (float)pollFirstFloatValue {
    return [(NSNumber*)[self pollFirst] floatValue];
}

- (float)removeFirstFloatValue {
    return [(NSNumber*)[self removeFirst] floatValue];
}

- (BOOL)offerLastFloatValue:(float)item {
    return [self offerLast:[NSNumber numberWithFloat:item]];
}

- (void)addLastFloatValue:(float)item {
    [self addLast:[NSNumber numberWithFloat:item]];
}

- (float)peekLastFloatValue {
    return [(NSNumber*)[self peekLast] floatValue];
}

- (float)getLastFloatValue {
    return [(NSNumber*)[self getLast] floatValue];
}

- (float)pollLastFloatValue {
    return [(NSNumber*)[self pollLast] floatValue];
}

- (float)removeLastFloatValue {
    return [(NSNumber*)[self removeLast] floatValue];
}

- (float)popFloatValue {
    return [((NSNumber*)[self pop]) floatValue];
}

- (void)pushFloatValue:(float)item {
    [self push:[NSNumber numberWithFloat:item]];
}

@end


#pragma mark - Support for primitive data type: double

@implementation FRLinkedList (WithDouble)

- (BOOL)offerDoubleValue:(double)item {
    return [self offer:[NSNumber numberWithDouble:item]];
}

- (double)elementDoubleValue {
    return [(NSNumber*)[self element] doubleValue];
}

- (double)peekDoubleValue {
    return [(NSNumber*)[self peek] doubleValue];
}

- (double)removeDoubleValue {
    return [(NSNumber*)[self remove] doubleValue];
}

- (double)pollDoubleValue {
    return [(NSNumber*)[self poll] doubleValue];
}

- (BOOL)offerFirstDoubleValue:(double)item {
    return [self offerFirst:[NSNumber numberWithDouble:item]];
}

- (void)addFirstDoubleValue:(double)item {
    [self addFirst:[NSNumber numberWithDouble:item]];
}

- (double)peekFirstDoubleValue {
    return [(NSNumber*)[self peekFirst] doubleValue];
}

- (double)getFirstDoubleValue {
    return [(NSNumber*)[self getFirst] doubleValue];
}

- (double)pollFirstDoubleValue {
    return [(NSNumber*)[self pollFirst] doubleValue];
}

- (double)removeFirstDoubleValue {
    return [(NSNumber*)[self removeFirst] doubleValue];
}

- (BOOL)offerLastDoubleValue:(double)item {
    return [self offerLast:[NSNumber numberWithDouble:item]];
}

- (void)addLastDoubleValue:(double)item {
    [self addLast:[NSNumber numberWithDouble:item]];
}

- (double)peekLastDoubleValue {
    return [(NSNumber*)[self peekLast] doubleValue];
}

- (double)getLastDoubleValue {
    return [(NSNumber*)[self getLast] doubleValue];
}

- (double)pollLastDoubleValue {
    return [(NSNumber*)[self pollLast] doubleValue];
}

- (double)removeLastDoubleValue {
    return [(NSNumber*)[self removeLast] doubleValue];
}

- (double)popDoubleValue {
    return [((NSNumber*)[self pop]) doubleValue];
}

- (void)pushDoubleValue:(double)item {
    [self push:[NSNumber numberWithDouble:item]];
}

@end



