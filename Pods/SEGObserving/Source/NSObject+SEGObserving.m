//
//  NSObject+SEGObserving.m
//  SEGObserving
//
//  Created by Samuel E. Giddins on 7/2/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "NSObject+SEGObserving.h"
#import "SEGObserver.h"

#import <objc/runtime.h>

@interface NSObject ()

@property (nonatomic, strong, setter = seg_setObserver:) SEGObserver *seg_observer;

@end

static char *const kSEGObserverKey = "kSEGObserverKey";

@implementation NSObject (SEGObserving)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object withBlock:(void (^)(id, NSString *, id))observer
{
    [self.seg_observer addObservationWithObject:object keyPath:keyPath block:observer];
}

- (SEGObserver *)seg_observer
{
    SEGObserver *observer = objc_getAssociatedObject(self, kSEGObserverKey);
    if (!observer) {
        observer = [SEGObserver new];
        self.seg_observer = observer;
    }
    return observer;
}

- (void)seg_setObserver:(SEGObserver *)seg_observer
{
    objc_setAssociatedObject(self, kSEGObserverKey, seg_observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
