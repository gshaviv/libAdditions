/*
 *  dispatchShortcuts.h
 *  AdditionsLib
 *
 *  Created by Guy Shaviv on 15/11/10.
 *  Copyright 2010 LitePoint Corp. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

#if NS_BLOCKS_AVAILABLE

static inline void dispatch_async_main(dispatch_block_t block) {
	dispatch_async(dispatch_get_main_queue(),block);
}
static inline void dispatch_sync_main(dispatch_block_t block) {
	dispatch_sync(dispatch_get_main_queue(),block);
}
typedef enum {
	PRIORITY_HIGH = 2,
	PRIORITY_DEFAULT = 0,
	PRIORITY_LOW = -2
} queue_priority_t;

static inline void dispatch_async_priority(queue_priority_t priority, dispatch_block_t block) {
	dispatch_async(dispatch_get_global_queue(priority,0),block);
}
static inline void dispatch_sync_priority(queue_priority_t priority, dispatch_block_t block) {
	dispatch_sync(dispatch_get_global_queue(priority,0),block);
}

#endif