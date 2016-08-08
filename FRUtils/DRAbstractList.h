//
//  DRAbstractList.h
//  DRUtils
//
//  Created by Florin on 2/1/16.
//  Copyright © 2016 Florin. All rights reserved.
//
//  An abstract list.
//

#ifndef DRAbstractList_h
#define DRAbstractList_h

#import <Foundation/Foundation.h>
#import "DRList.h"

@interface DRAbstractList : NSObject <DRList>

/*!
 * Enumerates over the items in this list.
 */
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])stackbuf count:(NSUInteger)len;

@end

#endif