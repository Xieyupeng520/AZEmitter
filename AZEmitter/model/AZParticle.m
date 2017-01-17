//
//  Particle.m
//  AZEmitter
//
//  Created by cocozzhang on 2017/1/16.
//  Copyright © 2017年 cocozzhang. All rights reserved.
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

//-(CGPoint)point {
////    if (_randomPointRange != 0) {
////        _point.x = _point.x - _randomPointRange + arc4random_uniform(_randomPointRange*2);
////        _point.y = _point.y - _randomPointRange + arc4random_uniform(_randomPointRange*2);
////    }
//    return _point;
//}

- (void)setRandomPointRange:(CGFloat)randomPointRange {
    _randomPointRange = randomPointRange;
        if (_randomPointRange != 0) {
            _point.x = _point.x - _randomPointRange + arc4random_uniform(_randomPointRange*2);
            _point.y = _point.y - _randomPointRange + arc4random_uniform(_randomPointRange*2);
            
            _orignPoint.x = _point.x;
            _orignPoint.y = _point.y;
        }
}
@end
