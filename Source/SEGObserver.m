//
//  SEGObserver.m
//  SEGObserving
//
//  Created by Samuel E. Giddins on 7/2/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "SEGObserver.h"

typedef void(^SEGObservationBlock)(id, NSString *, id);

@interface SEGObserver ()

@property (nonatomic, retain) NSMutableArray *observations;

@end



@interface SEGObservation : NSObject

@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, weak) id object;
@property (nonatomic, copy) SEGObservationBlock observationBlock;

@end

@implementation SEGObserver

- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _observations = [NSMutableArray array];
    
    return self;
}

- (void)addObservationWithObject:(id)object keyPath:(NSString *)keyPath block:(void (^)(id, NSString *, id))block
{
    SEGObservation *observation = [SEGObservation new];
    observation.object = object;
    observation.keyPath = keyPath;
    observation.observationBlock = block;
    [object addObserver:observation forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    [self.observations addObject:observation];
}

- (void)dealloc
{
    self.observations = nil;
}

@end

@implementation SEGObservation

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:self.keyPath] && object == self.object) {
        self.observationBlock(object, keyPath, [object valueForKeyPath:keyPath]);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    [self.object removeObserver:self];
}

@end