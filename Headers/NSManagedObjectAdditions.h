//
//  NSManagedObjectAdditions.h
//  BeatVibeIpad
//
//  Created by Guy Shaviv on 19/5/10.
//  Copyright 2010 Tiv Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSManagedObject (Additions)

- (BOOL) save:(NSError**)error;
- (NSString*) stringRepresentation;

@end
