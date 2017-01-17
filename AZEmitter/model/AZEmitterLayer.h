//
//  AZEmitterLayer.h
//  AZEmitter
//
//  Created by cocozzhang on 2017/1/16.
//  Copyright © 2017年 cocozzhang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class UIImage;

@protocol AZEmitterLayerDelegate <NSObject>

-(void)onAnimEnd;

@end

@interface AZEmitterLayer : CALayer
@property(nonatomic,strong)UIImage* image;
@property(nonatomic,strong)NSArray* particleArray;

@property(nonatomic,weak)id<AZEmitterLayerDelegate> azDelegate;

-(void)restart;
@end
