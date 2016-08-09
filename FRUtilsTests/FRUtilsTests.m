//
//  Tests.m
//  Tests
//
//  Created by Florin Rosca on 7/18/16.
//  Copyright © 2016 Florin Rosca. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FRUtils.h"

@interface FRUtilTests : XCTestCase

@end

@implementation FRUtilTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// ArrayList - begin
- (void)testArrayListWithIntProto {
    id<FRArrayListWithInt> list = [FRArrayList listWithCapacity: 5];
    [self testListWithInt:list];
}

- (void)testArrayListWithIntSuper {
    id<FRListWithInt> list = [FRArrayList listWithCapacity: 5];
    [self testListWithInt:list];
}
// ArrayList - end


// LinkedList - begin
- (void) testLinkedListWithInt {
    FRLinkedList *list = [FRLinkedList list];
    [self testListWithInt:list];
}

- (void) testLinkedListWithIntProto {
    id<FRLinkedListWithInt> list = [FRLinkedList list];
    [self testListWithInt:list];
}

- (void) testLinkedListWithIntSuper {
    id<FRListWithInt> list = [FRLinkedList list];
    [self testListWithInt:list];
}
// LinkedList - end


// List - begin
- (void)testListWithInt: (id<FRListWithInt>)list {
    XCTAssert(list.size == 0);
    for(int i = 0; i < 10; i++) {
        [list addIntValue:(i + 1)];
    }
    XCTAssert(list.size == 10);
    for(int i = 0; i < 10; i++) {
        XCTAssert([list getIntValue:i] == (i+1) );
    }
    // Make sure we are looking for an item equal to (not identical)
    XCTAssert([list containsIntValue:1] && [list containsIntValue:10] && ![list containsIntValue:11]);
    // Find the index of an item
    XCTAssert([list indexOfIntValue:1] == 0 && [list indexOfIntValue: 10] == 9 && [list indexOfIntValue: 11] == NSNotFound);
    // Remove by index (1)
    [list removeIntValueAtIndex:0];
    XCTAssert([list indexOfIntValue: 1] == NSNotFound && list.size == 9);
    // Remove by value (2)
    [list removeIntValue:2];
    XCTAssert([list indexOfIntValue: 2] == NSNotFound && list.size == 8 && [list getIntValue:0] == 3);
    // Clear the list
    [list clear];
    XCTAssert(list.size == 0);
}
// List - end


// Queue - begin
- (void) testQueueWithInt {
    id<FRQueueWithInt> queue = [FRLinkedList list];
    [self testQueueWithInt: queue];
}

- (void) testQueueWithInt: (id<FRQueueWithInt>)queue {
    // Add new items to the queue. New items are added to the tail of the queue (FIFO). Elements are removed from the top
    for(int i = 0; i < 10; i++) {
        [queue offerIntValue:i];
    }
    XCTAssert([queue size] == 10);
    XCTAssert([queue peekIntValue] == 0 && [queue size] == 10);
    XCTAssert([queue removeIntValue] == 0 && [queue size] == 9);
    XCTAssert([queue removeIntValue] == 1 && [queue size] == 8);
    
    [queue clear];
    XCTAssert([queue size] == 0);
}
// Queue - end


// Stack - begin
- (void)testStackWithInt {
    id<FRStackWithInt> stack = [FRLinkedList list];
    [self testStackWithInt:stack];
}

- (void)testStackWithInt: (id<FRStackWithInt>)stack {
    // Push new items to the stack. New items are inserted at the top of the stack (LIFO). Elements are removed from the top
    for(int i = 0; i < 10; i++) {
        [stack pushIntValue: i];
    }
    XCTAssert([stack size] == 10);
    XCTAssert([stack peekIntValue] == 9 && [stack size] == 10);
    XCTAssert([stack popIntValue] == 9 && [stack size] == 9);
    XCTAssert([stack popIntValue] == 8 && [stack size] == 8);
    
    [stack clear];
    XCTAssert([stack size] == 0);
}
// Stack - end


// PriorityQueue - begin
- (void)testPriorityQueue1 {
    id<FRPriorityQueueWithInt> pri = [FRPriorityQueue priorityQueue];
    [pri addIntValue:4];
    XCTAssert([FRPriorityQueue isMinHeapWithArray:[pri toArray]]);
    [pri addIntValue:2];
    XCTAssert([FRPriorityQueue isMinHeapWithArray:[pri toArray]]);
    [pri addIntValue:3];
    XCTAssert([FRPriorityQueue isMinHeapWithArray:[pri toArray]]);
    [pri addIntValue:1];
    XCTAssert([FRPriorityQueue isMinHeapWithArray:[pri toArray]]);
    
    XCTAssert([pri peekIntValue] == 1);
    int item = [pri pollIntValue];
    XCTAssert(item == 1);
    XCTAssert([FRPriorityQueue isMinHeapWithArray:[pri toArray]]);
    
    [pri clear];
    XCTAssert([pri size] == 0);
}
// PriorityQueue - end


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
