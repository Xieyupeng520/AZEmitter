//
//  ViewController.m
//  AZEmitter
//
//  Created by cocozzhang on 2017/1/16.
//  Copyright © 2017年 cocozzhang. All rights reserved.
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
    
    UIImage* image = [UIImage imageNamed:@"qq.png"];//qcloud.jpg
    
    AZEmitterLayer* azEmitterLayer = [AZEmitterLayer new];
    azEmitterLayer.bounds = self.view.bounds;
    azEmitterLayer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    azEmitterLayer.image = image;
    [self.view.layer addSublayer:azEmitterLayer];
    [azEmitterLayer setNeedsDisplay];
    azEmitterLayer.azDelegate = self;
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button addTarget:azEmitterLayer action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

- (void)onAnimEnd {
    [_button setTitle:@"手机QQ，乐在沟通" forState:UIControlStateNormal];
    [_button sizeToFit];
    _button.center = CGPointMake(self.view.center.x, 100);
}
@end
