//
//  SEGObserver.h
//  SEGObserving
//
//  Created by Samuel E. Giddins on 7/2/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

@interface SEGObserver : NSObject

- (void)addObservationWithObject:(id) object keyPath:(NSString *)keyPath block:(void (^)(id object, NSString *keyPath, id value))block;

@end
