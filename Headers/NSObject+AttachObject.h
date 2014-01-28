//
//  NSObject+AttachObject.h
//  houzz
//
//  Created by Guy Shaviv on 10/3/2013.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef NS_ENUM(objc_AssociationPolicy, AssociationPolicy) {
    AssociationPolicyAssign = OBJC_ASSOCIATION_ASSIGN,
    AssociationPolicyStrongNonatomic =  OBJC_ASSOCIATION_RETAIN_NONATOMIC,
    AssociationPolicyCopyNonatomic =  OBJC_ASSOCIATION_COPY_NONATOMIC,
    AssociationPolicyStrong = OBJC_ASSOCIATION_RETAIN,
    AssociationPolicyCopy = OBJC_ASSOCIATION_COPY
};


@interface NSObject (AttachObject)
- (void) setAssociatedObject:(id)obj forKey:(const char *)key policy:(AssociationPolicy)policy;
- (id) associatedObjectForKey:(const char *)key;
@end
