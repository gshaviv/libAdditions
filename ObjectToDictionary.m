//
//  NSDictionary+ObjectToDictionary.m
//  AdditionsLib
//
//  Created by Guy Shaviv on 30/9/11.
//  Copyright (c) 2011 LitePoint Corp. All rights reserved.
//

#import "ObjectToDictionary.h"

@implementation NSDictionary (ObjectToDictionary)
- (id) createObject {
    Class objclass = NSClassFromString([self objectForKey:@"class"]);
    if (!objclass) return nil;
    NSLog(@"objclas=%@",objclass);
    return [[objclass alloc] initWithContentOfDictionary:self];
}
@end

@implementation NSArray (ObjectToDictionary)

- (NSMutableArray*) readArray:(NSArray*)array {
    NSMutableArray *collection = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        id obj = [dict createObject];
        if (obj)
            [collection addObject:obj];
    }
    return collection;
}

- (NSArray*) arrayWithDictionaries {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj respondsToSelector:@selector(contentsTodictionary)]) {
            [array addObject:[obj contentsTodictionary]];
        }
    }];
    return array;
}

- (NSDictionary*) contentsTodictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:NSStringFromClass([self class]) forKey:@"class"];
    [dict setObject:[self arrayWithDictionaries] forKey:@"array"];
    return dict;
}

- (id) initWithContentOfDictionary:(NSDictionary *)dict {
    return [NSArray arrayWithArray:[self readArray:[dict objectForKey:@"array"]]];
}

@end

@implementation NSMutableArray (ObjectToDictionary)
- (id) initWithContentOfDictionary:(NSDictionary *)dict {
    return [self readArray:[dict objectForKey:@"array"]];
}
- (NSDictionary*) contentsTodictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:NSStringFromClass([self class]) forKey:@"class"];
    [dict setObject:[self arrayWithDictionaries] forKey:@"array"];
    return dict;
}
@end