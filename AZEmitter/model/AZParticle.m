//
//  Particle.m
//  AZEmitter
//
//  Created by AZZ on 2017/1/16.
//  Copyright © 2017年 AZZ. All rights reserved.
//

#import "AZParticle.h"

@implementation AZParticle

- (instancetype)init {
    self = [super init];
    if (self) {
        _delayTime = arc4random_uniform(30);
        _delayDuration = arc4random_uniform(10);
    }
    return self;
}

-(UIColor*)color {
    if (_customColor) {
        return _customColor;
    }
    return _color;
}

- (void)setRandomPointRange:(CGFloat)randomPointRange {
    _randomPointRange = randomPointRange;
        if (_randomPointRange != 0) {
            _point.x = _point.x - _randomPointRange + arc4random_uniform(_randomPointRange*2);
            _point.y = _point.y - _randomPointRange + arc4random_uniform(_randomPointRange*2);
        }
}
@end
