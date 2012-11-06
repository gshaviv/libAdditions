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
	PRIORITY_HIGH = DISPATCH_QUEUE_PRIORITY_HIGH,
	PRIORITY_DEFAULT = DISPATCH_QUEUE_PRIORITY_DEFAULT,
	PRIORITY_LOW = DISPATCH_QUEUE_PRIORITY_LOW,
    PRIORITY_BACKGROUND = DISPATCH_QUEUE_PRIORITY_BACKGROUND
} queue_priority_t;

static inline void dispatch_async_priority(queue_priority_t priority, dispatch_block_t block) {
	dispatch_async(dispatch_get_global_queue(priority,0),block);
}
static inline void dispatch_to_background(dispatch_block_t block) {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),block);
}
static inline void dispatch_sync_priority(queue_priority_t priority, dispatch_block_t block) {
	dispatch_sync(dispatch_get_global_queue(priority,0),block);
}

static inline void if_needed_dispatch_sync_main(dispatch_block_t block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(),block);
    }
}

static inline void if_needed_dispatch_async_main(dispatch_block_t block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(),block);
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
static inline void if_needed_dispatch_async(dispatch_queue_t queue, dispatch_block_t block) {
    if (dispatch_get_current_queue() == queue) {
        block();
    } else {
        dispatch_async(queue,block);
    }
}


static inline void if_needed_dispatch_sync(dispatch_queue_t queue, dispatch_block_t block) {
    if (dispatch_get_current_queue() == queue) {
        block();
    } else {
        dispatch_sync(queue,block);
    }
}
#pragma clang diagnostic pop




#endif