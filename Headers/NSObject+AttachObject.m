//
//  NSObject+AttachObject.m
//  houzz
//
//  Created by Guy Shaviv on 10/3/2013.
//
//

#import "NSObject+AttachObject.h"

@implementation NSObject (AttachObject)

- (void) setAssociatedObject:(id)obj forKey:(const char *)key policy:(AssociationPolicy)policy {
    objc_setAssociatedObject(self, key, obj, policy);
}

- (id) associatedObjectForKey:(const char *)key {
    return objc_getAssociatedObject(self, key);
}
@end
