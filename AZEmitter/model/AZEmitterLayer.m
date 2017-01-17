//
//  AZEmitterLayer.m
//  AZEmitter
//
//  Created by cocozzhang on 2017/1/16.
//  Copyright © 2017年 cocozzhang. All rights reserved.
//

#import "AZEmitterLayer.h"
#import "AZParticle.h"
@interface AZEmitterLayer() {
    CGFloat _animTime;
    CGFloat _animDuration;
    CADisplayLink* _displayLink;
    int _count;
}
@end
@implementation AZEmitterLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.masksToBounds = NO;
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(emitterAnim:)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        _animTime = 0;
        _animDuration = 10;
        _count = 0;
    }
    return self;
}

- (void)emitterAnim:(CADisplayLink*)displayLink {
    [self setNeedsDisplay];
    _animTime += 0.2;
}

-(void)drawInContext:(CGContextRef)ctx {
    int count = 0;
    for (AZParticle *particle in _particleArray) {
        if (particle.delayTime > _animTime) {
            continue;
        }

        CGFloat curTime = _animTime - particle.delayTime;
        if (curTime >= _animDuration + particle.delayDuration) { //到达了目的地的粒子原地等待下没到达的粒子
            curTime =  _animDuration + particle.delayDuration;
            count ++;
        }
        
        CGFloat curX = [self easeInOutQuad:curTime begin:self.bounds.size.width/2 end:particle.orignPoint.x + self.bounds.size.width/2-CGImageGetWidth(_image.CGImage)/2 duration:_animDuration + particle.delayDuration];
        CGFloat curY = [self easeInOutQuad:curTime begin:0 end:particle.orignPoint.y + self.bounds.size.height/2 - CGImageGetHeight(_image.CGImage)/2 duration:_animDuration + particle.delayDuration];
        particle.point = CGPointMake(curX, curY);
        CGContextAddEllipseInRect(ctx, CGRectMake(curX , curY , 1, 1));
        const CGFloat* components = CGColorGetComponents(particle.color.CGColor);
        CGContextSetRGBFillColor(ctx, components[0], components[1], components[2], components[3]);
        CGContextFillPath(ctx);
        
//        if (particle.point.x == particle.orignPoint.x
//            && particle.point.y == particle.orignPoint.y) {
//            count ++;
//        }
    }
    if (count == _particleArray.count) {
        [self reset];
        if (_azDelegate && [_azDelegate respondsToSelector:@selector(onAnimEnd)]) {
            [_azDelegate onAnimEnd];
        }
    }
}
/*! http://www.cnblogs.com/chengguanhui/p/4664144.html
 * 参数描述
 * time 动画执行到当前帧所进过的时间
 * beginPosition 起始的位置
 * endPosition 结束的位置
 * duration 持续时间
 */
- (CGFloat)easeInOutQuad:(CGFloat)time begin:(CGFloat)beginPosition end:(CGFloat)endPosition duration:(CGFloat)duration {
    CGFloat coverDistance = endPosition - beginPosition;
    time /= duration/2;
    if (time < 1) {
        return coverDistance/2 * pow(time, 2) + beginPosition;
    }
    time --;
    return -coverDistance/2 * (time*(time-2)-1) + beginPosition;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _particleArray = [self getRGBAsFromImage:image];
}

- (NSArray*)getRGBAsFromImage:(UIImage*)image {
    //1. get the image into your data buffer.
    CGImageRef imageRef = [image CGImage];
    NSUInteger imageW = CGImageGetWidth(imageRef);
    NSUInteger imageH = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerPixel = 4; //一个像素4字节
    NSUInteger bytesPerRow = bytesPerPixel * imageW;
    unsigned char *rawData = (unsigned char*)calloc(imageH*imageW*bytesPerPixel, sizeof(unsigned char)); //元数据
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, imageW, imageH, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, imageW, imageH), imageRef);
    CGContextRelease(context);
    
    //2. Now your rawData contains the image data in the RGBA8888 pixel format.
    NSMutableArray *result = [NSMutableArray new];
    for (int y = 0; y < imageH; y++) {
        for (int x = 0; x < imageW; x++) {
            NSUInteger byteIndex = bytesPerRow*y + bytesPerPixel*x;
            //rawData一维数组存储方式RGBA(第一个像素)RGBA(第二个像素)...
            CGFloat red   = ((CGFloat) rawData[byteIndex]     ) / 255.0f;
            CGFloat green = ((CGFloat) rawData[byteIndex + 1] ) / 255.0f;
            CGFloat blue  = ((CGFloat) rawData[byteIndex + 2] ) / 255.0f;
            CGFloat alpha = ((CGFloat) rawData[byteIndex + 3] ) / 255.0f;
            if (alpha == 0 || (red+green+blue == 3)) {
//                NSLog(@"在（%d,%d）位置是透明的", x, y);
                continue;
            }
            
            AZParticle *particle = [AZParticle new];
            particle.color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
            particle.orignColor = particle.color;
            particle.point = CGPointMake(x, y);
            particle.orignPoint = particle.point;
//            particle.customColor = [UIColor colorWithRed:0x00/255.f green:0x6e/255.f blue:0xff/255.f alpha:1];
//            particle.randomPointRange = 5;
            [result addObject:particle];
        }
    }
    free(rawData);
    return result;
}

-(void)pause {
    _displayLink.paused = YES;
}
-(void)resume {
    _displayLink.paused = NO;
}
-(void)reset {
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
        _animTime = 0;
    }
}

-(void)restart {
    [self reset];
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(emitterAnim:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
@end

