//
//  ViewController.m
//  AZEmitter
//
//  Created by AZZ on 2017/1/16.
//  Copyright © 2017年 AZZ. All rights reserved.
//

#import "ViewController.h"
#import "AZParticle.h"
#import "AZEmitterLayer.h"
#import "YQAnimationLayer.h"
#import "YanHuoAnimationLayer.h"
@interface ViewController () <AZEmitterLayerDelegate> {
    UIButton *_button;
    void (^_endBlock)(void);
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self showQQ];
//    [self showTiger];
//    [self showQCloud];
    
    [self showHappy6SNG];
}

- (void)showTiger {
    UIImage* image = [UIImage imageNamed:@"tiger.jpg"];//qcloud.jpg|timg.jpeg|qq.png|tiger.jpg
    
    AZEmitterLayer* azEmitterLayer = [AZEmitterLayer new];
    azEmitterLayer.bounds = self.view.bounds;
    azEmitterLayer.position = self.view.center;
    azEmitterLayer.beginPoint = self.view.center;
    azEmitterLayer.maxParticleCount = 300;
    azEmitterLayer.randomPointRange = 1.5;
    azEmitterLayer.ignoredWhite = YES;
    azEmitterLayer.image = image;
    azEmitterLayer.azDelegate = self;
    [self.view.layer addSublayer:azEmitterLayer];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setTitle:@"restart" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _button.frame = CGRectMake(self.view.bounds.size.width - 100, self.view.bounds.size.height - 50, 0, 0);
    [_button sizeToFit];
    _button.alpha = 0;
    [_button addTarget:azEmitterLayer action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
}

- (void)showQCloud {
    self.view.backgroundColor = [UIColor colorWithRed:0x10/255.f green:0x0c/255.f blue:0x2b/255.f alpha:1];
    
    UIImage* image = [UIImage imageNamed:@"qcloud.jpg"];
    
    AZEmitterLayer* azEmitterLayer = [AZEmitterLayer new];
    azEmitterLayer.bounds = self.view.bounds;
    azEmitterLayer.position = self.view.center;
    azEmitterLayer.beginPoint = CGPointMake(self.view.center.x, self.view.bounds.size.height);
    azEmitterLayer.ignoredWhite = YES;
    azEmitterLayer.maxParticleCount = 150;
    azEmitterLayer.randomPointRange = 8;
    azEmitterLayer.customColor = [UIColor colorWithRed:0x00/255.f green:0x6e/255.f blue:0xff/255.f alpha:1];
    azEmitterLayer.image = image;
    azEmitterLayer.azDelegate = self;
    [self.view.layer addSublayer:azEmitterLayer];
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button setTitle:@"restart" forState:UIControlStateNormal];
    [_button sizeToFit];
    _button.center = CGPointMake(self.view.center.x, 150);
    _button.alpha = 0;
    [_button addTarget:azEmitterLayer action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

- (void)showQQ {
    UIImage* image = [UIImage imageNamed:@"qq.png"];//qcloud.jpg|timg.jpeg|qq.png|tiger.jpg
    
    AZEmitterLayer* azEmitterLayer = [AZEmitterLayer new];
    azEmitterLayer.bounds = self.view.bounds;
    azEmitterLayer.position = self.view.center;
    azEmitterLayer.beginPoint = CGPointMake(self.view.center.x, 0);
    azEmitterLayer.ignoredWhite = YES;
    azEmitterLayer.image = image;
    azEmitterLayer.azDelegate = self;
    [self.view.layer addSublayer:azEmitterLayer];
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button setTitle:@"手机QQ，乐在沟通" forState:UIControlStateNormal];
    [_button sizeToFit];
    _button.center = CGPointMake(self.view.center.x, 150);
    _button.alpha = 0;
    [_button addTarget:azEmitterLayer action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

- (void)showHappy6SNG { //SNG6周年快乐！~
//    self.view.backgroundColor = [UIColor colorWithRed:241/255.f green:240/255.f blue:248/255.f alpha:1];
    
    [self showQQ];
    [_button removeFromSuperview];
    
    __weak typeof(self) weakSelf = self;
//    _endBlock = ^() {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        YQAnimationLayer *yqlayer = [YQAnimationLayer createAnimationLayerWithString:@"SNG六周年快乐!" andRect: CGRectMake(0, 100, weakSelf.view.frame.size.width, weakSelf.view.frame.size.width) andView:weakSelf.view andFont:[UIFont boldSystemFontOfSize:40] andStrokeColor:[UIColor cyanColor]];
        [yqlayer removeFromSuperlayer];
        
        //颜色渐变
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = yqlayer.bounds;
        [gradientLayer setMask:yqlayer];
        
        gradientLayer.colors = @[(__bridge id)[UIColor yellowColor].CGColor,
                                 (__bridge id)[UIColor redColor].CGColor,
                                 (__bridge id)[UIColor orangeColor].CGColor,
                                 (__bridge id)[UIColor blueColor].CGColor,
                                 (__bridge id)[UIColor cyanColor].CGColor,
                                 (__bridge id)[UIColor greenColor].CGColor];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
        [weakSelf.view.layer addSublayer:gradientLayer];
        
        //焰火
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CALayer* yanhuo = [YanHuoAnimationLayer createYanHuoWithFrame:weakSelf.view.bounds];
            [weakSelf.view.layer addSublayer:yanhuo];
        });
    });

//    };
}

//隐藏iPhone X上的底部横条
- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

#pragma mark - AZEmitterLayerDelegate
- (void)onAnimEnd {
    [UIView animateWithDuration:2 animations:^{
        _button.alpha = 1;
    }];
    
    if (_endBlock) {
        _endBlock();
    }
}
@end
