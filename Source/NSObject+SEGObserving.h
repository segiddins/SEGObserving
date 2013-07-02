//
//  NSObject+SEGObserving.h
//  SEGObserving
//
//  Created by Samuel E. Giddins on 7/2/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SEGObserving)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object withBlock:(void (^)(id object, NSString *keyPath, id value))observer;

@end
