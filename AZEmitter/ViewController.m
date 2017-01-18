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
@interface ViewController () <AZEmitterLayerDelegate> {
    UIButton *_button;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showQQ];
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
#pragma mark - AZEmitterLayerDelegate
- (void)onAnimEnd {
    [UIView animateWithDuration:2 animations:^{
        _button.alpha = 1;
    }];
}
@end
