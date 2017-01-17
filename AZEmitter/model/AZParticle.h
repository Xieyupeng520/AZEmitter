//
//  Particle.h
//  AZEmitter
//
//  Created by cocozzhang on 2017/1/16.
//  Copyright © 2017年 cocozzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AZParticle : NSObject
@property(nonatomic, strong)UIColor* color;
@property(nonatomic, assign)CGPoint point;

@property(nonatomic, strong)UIColor* orignColor;
@property(nonatomic, assign)CGPoint orignPoint;

@property(nonatomic, strong)UIColor* customColor;
@property(nonatomic, assign)CGFloat randomPointRange; //[-n,n),n>=0

@property(nonatomic, assign)CGFloat delayTime;
@property(nonatomic, assign)CGFloat delayDuration;
@end
