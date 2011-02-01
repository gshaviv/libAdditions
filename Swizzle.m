//
//  Swizzle.m
//  houzz
//
//  Created by Guy Shaviv on 4/4/10.
//  Copyright 2010 Tiv Studio. All rights reserved.
//

#import "Swizzle.h"


#import <objc/runtime.h> 
#import <objc/message.h>

void Swizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
		method_exchangeImplementations(origMethod, newMethod);
}
