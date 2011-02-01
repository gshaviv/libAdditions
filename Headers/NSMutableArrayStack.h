//
//  NSMutableArrayStack.h
//  HotVOD
//
//  Created by Guy Shaviv on 12/30/09.
//  Copyright 2009 .. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableArray (Stack) 

- (void) push:(id)object;
- (id) pop;

@end
