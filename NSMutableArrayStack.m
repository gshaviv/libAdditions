//
//  NSMutableArrayStack.m
//  HotVOD
//
//  Created by Guy Shaviv on 12/30/09.
//  Copyright 2009 .. All rights reserved.
//

#import "NSMutableArrayStack.h"


@implementation NSMutableArray (Stack)

- (void) push:(id)object {
	[self addObject:object];
}

- (id) pop {
	id object = [self lastObject];
	[object retain];
	[self removeLastObject];
	return [object autorelease];
}

@end
