//
//  TMSmokeView.m
//  HydrologicalCycle
//
//  Created by Ankur Adhikari on 01/03/14.
//  Copyright (c) 2014 HydrologicalCycle. All rights reserved.
//

#import "TMSmokeView.h"
#import "TMStringConstants.h"

@interface TMSmokeView (){
    
	CAEmitterLayer *smokeEmitter;
}

@end


@implementation TMSmokeView
// 507, 170


- (CAEmitterLayer*) getEmitterLayer{
    //Create the smoke emitter layer
	CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    
    emitterLayer.emitterPosition = CGPointMake(20, self.layer.frame.size.height-10);
	emitterLayer.emitterMode = kCAEmitterLayerPoints;
    
    //Size of Emitter
    emitterLayer.emitterSize = CGSizeMake(1, 1);
    
    return emitterLayer;
}


- (CAEmitterCell*) getEmitterCell{
    
    CAEmitterCell* smoke = [CAEmitterCell emitterCell];
	smoke.birthRate = 10;
	smoke.lifetime = 0;
	smoke.velocity = 1;
//	smoke.spin = 1;
	smoke.spinRange = .7;
	smoke.yAcceleration = -15;
//	smoke.contents = (id) [UIImage imageNamed:@"smoke"].CGImage;
	smoke.scale = 0.1;
	smoke.alphaSpeed = -0.15;
    smoke.alphaRange = .3;
	smoke.scaleSpeed = .5;
    smoke.scaleRange = .3;
	
	//Name the cell so that it can be animated later using keypaths
	[smoke setName:@"smoke"];
    
    return smoke;

}



//===============================================================
//Creates emitter layer and set up its properties
//===============================================================
-(void) setUp{
    smokeEmitter = [self getEmitterLayer];
    smokeEmitter.emitterCells = @[[self getEmitterCell]];
    [smokeEmitter setValue:[NSNumber numberWithInt:5] forKeyPath:@"emitterCells.smoke.lifetime"];
	[self.layer addSublayer:smokeEmitter];
}

- (void) setUpDust{
    [smokeEmitter setValue:(id) [UIImage imageNamed:@"spark"].CGImage forKeyPath:@"emitterCells.smoke.contents"];
    [smokeEmitter setValue:(id) [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f].CGColor forKeyPath:@"emitterCells.smoke.color"];
}

- (void) setUpClean{
    [smokeEmitter setValue:(id) [UIImage imageNamed:@"spark"].CGImage forKeyPath:@"emitterCells.smoke.contents"];
    [smokeEmitter setValue:(id) [[UIColor whiteColor] colorWithAlphaComponent:0.5f].CGColor forKeyPath:@"emitterCells.smoke.color"];
}

- (void) dealloc{
    smokeEmitter = nil;
}

@end
