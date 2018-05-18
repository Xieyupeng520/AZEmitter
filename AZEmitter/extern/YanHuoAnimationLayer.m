//
//  YanHuoAnimationLayer.m
//  AZEmitter
//
//  Created by cocozzhang on 2018/5/18.
//  Copyright © 2018年 cocozzhang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "YanHuoAnimationLayer.h"

@implementation YanHuoAnimationLayer

+ (CALayer*)createYanHuoWithFrame:(CGRect)frame {
    // Cells spawn in the bottom, moving up
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    CGRect viewBounds = frame;
    fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height);
    fireworksEmitter.emitterSize    = CGSizeMake(1, 0.0);
    fireworksEmitter.emitterMode    = kCAEmitterLayerOutline;
    fireworksEmitter.emitterShape    = kCAEmitterLayerLine;
    fireworksEmitter.renderMode        = kCAEmitterLayerAdditive;
    //fireworksEmitter.seed = 500;//(arc4random()%100)+300;
    
    // Create the rocket
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    
    rocket.birthRate        = 6.0;
    rocket.emissionRange    = 0.12 * M_PI;  // some variation in angle
    rocket.velocity            = 500;
    rocket.velocityRange    = 150;
    rocket.yAcceleration    = 0;
    rocket.lifetime            = 2.02;    // we cannot set the birthrate < 1.0 for the burst
    
    rocket.contents            = (id) [[UIImage imageNamed:@"ball"] CGImage];
    rocket.scale            = 0.2;
    //    rocket.color            = [[UIColor colorWithRed:1 green:0 blue:0 alpha:1] CGColor];
    rocket.greenRange        = 1.0;        // different colors
    rocket.redRange            = 1.0;
    rocket.blueRange        = 1.0;
    
    rocket.spinRange        = M_PI;        // slow spin
    
    
    
    // the burst object cannot be seen, but will spawn the sparks
    // we change the color here, since the sparks inherit its value
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    
    burst.birthRate            = 1.0;        // at the end of travel
    burst.velocity            = 0;
    burst.scale                = 2.5;
    burst.redSpeed            =-1.5;        // shifting
    burst.blueSpeed            =+1.5;        // shifting
    burst.greenSpeed        =+1.0;        // shifting
    burst.lifetime            = 0.35;
    
    // and finally, the sparks
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate            = 666;
    spark.velocity            = 125;
    spark.emissionRange        = 2* M_PI;    // 360 deg
    spark.yAcceleration        = 75;        // gravity
    spark.lifetime            = 3;
    
    spark.contents            = (id) [[UIImage imageNamed:@"fire"] CGImage];
    spark.scale                =0.5;
    spark.scaleSpeed        =-0.2;
    spark.greenSpeed        =-0.1;
    spark.redSpeed            = 0.4;
    spark.blueSpeed            =-0.1;
    spark.alphaSpeed        =-0.5;
    spark.spin                = 2* M_PI;
    spark.spinRange            = 2* M_PI;
    
    // putting it together
    fireworksEmitter.emitterCells    = [NSArray arrayWithObject:rocket];
    rocket.emitterCells                = [NSArray arrayWithObject:burst];
    burst.emitterCells                = [NSArray arrayWithObject:spark];
    
    return fireworksEmitter;
}
@end
