#import "NSNotificationCenterAdditions.h"


@implementation NSNotificationCenter (NSNotificationCenterAdditions)
- (void) postNotificationOnMainThread:(NSNotification *) notification {
	if ([NSThread isMainThread]) return [self postNotification:notification];
	[self postNotificationOnMainThread:notification waitUntilDone:NO];
}

- (void) postNotificationOnMainThread:(NSNotification *) notification waitUntilDone:(BOOL) wait {
	if ([NSThread isMainThread]) return [self postNotification:notification];
	[[self class] performSelectorOnMainThread:@selector( _postNotification: ) withObject:notification waitUntilDone:wait];
}

+ (void) _postNotification:(NSNotification *) notification {
	[[self defaultCenter] postNotification:notification];
}

- (void) postNotificationOnMainThreadWithName:(NSString *) name object:(id) object {
	if ([NSThread isMainThread]) return [self postNotificationName:name object:object userInfo:nil];
	[self postNotificationOnMainThreadWithName:name object:object userInfo:nil waitUntilDone:NO];
}

- (void) postNotificationOnMainThreadWithName:(NSString *) name object:(id) object userInfo:(NSDictionary *) userInfo {
	if ([NSThread isMainThread]) return [self postNotificationName:name object:object userInfo:userInfo];
	[self postNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntilDone:NO];
}

- (void) postNotificationOnMainThreadWithName:(NSString *) name object:(id) object userInfo:(NSDictionary *) userInfo waitUntilDone:(BOOL) wait {
	if ([NSThread isMainThread]) return [self postNotificationName:name object:object userInfo:userInfo];
	
	NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] init];
	info[@"name"] = name;
	if( object ) info[@"object"] = object;
	if( userInfo ) info[@"userInfo"] = userInfo;
	
	[[self class] performSelectorOnMainThread:@selector( _postNotificationName: ) withObject:info waitUntilDone:wait];
//	[info release];
}

+ (void) _postNotificationName:(NSDictionary *) info {
	NSString *name = info[@"name"];
	id object = info[@"object"];
	NSDictionary *userInfo = info[@"userInfo"];
	
	[[self defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}
@end

@implementation NSNotificationQueue (NSNotificationQueueAdditions)
- (void) enqueueNotificationOnMainThread:(NSNotification *) notification postingStyle:(NSPostingStyle) postingStyle {
	if ([NSThread isMainThread]) return [self enqueueNotification:notification postingStyle:postingStyle coalesceMask:( NSNotificationCoalescingOnName | NSNotificationCoalescingOnSender ) forModes:nil];
	[self enqueueNotificationOnMainThread:notification postingStyle:postingStyle coalesceMask:NSNotificationNoCoalescing forModes:nil];
}

- (void) enqueueNotificationOnMainThread:(NSNotification *) notification postingStyle:(NSPostingStyle) postingStyle coalesceMask:(unsigned) coalesceMask forModes:(NSArray *) modes {
	if ([NSThread isMainThread]) return [self enqueueNotification:notification postingStyle:postingStyle coalesceMask:coalesceMask forModes:modes];
	
	NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] init];
	info[@"notification"] = notification;
	info[@"postingStyle"] = [NSNumber numberWithUnsignedInt:postingStyle];
	info[@"coalesceMask"] = @(coalesceMask);
	if( modes ) info[@"modes"] = modes;
	
	[[self class] performSelectorOnMainThread:@selector( _enqueueNotification: ) withObject:info waitUntilDone:NO];
//	[info release];
}

+ (void) _enqueueNotification:(NSDictionary *) info {
	NSNotification *notification = info[@"notification"];
	NSPostingStyle postingStyle = [info[@"postingStyle"] unsignedIntValue];
	unsigned coalesceMask = [info[@"coalesceMask"] unsignedIntValue];
	NSArray *modes = info[@"modes"];
	
	[[self defaultQueue] enqueueNotification:notification postingStyle:postingStyle coalesceMask:coalesceMask forModes:modes];
}
@end