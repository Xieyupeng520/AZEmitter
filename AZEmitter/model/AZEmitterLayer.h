//
//  AZEmitterLayer.h
//  AZEmitter
//
//  Created by AZZ on 2017/1/16.
//  Copyright © 2017年 AZZ. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class UIImage;
@class UIColor;

@protocol AZEmitterLayerDelegate <NSObject>

-(void)onAnimEnd;

@end

@interface AZEmitterLayer : CALayer
@property(nonatomic, assign)CGPoint beginPoint; //粒子出生位置，默认在左边顶上
@property(nonatomic, assign)BOOL ignoredBlack; //忽略黑色，白色当做透明处理，默认为NO，必须在设置image前面设置
@property(nonatomic, assign)BOOL ignoredWhite; //忽略白色，白色当做透明处理，默认为NO，必须在设置image前面设置
@property(nonatomic, strong)UIColor* customColor; //改变粒子的颜色，必须在设置image前面设置
@property(nonatomic, assign)CGFloat randomPointRange; //[-n,n),n>=0，必须在设置image前面设置
/**
 * 每行/列最大粒子数,设为0时，即每个像素一个粒子，必须在设置image前面设置
 * 建议当图片较大时，粒子较多时设置
 */
@property(nonatomic,assign)uint32_t maxParticleCount;
@property(nonatomic,strong)UIImage* image; //设置后就确定了所有的粒子，一些要改变粒子属性的，要在该值设置之前改
@property(nonatomic,weak)id<AZEmitterLayerDelegate> azDelegate;

-(void)restart;
@end
