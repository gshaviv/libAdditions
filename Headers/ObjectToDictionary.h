//
//  NSDictionary+ObjectToDictionary.h
//  AdditionsLib
//
//  Created by Guy Shaviv on 30/9/11.
//  Copyright (c) 2011 LitePoint Corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObjectToDictionary <NSObject>
- (NSDictionary*) contentsTodictionary;
- (id) initWithContentOfDictionary:(NSDictionary*)dict;
@end

@interface NSDictionary (ObjectToDictionary)
- (id) createObject;
@end

@interface NSMutableArray (ObjectToDictionary) <ObjectToDictionary>

@end

@interface NSArray (ObjectToDictionary) <ObjectToDictionary>

@end